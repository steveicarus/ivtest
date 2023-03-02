/*
 * 1364-2001 19.2 "When the `default_nettype is set to none, all nets must be
 * explicitly declared. If a net is not explicitly declared, an error is
 * generated."
 */

`default_nettype none

module bad;
reg a;
assign b=a;
endmodule
