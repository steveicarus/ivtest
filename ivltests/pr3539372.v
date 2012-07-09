module test;
	parameter x = "String with escaped backslash at end \\";
	initial
`ifdef __ICARUS__
		$display("PASSED");
`endif
endmodule
