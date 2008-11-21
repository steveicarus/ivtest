#!/usr/bin/perl
#
# Script to handle regression for VPI routines
#
$| = 1;  # This turns off buffered I/O

# We support a --suffix= flag.
use Getopt::Long;
$sfx = "";  # Default suffix.
if (!GetOptions("suffix=s" => \$sfx, "help" => \&usage)) {
    die "Error: Invalid argument(s).\n";
}

sub usage {
    warn "$0 usage:\n\n" .
         "  --suffix=<suffix>  # The Icarus executables suffix, " .
         "default \"\".\n" .
         "  <regression file>  # The regression file, " .
         "default \"./vpi_regress.list\".\n\n";
    exit;
}

$regress_fn = "./vpi_regress.list";  # Default regression list.

# Is there a command line argument (alternate regression list)?
if ($#ARGV != -1) {
    $regress_fn = $ARGV[0];
    -e $regress_fn or
        die "Error: command line regression file $regress_fn doesn't exist.\n";
    -f $regress_fn or
        die "Error: command line regression file $regress_fn is not a file.\n";
    -r $regress_fn or
        die "Error: command line regression file $regress_fn is not ".
            "readable.\n";

    if ($#ARGV > 0) {
        warn "Warning: only using first file argument to script.\n";
    }
}

#
#  Main script
#
($ver) = `iverilog$sfx -V` =~ /^Icarus Verilog version (\d+\.\d+)/;
print ("Running VPI tests for Icarus Verilog version: $ver.\n");
print "-" x 70 . "\n";
&read_regression_list;
&execute_regression;

#
#  parses the regression list file
#
#  (from left-to-right in regression file):
#
#  test_name type c/c++_code gold_file opt_c/c++_defines
#
sub read_regression_list {
    my ($line, @fields, $tname, $tver, %nameidx);
    open (REGRESS_LIST, "<$regress_fn") or
        die "Error: unable to open $regress_fn for reading.\n";

    while ($line = <REGRESS_LIST>) {
        chomp $line;
        next if ($line =~ /^\s*#/);  # Skip comments.
        next if ($line =~ /^\s*$/);  # Skip blank lines.

        $line =~ s/#.*$//;  # Strip in line comments.
        $line =~ s/\s+$//;  # Strip trailing white space.

        # You must specify at least the first four fields, cargs is optional
        # and gets the rest of the fields if present.
        @fields = split(' ', $line, 5);
        if (@fields < 3) {
            die "Error: $fields[0] must have at least 4 fields.\n";
        }

        $tname = $fields[0];
        # Check for a version specific line.
        if ($tname =~ /:/) {
            ($tver, $tname) = split(':', $tname);
            next if ($tver ne "v$ver");  # Skip if this is not our version.
            # This version of the program does not implement something
            # required to run this test.
            if ($fields[1] eq "NI") {
                $ccode{$tname}    = "";
                $goldfile{$tname} = "";
                $cargs{$tname}    = "";
            } else {
                $ccode{$tname}    = $fields[2];
                $goldfile{$tname} = $fields[3];
                $cargs{$tname}    = $fields[4];
            }
#            print "Read $tver:$tname=$ccode{$tname},$goldfile{$tname},".
#                  "$cargs{$tname}\n";
        } else {
            next if (exists($ccode{$tname}));  # Skip if already defined.
            $ccode{$tname}    = $fields[2];
            $goldfile{$tname} = $fields[3];
            $cargs{$tname}    = $fields[4];
#            print "Read $tname=$ccode{$tname},$goldfile{$tname},".
#                  "$cargs{$tname}\n";
        }
        # If there wasn't a cargs field make it a null string.
        $cargs{$tname} = "" if (!defined($cargs{$tname}));

        # If the name exists this is a replacement so skip the original one.
        if (exists($nameidx{$tname})) {
            splice(@testlist, $nameidx{$tname}, 1, "");
        }
        push (@testlist,$tname);
        $nameidx{$tname} = @testlist - 1;
    }
    close (REGRESS_LIST);
}

#
#  execute_regression sequentially compiles and executes each test in
#  the regression. It then checks that the output matched the gold file.
#
sub execute_regression {
    my ($tname, $total, $passed, $failed, $not_impl, $len, $cmd);

    $total = 0;
    $passed = 0;
    $failed = 0;
    $not_impl = 0;
    $len = 0;

    foreach $tname (@testlist) {
        $len = length($tname) if (length($tname) > $len);
    }

    foreach $tname (@testlist) {
        next if ($tname eq "");  # Skip test that have been replaced.

        $total++;
        printf "%${len}s: ", $tname;
        if (-e "vpi_log/$tname.log") {
            unlink "vpi_log/$tname.log" or
                die "Error: unable to remove old log file ".
                    "vpi_log/$tname.log.\n";
        }

        if ($ccode{$tname} eq "") {
            print "Not Implemented.\n";
            $not_impl++;
            next;
        }

        $cmd = "iverilog-vpi$sfx --name=$tname $cargs{$tname} ".
               "vpi/$ccode{$tname} > vpi_log/$tname.log 2>&1";
        if (system("$cmd")) {
            print "==> Failed - running iverilog-vpi.\n";
            $failed++;
            next;
        }

        $cmd = "iverilog$sfx -o vsim vpi/$tname.v >> vpi_log/$tname.log 2>&1";
        if (system("$cmd")) {
            print "==> Failed - running iverilog.\n";
            $failed++;
            next;
        }

        $cmd = "vvp$sfx -M . -m $tname vsim >> vpi_log/$tname.log 2>&1";
        if (system("$cmd")) {
            print "==> Failed - running vvp.\n";
            $failed++;
            next;
        }

        if (diff("vpi_gold/$goldfile{$tname}", "vpi_log/$tname.log")) {
            print "==> Failed - output does not match gold file.\n";
            $failed++;
            next;
        }

        print "Passed.\n";
        $passed++;

    } continue {
        # We have to use system and not unlink here since these files
        # were created by this process and it doesn't seem to know they
        # are not being used.
        if ($tname ne "" and $ccode{$tname} ne "") {
            my $doto = $ccode{$tname};
            $doto =~ s/\.(c|cc|cpp)$/.o/;
            system("rm -f $doto $tname.vpi vsim") and
                die "Error: failed to remove temporary files.\n";
        }
    }

    print "=" x 70 . "\n";
    print "Test results: Total=$total, Passed=$passed, Failed=$failed,".
          " Not Implemented=$not_impl\n";
}

#
# We only need a simple diff, but we need to strip \r at the end of line.
#
sub diff {
    my ($gold, $log) = @_;
    my ($diff, $gline, $lline);
    $diff = 0;

    open (GOLD, "<$gold") or die "Error: unable to open $gold for reading.\n";
    open (LOG, "<$log") or die "Error: unable to open $log for reading.\n";

    # Loop on the gold file lines.
    foreach $gline (<GOLD>) {
        if (eof LOG) {
            $diff = 1;
            last;
        }
        $lline = <LOG>;
        $lline =~ s/\r\n$/\n/;  # Strip <CR> at the end of line.
        if ($gline ne $lline) {
            $diff = 1;
            last;
        }
    }

    # Check to see if the log file has extra lines.
    $diff = 1 if (!$diff and !eof LOG);

    close (LOG);
    close (GOLD);

    return $diff
}
