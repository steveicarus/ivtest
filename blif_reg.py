#
# This is a python script for testing the blif code generator with
# programs specifically set aside for it. The general pattern is that
# the test program comes in two parts: the test bench and the device
# to be tested. The files blif/*_tb.v are the test benches for the
# corresponding files blif/*.v.
#
# This script requires the "abc" command available here:
#    <http://www.eecs.berkeley.edu/~alanmi/abc/>
#
# Run this script with the command: python blif_reg.py
#

import os
import subprocess
import re

# This is the name of the iverilog command and vvp command. These may
# vary in different installations.
iverilog = "iverilog"
vvp = "vvp"

list_file = open("blif.list")

# The list file contains a list of test names. The first word in the
# line is the name of the test.
match_prog = re.compile(r"^([a-zA-Z0-9_.]+).*$")

tests = []
for line in list_file:
    if line[0] == "#":
        continue
    match = match_prog.search(line)
    if match:
        tests.append(match.group(1))

list_file.close()

def run_test(test):
    global count_passed, count_failed

    # Assemble the paths for the test-bench and DUT.
    dut = "blif/" + test + ".v"
    tb  = "blif/" + test + "_tb.v"

    # Process the DUT into a .blif file
    ivl_blif_cmd = iverilog + " -g2009 -tblif -otmp_blif.blif " + dut
    subprocess.check_call(ivl_blif_cmd, shell=True)

    # Use ABC to convert the .blif file to Verilog
    abc_cmd = "abc -c 'read_blif tmp_blif.blif ; write_verilog tmp_blif.v'"
    rc = subprocess.check_output(abc_cmd, shell=True);

    # Now simulate to make sure the tranlation worked properly.
    ivl_blif_tb_cmd = iverilog + " -g2009 -otmp_blif.vvp " + tb + " tmp_blif.v"
    subprocess.check_call(ivl_blif_tb_cmd, shell=True)

    vvp_cmd = vvp + " tmp_blif.vvp"
    rc = subprocess.check_output(vvp_cmd, shell=True)

    if rc == "PASSED\n":
        print test, "PASSED"
        count_passed = count_passed + 1
    else:
        print test, "FAILED"
        count_failed = count_failed + 1

    os.remove("tmp_blif.blif")
    os.remove("tmp_blif.v")
    os.remove("tmp_blif.vvp")


count_passed = 0
count_failed = 0

for test in tests:
    run_test(test)

print
print count_passed, "tests passed,", count_failed, "tests failed."
