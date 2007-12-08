#!/usr/bin/perl -s
#
# Script to handle regression for VPI routines
#
$| = 1;  # This turns off buffered I/O

$regress_fn = "./vpi_regress.list";  # Default regression list.

# Is there a command line argument (alternate regression list)?
if($#ARGV != -1) {
   $regress_fn = $ARGV[0];
   if(!( -e $regress_fn)) {
       die "Error - Command line regression file $regress_fn doesn't exist.\n";
   }
   if(!( -f $regress_fn)) {
       die "Error - Command line regression file $regress_fn is not a file.\n";
   }
   if(!( -r $regress_fn)) {
       die "Error - Command line regression file $regress_fn is not ".
           "readable.\n";
   }
}

#
#  Main script
#
($ver) = `iverilog -V` =~ /^Icarus Verilog version (\d+\.\d+)/;
print ("Running tests for version: $ver.\n");
&read_regression_list;
&execute_regression;

#
#  parses the regression list file
#
#  (from left-to-right in regression file):
#
#  test_name type c/c++_code gold_file c/c++_defines
#
sub read_regression_list {
    open (REGRESS_LIST, "<$regress_fn") or
        die "Error - Unable to open $regress_fn.\n";
    my $tname, $tver, %nameidx;

    while (<REGRESS_LIST>) {
        chomp;
        next if (/^\s*#/);  # Skip comments.
        next if (/^\s*$/);  # Skip blank lines.

        s/#.*$//g;  # Strip in line comments.
        s/\s*$//g;  # Strip trailing white space.
        split(' ', $_, 5);  # If it exists cargs gets all the rest.
        if($#_ < 3) {
           die "Error - $_[0] must have at least 4 arguments.\n";
        }
        $tname = $_[0];
        # Check for a version specific line.
        if ($tname =~ /:/) {
            ($tver, $tname) = split(':', $tname);
            next if ($tver ne "v$ver");  # Skip if this is not our version.
            # This version of the program does not implement something
            # required to run this test.
            if ($_[1] eq "NI") {
                $ccode{$tname}    = "";
                $goldfile{$tname} = "";
                $cargs{$tname}    = "";
            } else {
                $ccode{$tname}    = $_[2];
                $goldfile{$tname} = $_[3];
                $cargs{$tname}    = $_[4];
            }
#            print "Read $tver:$tname=$ccode{$tname},$goldfile{$tname},".
#                  "$cargs{$tname}\n";
        } else {
            next if (exists($ccode{$tname}));  # Skip if already defined.
            $ccode{$tname}    = $_[2];
            $goldfile{$tname} = $_[3];
            $cargs{$tname}    = $_[4];
#            print "Read $tname=$ccode{$tname},$goldfile{$tname},".
#                  "$cargs{$tname}\n";
        }

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
    my $tname, $number, $passed, $failed, $not_impl, $cmd;

    $number = 0;
    $passed = 0;
    $failed = 0;
    $not_impl = 0;

    foreach $tname (@testlist) {
        next if ($tname eq "");  # Skip test that have been replaced.

        $number++;
        print "$tname: ";
        if (-e "vpi_log/$tname.log") {
            unlink "vpi_log/$tname.log" or
                die "Unable to remove old log file vpi_log/$tname.log\n";
        }

        if ($ccode{$tname} eq "") {
            print "Not Implemented.\n";
            $not_impl++;
            next;
        }

        $cmd = "iverilog-vpi --name=$tname $cargs{$tname} ".
               "vpi/$ccode{$tname} > vpi_log/$tname.log ";
        if (system("$cmd")) {
            print "Failed - iverilog-vpi failed.\n";
            $failed++;
            next;
        }

        $cmd = "iverilog -o vsim vpi/$tname.v >> vpi_log/$tname.log 2>&1";
        if (system("$cmd")) {
            print "Failed - iverilog failed.\n";
            $failed++;
            next;
        }

        $cmd = "vvp -M . -m $tname vsim >> vpi_log/$tname.log 2>&1";
        if (system("$cmd")) {
            print "Failed - vvp failed.\n";
            $failed++;
            next;
        }

        $cmd = "diff vpi_gold/$goldfile{$tname} vpi_log/$tname.log > dfile";
        if (system("$cmd")) {
            print "Failed - output does not match gold file.\n";
            $failed++;
            next;
        }

        print "Passed\n";
        $passed++;

    } continue {
        # We have to use system and not unlink here since these files
        # were created by this process and it doesn't seem to know they
        # are not being used.
        if ($tname ne "" and $ccode{$tname} ne "") {
            my $doto = $ccode{$tname};
            $doto =~ s/\.(c|cc|cpp)$/.o/;
            system("rm -f ./$doto ./$tname.vpi ./dfile ./vsim") and
                die "Failed to remove temporary files.\n";
        }
    }

    print "Test results: Total=$number, Passed=$passed, Failed=$failed,".
          " Not Implemented=$not_impl\n";
}
