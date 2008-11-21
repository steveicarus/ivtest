#
# Module for processing command line arguments, etc.
#

package Environment;

use strict;
use warnings;

our $VERSION = '1.01';

use base 'Exporter';

our @EXPORT = qw(get_suffix get_regress_fn get_ivl_version);

use constant DEF_REGRESS_FN => './regress.list';  # Default regression list.

use constant DEF_SUFFIX => '';  # Default suffix.
use Getopt::Long;

#
# Get the executable/etc. suffix.
#
sub get_suffix {
    my $suffix = DEF_SUFFIX;

    if (!GetOptions("suffix=s" => \$suffix, "help" => \&usage)) {
        die "Error: Invalid argument(s).\n";
    }

    return $suffix;
}

sub usage {
    my $def_sfx = DEF_SUFFIX;
    my $def_reg_fn = DEF_REGRESS_FN;
    warn "$0 usage:\n\n" .
         "  --suffix=<suffix>  # The Icarus executable suffix, " .
         "default \"$def_sfx\".\n" .
         "  <regression file>  # The regression file, " .
         "default \"$def_reg_fn\".\n\n";
    exit;
}

#
# Get the name of the regression list file. Either the default
# or the file specified in the command line arguments.
#
sub get_regress_fn {
    my $regress_fn = DEF_REGRESS_FN;

    # Is there a command line argument (alternate regression list)?
    if ($#ARGV != -1) {
        $regress_fn = $ARGV[0];
        -e "$regress_fn" or
            die "Error: command line regression file $regress_fn doesn't exist.\n";
        -f "$regress_fn" or
            die "Error: command line regression file $regress_fn is not a file.\n";
        -r "$regress_fn" or
            die "Error: command line regression file $regress_fn is not ".
            "readable.\n";
        if ($#ARGV > 0) {
            warn "Warning: only using first file argument to script.\n";
        }
    }

    return $regress_fn;
}

#
# Get the current version from iverilog.
#
sub get_ivl_version {
    my $sfx = shift(@_);
    if (`iverilog$sfx -V` =~ /^Icarus Verilog version (\d+\.\d+)/) {
        return $1;
    }
    else {
        die "Failed to get version from iverilog$sfx -V output";
    }
}

1;  # Module loaded OK
