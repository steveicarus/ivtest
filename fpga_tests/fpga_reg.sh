#!/bin/sh

# This script runs the synthesis tests listed in the fpga_reg.list
# list file. The script uses Icarus Verilog from the path, and also
# gets ngdbuild and ngd2ver from the path. The XILINX variable needs
# to point to the XILINX install directory so that the simprims
# can be found. The run test uses these to generate a simulation
# from the synthesized file.

status_file=fpga_reg.txt
true > $status_file

if ! test -d fpga_log
then
    mkdir fpga_log
fi

if ! test -d fpga_tmp
then
    mkdir fpga_tmp
fi

cat fpga_reg.list |
 sed -e 's/#.*//' |
 while read test tb arch part gold junk
 do
    if test "X$test" = "X"
    then
	: skip a comment
    else
	if test "X$part" != "X-"
	then
	    part="-ppart=$part"
	else
	    part=
	fi

	true > fpga_log/$test-$arch.log 2>&1
	EDIF="$test-$arch.edf"

	synth="iverilog -ofpga_tmp/$EDIF -tfpga -parch=$arch $part $test.v"
	echo "synth=$synth"
	eval "$synth" > fpga_log/$test-$arch-synth.log 2>&1
	if test $? != 0
	then
	    echo "$test-$arch: FAILED -- Synthesis error" >> $status_file
	    continue
	fi

	ngdbuild="ngdbuild $EDIF $test.ngd"
	echo "ngdbuild=$ngdbuild"
	(eval "cd fpga_tmp; $ngdbuild") > fpga_log/$test-$arch-build.log 2>&1
	if test $? != 0
	then
	    echo "$test-$arch: FAILED -- ngdbuild error" >> $status_file
	    continue
	fi

	ngd2ver="ngd2ver -w $test.ngd $test.edf.v"
	echo "ngd2ver=$ngd2ver"
	(eval "cd fpga_tmp; $ngd2ver") > fpga_log/$test-$arch-ngd2ver.log 2>&1
	if test $? != 0
	then
	    echo "$test-$arch: FAILED -- ngd2ver error" >> $status_file
	    continue
	fi

	iverilog -oa.out $tb.v fpga_tmp/$test.edf.v $XILINX/verilog/src/glbl.v -y $XILINX/verilog/src/simprims
	if test $? != 0
	then
	    echo "$test-$arch: FAILED -- compiling test bench" >> $status_file
	    continue
	fi

	vvp a.out > fpga_log/$test-$arch.log 2>&1
	if test "X$gold" != "X-" ; then
	    if diff -aq $gold fpga_log/$test-$arch.log > /dev/null
	    then
		echo "$test-$arch: PASSED -- Correct output." >> $status_file
            else
	        echo "$test-$arch: FAILED -- Incorrect output." >> $status_file
	    fi
	else
	    if grep -a -q PASSED fpga_log/$test-$arch.log
	    then
		echo "$test-$arch: PASSED" >> $status_file
	    else
		echo "$test-$arch: FAILED" >> $status_file
	    fi
	fi
	rm a.out
    fi
 done

PASSED=`grep ': PASSED' $status_file | wc -l`
FAILED=`grep ': FAILED' $status_file | wc -l`
echo "PASSED=$PASSED, FAILED=$FAILED" >> $status_file
