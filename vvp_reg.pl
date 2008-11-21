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

use lib './perl-lib';

use RegressionList;
use Diff;
use Reporting;
use Environment;


#
#  Main script
#
my $suffix = &get_suffix;
my $regress_fn = &get_regress_fn;
&open_report_file;
my $ver = &get_ivl_version($suffix);
&print_rpt("Running compiler/VVP tests for Icarus Verilog version: $ver.\n");
&print_rpt("-" x 70 . "\n");
&read_regression_list($regress_fn, $ver);
&execute_regression($suffix);
&close_report_file;


#
#  execute_regression sequentially compiles and executes each test in
#  the regression. It then checks that the output matches the gold file.
#
sub execute_regression {
    my $sfx = shift(@_);
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
        $cmd = "iverilog$sfx -o vsim $args{$tname}";
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

        $cmd = "vvp$sfx vsim >> log/$tname.log 2>&1";
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
