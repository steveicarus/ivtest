`define TBMESS(str) $display("MSG: %m - %s", str );

module main;

initial `TBMESS("This is the message for this example.")

endmodule
