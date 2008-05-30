#
# Module for parsing and loading regression test lists.
#

package RegressionList;

use strict;
use warnings;

our $VERSION = '1.00';

use base 'Exporter';

our @EXPORT = qw(read_regression_list @testlist %srcpath %testtype
                 %args %diff %gold %testmod %offset);

# Properties of each test.
# It may be nicer to have read_regression_list return an array
# of hashes with these as keys.
our (@testlist, %srcpath, %testtype, %args,
     %diff, %gold, %testmod, %offset) = ();

#
#  Parses the regression list file
# 
#  Parameters: 
#    $regress_fn = file name to read tests from.
#    $ver = iverilog version.
#
#  (from left-to-right in regression file):
#
#  test_name type,opt_ivl_args test_dir opt_module_name log/gold_file
#
#  type can be:
#    normal 
#    CO = compile only.
#    CE = compile error.
#    CN = compile null.
#    RE = runtime error.
#    NI = not implemented.
#
sub read_regression_list {
    my $regress_fn = shift 
        or die "No regression list file name specified";
    my $ver = shift
        or die "No iverilog version specified";

    my ($line, @fields, $tname, $tver, %nameidx, $options);
    open (REGRESS_LIST, "<$regress_fn") or
        die "Error: unable to open $regress_fn for reading.\n";

    while ($line = <REGRESS_LIST>) {
        chomp $line;
        next if ($line =~ /^\s*#/);  # Skip comments.
        next if ($line =~ /^\s*$/);  # Skip blank lines.

        $line =~ s/#.*$//;  # Strip in line comments.
        $line =~ s/\s+$//;  # Strip trailing white space.

        @fields = split(' ', $line);
        if (@fields < 2) {
            die "Error: $fields[0] must have at least 3 fields.\n";
        }

        $tname = $fields[0];
        if ($tname =~ /:/) {
            ($tver, $tname) = split(":", $tname);
            next if ($tver ne "v$ver");  # Skip if this is not our version.
        } else {
            next if (exists($testtype{$tname}));  # Skip if already defined.
        }

        # Get the test type and the iverilog argument(s). Separate the
        # arguments with a space.
        ($testtype{$tname},$args{$tname}) = split(',', $fields[1], 2);
        $args{$tname} = "" if (!defined($args{$tname}));
        if ($args{$tname} =~ ',') {
            $args{$tname} = join(' ', split(',', $args{$tname}));
        }

        $srcpath{$tname} = $fields[2];
        $srcpath{$tname} = "" if (!defined($srcpath{$tname}));

        # The four field case.
        if (@fields == 4)  {
           if ($fields[3] =~ s/^diff=//) {
               $testmod{$tname} = "" ;
               ($diff{$tname}, $gold{$tname}, $offset{$tname}) =
                   split(':', $fields[3]);
               # Make sure this is numeric if it is not given.
               if (!$offset{$tname}) {
                   $offset{$tname} = 0;
               }
           } elsif ($fields[3] =~ s/^gold=//) {
               $testmod{$tname} = "" ;
               $diff{$tname} = "";
               $gold{$tname} = "gold/$fields[3]";
               $offset{$tname} = 0;
           } else {
               $testmod{$tname} = $fields[3];
               $diff{$tname} = "";
               $gold{$tname} = "";
               $offset{$tname} = 0;
           }
        # The five field case.
        } elsif (@fields == 5) {
           $testmod{$tname} = $fields[3];
           ($diff{$tname}, $gold{$tname}, $offset{$tname}) =
               split(':', $fields[4]);
           # Make sure this is numeric if it is not given.
           $diff{$tname} =~ s/^diff=//;
           if (!$offset{$tname}) {
               $offset{$tname} = 0;
           }
        } else {
           $testmod{$tname} = "";
           $diff{$tname} = "";
           $gold{$tname} = "";
           $offset{$tname} = 0;
        }

        # If the name exists this is a replacement so skip the original one.
        if (exists($nameidx{$tname})) {
            splice(@testlist, $nameidx{$tname}, 1, "");
        }
        push (@testlist, $tname);
        $nameidx{$tname} = @testlist - 1;
    }

    close (REGRESS_LIST);
}

1;   # Module loaded OK
