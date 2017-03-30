#!/usr/bin/perl
#
# Script to handle eegression for normal Verilog files.
#
# This script is based on code with the following Copyright.
#
# Copyright (c) 1999 Guy Hutchison (ghutchis@pacbell.net)
# Copyright (c) 2014 CERN / Maciej Suminski (maciej.suminski@cern.ch)
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
use Parallel::ForkManager;

#
#  Main script
#
my ($suffix, $strict, $with_valg) = &get_args;
my $regress_fn = &get_regress_fn;
&open_report_file;
my $ver = &get_ivl_version($suffix);
my $opt = $strict ? " (strict)" : "";
my $msg = $with_valg ? " (with valgrind)" : "";
my %results = ();
&print_rpt("Running compiler/VVP tests for Icarus Verilog " .
           "version: $ver$opt$msg.\n");
&print_rpt("-" x 76 . "\n");
&read_regression_list($regress_fn, $ver, $strict ? "std" : "");
&execute_regression($suffix, $strict, $with_valg);
&save_results();
&close_report_file;

#
#  execute_regression sequentially compiles and executes each test in
#  the regression. It then checks that the output matches the gold file.
#
sub execute_regression {
    my $sfx = shift(@_);
    my $strict = shift(@_);
    my $with_valg = shift(@_);
    my ($tname, $cmd, $ivl_args, $vvp_args, $diff_file);

    # You can specify the number of used cores as the first argument
    if(defined($ENV{'CPUS'}) and $ENV{'CPUS'} =~ /^\d+$/) {
        $cpus = $ENV{'CPUS'};
    } else { # or it might be autodetected
        $cpus = `cat /proc/cpuinfo | grep "^processor" | wc -l`;
    }
    if($cpus == 0) {
        $cpus = 1;
    }

    $pm = Parallel::ForkManager->new($cpus);
    $pm->run_on_finish(
        # Store the test name and result
        sub {
            my ($pid, $exit_code, $ident, $exit_signal, $core_dump, $data) = @_;
            if(defined($data)) {
                $results{@$data{'name'}} = @$data{'result'};
            }
        }
    );

    # Make sure we have a log and work directory.
    if (! -d 'log') {
        mkdir 'log' or die "Error: unable to create log directory.\n";
    }
    if (! -d 'work') {
        mkdir 'work' or die "Error: unable to create work directory.\n";
    }

    if ($strict) {
        $ivl_args = "-gstrict-expr-width";
        $vvp_args = "-compatible";
    } else {
        $ivl_args = "-D__ICARUS_UNSIZED__";
        $vvp_args = "";
    }

    foreach $tname (@testlist) {
        my $pid = $pm->start() and next;
        my %ret = ();
        my ($pass_type);

        if ($tname eq "") {  # Skip test that have been replaced.
            $pm->finish();
            next;
        }
        $ret{name} = $tname;
        if ($diff{$tname} ne "" and -e $diff{$tname}) {
            unlink $diff{$tname} or
                die "Error: unable to remove old diff file $diff{$tname}.\n";
        }
        if (-e "log/$tname.log") {
            unlink "log/$tname.log" or
                die "Error: unable to remove old log file log/$tname.log.\n";
        }

        if ($testtype{$tname} eq "NI") {
            $ret{result} = "Not Implemented.";
            $pm->finish(0, \%ret);
            next;
        }

        #
        # Build up the iverilog command line and run it.
        #
        $pass_type = 0;
        $cmd = $with_valg ? "valgrind --trace-children=yes " : "";
        $cmd .= "iverilog$sfx -o $tname.vsim $ivl_args $args{$tname}";
        $cmd .= " -s $testmod{$tname}" if ($testmod{$tname} ne "");
        $cmd .= " -t null" if ($testtype{$tname} eq "CN");
        $cmd .= " ./$srcpath{$tname}/$tname.v > log/$tname.log 2>&1";
        #print "$cmd\n";
        if (system("$cmd")) {
            if ($testtype{$tname} eq "CE") {
                # Check if the system command core dumped!
                if ($? >> 8 & 128) {
                    $ret{result} = "==> Failed - CE (core dump).";
                    $pm->finish(0, \%ret);
                    next;
                } else {
                    $pass_type = 1;
                }
            } else {
                $ret{result} = "==> Failed - running iverilog.";
                $pm->finish(0, \%ret);
                next;
            }
        } else {
            if ($testtype{$tname} eq "CE") {
                $ret{result} = "==> Failed - CE (no error reported).";
                $pm->finish(0, \%ret);
                next;
            }
        }

        if ($testtype{$tname} eq "CO") {
            $ret{result} = "Passed - CO.";
            $pm->finish(0, \%ret);
            next;
        }
        if ($testtype{$tname} eq "CN") {
            $ret{result} = "Passed - CN.";
            $pm->finish(0, \%ret);
            next;
        }

        $cmd = $with_valg ? "valgrind --leak-check=full " .
                            "--show-reachable=yes " : "";
        $cmd .= "vvp$sfx $tname.vsim $vvp_args $plargs{$tname} >> log/$tname.log 2>&1";
#        print "$cmd\n";
        if ($pass_type == 0 and system("$cmd")) {
            if ($testtype{$tname} eq "RE") {
                # Check if the system command core dumped!
                if ($? >> 8 & 128) {
                    $ret{result} = "==> Failed - RE (core dump).";
                    $pm->finish(0, \%ret);
                    next;
                } else {
                    $pass_type = 2;
                }
            } else {
                $ret{result} = "==> Failed - running vvp.";
                $pm->finish(0, \%ret);
                next;
            }
        }

        if ($diff{$tname} ne "") {
            $diff_file = $diff{$tname}
        } else {
            if ($pass_type == 1) {
                $ret{result} = "Passed - CE.";
                $pm->finish(0, \%ret);
                next;
            } elsif ($pass_type == 2) {
                $ret{result} = "Passed - RE.";
                $pm->finish(0, \%ret);
                next;
            }
            $diff_file = "log/$tname.log";
        }
#        print "diff $gold{$tname}, $diff_file, $offset{$tname}\n";
        if (diff($gold{$tname}, $diff_file, $offset{$tname})) {
            if ($testtype{$tname} eq "EF") {
                $ret{result} = "Passed - expected fail.";
                $pm->finish(0, \%ret);
                next;
            }
            $result = "==> Failed -";
            if ($pass_type == 1) {
                $result = $result . " CE -";
            } elsif ($pass_type == 2) {
                $result = $result . " RE -";
            }
            $ret{result} = $result . " output does not match gold file.";
            $pm->finish(0, \%ret);
            next;
        }

        if ($pass_type == 1) {
            $ret{result} = "Passed - CE.";
        } elsif ($pass_type == 2) {
            $ret{result} = "Passed - RE.";
        } else {
            $ret{result} = "Passed.";
        }
        $pm->finish(0, \%ret);
    }

    $pm->wait_all_children();
}

sub save_results {
    my ($tname, $len, $total, $passed, $failed, $expected_fail, $not_impl);
    $len = 0;
    $total = 0;
    $passed = 0;
    $failed = 0;
    $expected_fail = 0;
    $not_impl = 0;

    foreach $tname (@testlist) {
        $len = length($tname) if (length($tname) > $len);
    }
    for(sort keys %results) {
        $test_name = sprintf("%${len}s", $_);
        $result = $results{$_};
        &print_rpt("$test_name: $result\n");

        $total++;
        if($result =~ "Passed - expected fail") {
            $expected_fail++;
        } elsif($result =~ "Passed") {
            $passed++;
        } elsif($result =~ "Not Implemented") {
            $not_impl++;
        } elsif($result =~ "==> Failed") {
            $failed++;
        }
    }

    &print_rpt("=" x 76 . "\n");
    &print_rpt("Test results:\n  Total=$total, Passed=$passed, Failed=$failed,".
                " Not Implemented=$not_impl, Expected Fail=$expected_fail\n");

    system("rm -rf *.vsim ivl_vhdl_work");
}

