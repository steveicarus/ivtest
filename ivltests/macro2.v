`define TBMESS(str) $display("MSG: %m - %s", str );

 // 1364-2001 S19.3 "The text macro facility is not affected by the compiler
 // directive `resetall."
`resetall

module main;

initial `TBMESS("This is the message for this example.")

endmodule
