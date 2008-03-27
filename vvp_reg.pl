#!/usr/bin/perl
#
# Script to handle regression for normal Verilog files.
#
# This script is based on code with the following Copyright.
#
# Copyright (c) 1999 Guy Hutchison (ghutchis@pacbell.net)
#
#    This source code is free software; you can redistribute it
#    and/or modify it in source code form under the terms of the GNU
#    General Public License as published by the Free Software
#    Foundation; either version 2 of the License, or (at your option)
#    any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA

$| = 1;  # This turns off buffered I/O

$report_fn = "./regression_report.txt";  # Results file.

$regress_fn = "./regress.list";  # Default regression list.

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
}
if ($#ARGV > 0) {
    warn "Warning: only using first argument to script.\n";
}

#
#  Main script
#
open (REGRESS_RPT, ">$report_fn") or
    die "Error: unable to open $report_fn for writing.\n";
($ver) = `iverilog -V` =~ /^Icarus Verilog version (\d+\.\d+)/;
&print_rpt("Running compiler/VVP tests for Icarus Verilog version: $ver.\n");
&print_rpt("-" x 70 . "\n");
&read_regression_list;
&execute_regression;
close (REGRESS_RPT);

#
#  parses the regression list file
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

#
#  execute_regression sequentially compiles and executes each test in
#  the regression. It then checks that the output matches the gold file.
#
sub execute_regression {
    my ($tname, $total, $passed, $failed, $not_impl, $len, $cmd, $diff_file);

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
        &print_rpt(sprintf("%${len}s: ", $tname));
        if ($diff{$tname} ne "" and -e $diff{$tname}) {
            unlink $diff{$tname} or
                die "Error: unable to remove old diff file $diff{$tname}.\n";
        }
        if (-e "log/$tname.log") {
            unlink "log/$tname.log" or
                die "Error: unable to remove old log file log/$tname.log.\n";
        }

        if ($testtype{$tname} eq "NI") {
            &print_rpt("Not Implemented.\n");
            $not_impl++;;
            next;
        }

        #
        # Build up the iverilog command line and run it.
        #
        $cmd = "iverilog -o vsim $args{$tname}";
        $cmd .= " -s $testmod{$tname}" if ($testmod{$tname} ne "");
        $cmd .= " -t null}" if ($testtype{$tname} eq "CN");
        $cmd .= " ./$srcpath{$tname}/$tname.v > log/$tname.log 2>&1";
#        print "$cmd\n";
        if (system("$cmd")) {
            if ($testtype{$tname} eq "CE") {
                # Check if the system command core dumped!
                if ($? >> 8 & 128) {
                    &print_rpt("==> Failed - CE (core dump).\n");
                    $failed++;
                } else {
                    &print_rpt("Passed - CE.\n");
                    $passed++;
                }
                next;
            }
            &print_rpt("==> Failed - running iverilog.\n");
            $failed++;
            next;
        }

        if ($testtype{$tname} eq "CO") {
            &print_rpt("Passed - CO.\n");
            $passed++;
            next;
        }
        if ($testtype{$tname} eq "CN") {
            &print_rpt("Passed - CN.\n");
            $passed++;
            next;
        }

        $cmd = "vvp vsim >> log/$tname.log 2>&1";
#        print "$cmd\n";
        if (system("$cmd")) {
            if ($testtype{$tname} eq "RE") {
                # Check if the system command core dumped!
                if ($? >> 8 & 128) {
                    &print_rpt("==> Failed - RE (core dump).\n");
                    $failed++;
                } else {
                    &print_rpt("Passed - RE.\n");
                    $passed++;
                }
                next;
            }
            &print_rpt("==> Failed - running vvp.\n");
            $failed++;
            next;
        }

        if ($diff{$tname} ne "") {
            $diff_file = $diff{$tname}
        } else {
            $diff_file = "log/$tname.log";
        }
#        print "diff $gold{$tname}, $diff_file, $offset{$tname}\n";
        if (diff($gold{$tname}, $diff_file, $offset{$tname})) {
            &print_rpt("==> Failed - output does not match gold file.\n");
            $failed++;
            next;
        }

        &print_rpt("Passed.\n");
        $passed++;

    } continue {
        if ($tname ne "") {
            system("rm -f ./vsim") and
                die "Error: failed to remove temporary file.\n";
        }
    }

    &print_rpt("=" x 70 . "\n");
    &print_rpt("Test results: Total=$total, Passed=$passed, Failed=$failed,".
               " Not Implemented=$not_impl\n");
}

#
# Print the argument to both the normal output and the report file.
#
sub print_rpt {
    print @_;
    print REGRESS_RPT @_;
}

#
# We only need a simple diff, but we need to strip \r at the end of line.
#
sub diff {
    my ($gold, $log, $skip) = @_;
    my ($diff, $gline, $lline);
    $diff = 0;

    #
    # If we do not have a gold file then we just look for a log file line
    # with just PASSED on it to indicate that the test worked correctly.
    #
    if ($gold eq "") {
        open (LOG, "<$log") or
            die "Error: unable to open $log for reading.\n";

        $diff = 1;
        # Loop on the log file lines looking for a "passed" by it self.
        foreach $lline (<LOG>) {
            if ($lline =~ /^\s*passed\s*$/i) {
                $diff = 0;
            }
        }

        close (LOG);
    } else {
        open (GOLD, "<$gold") or
            die "Error: unable to open $gold for reading.\n";
        open (LOG, "<$log") or
            die "Error: unable to open $log for reading.\n";

        # Loop on the gold file lines.
        foreach $gline (<GOLD>) {
            if (eof LOG) {
                $diff = 1;
                last;
            }
            $lline = <LOG>;
            # Skip initial lines if needed.
            if ($skip > 0) {
                $skip--;
                next;
            }
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
    }

    return $diff
}
