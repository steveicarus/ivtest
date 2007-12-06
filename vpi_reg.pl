#!/usr/bin/perl -s
# Script to handle regression for VPI routines 
# 
$| = 1;             # This turns off buffered I/O 
$total_count = 0;
$debug = 1;

$num_opts = $#ARGV ;

if($num_opts ne -1) {
   # Got here cuz there is a command line option
   $regress_fn = $ARGV[0];
   if(!( -e "$regress_fn")) {
       print("Error - Command line option file $num_opts doesn't exist.\n");   
       exit(1);
   }
} else {
   $regress_fn = "./vpi_regress.list";
}


$logdir = "log";
$bindir = "bin";  # not currently used
$report_fn = "./regression_report.txt";

$comp_name = "IVL" ;	# Change the name of the compiler in use here.
                        # this may change to a command line option after
		        		# I get things debugged!

   $vername = "iverilog";	    # IVL's shell 
   $versw   = "";			    # switches
   $verout  = "-o simv -tvvp";	# vvp source output (for IVL ) 
   #$redir = "&>";
   $redir = "> ";

#  Main script

print ("Reading/parsing test list\n");
&read_regression_list;
&rmv_logs ;
&execute_regression;
print ("Checking logfiles\n");
&check_results;

#
# Remove log files
#

sub rmv_logs {
 foreach (@testlist) {
   $cmd = "rm -rf vpilog/$_.log";
   system("$cmd");
 }
}

#
#  parses the regression list file
#
#  (from left-to-right in regression file):
#
#  testname directory vpi_ccode vpi_modname
#
sub read_regression_list {    
    open (REGRESS_LIST, "<$regress_fn");
    local ($found, $testname);

    while (<REGRESS_LIST>) {
	chop;
	if (!/^#/) {
	    # strip out any comments later in the file
	    s/#.*//g;
	    $found = split;
	    if($#_ ne 4) {
	       print "Error - $_[0] doesn't have 5 arguements.\n";
               close (REGRESS_LIST);
	    }
	    $testname            = $_[0];
	    $direct{$testname}   = $_[1];
	    $ccode{$testname}    = $_[2];
	    $modname{$testname}  = $_[3];
	    $vercode{$testname}  = $_[4];
	    #print "Read $direct{$testname}-$ccode{$testname}-$modname{$testname}\n";
	    push (@testlist,$testname);
        }
    }
    close (REGRESS_LIST);
}

#
#  execute_regression sequentially compiles and executes each test in
#  the regression.  Regression is done as a two-pass run (execute, check
#  results) so that at some point the execution part can be parallelized.
#

sub execute_regression {
    local ($testname, $rv);
    local ($bpath, $lpath, $vpath);

    foreach $testname (@testlist) {
        $cmd1 = "iverilog-vpi ".$direct{$testname}."/".$ccode{$testname}.
	         " > vpi_log/$testname.log ";
	print $cmd1,"\n" ;
	system("$cmd1");
	$cmd2 = "iverilog -o vsim ".$direct{$testname}."/".$vercode{$testname}.
	         " >> vpi_log/$testname.log 2>&1";
	print $cmd2,"\n" ;
	system("$cmd2");
	$cmd3 = "vvp -M . -m ".$modname{$testname}." vsim >> vpi_log/$testname.log 2>&1";
	print $cmd3,"\n" ;
	system("$cmd3");
    }
    system("rm -rf ./vsim");
}
sub check_results {

    local ($testname, $error, $number);
    local ($cmd4);
    $error = 0;
    $number = 0;
    foreach $testname (@testlist) {
	    $number++;
            print "$testname:" ;
	    $cmd4 = "diff vpi_gold/$testname.log vpi_log/$testname.log > diff.file";
	    #print $cmd4,"\n";
	    system("$cmd4");
	    if(!(-z "diff.file")) {
                 print "diff files don't match\n";
		 $error++;
            } else {
		 $cmd4 = "$ccode{$testname}";
		 $cmd4 =~ s/\.[^\.]*$/.o/;
		 $cmd4 = "rm -f " . $cmd4 . " $modname{$testname}.vpi";
		 system("$cmd4");
                 print "PASSED\n";
            }
	    # remove the last diff file
            system("rm -rf diff.file");
    }
    print "Tests: Total=$number, failed=$error\n";
}
