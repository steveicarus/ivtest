module counter(out, clk, reset);

  parameter WIDTH = 8;

  output [WIDTH-1 : 0] out;
  input            clk, reset;

  reg [WIDTH-1 : 0]   out;
  wire         clk, reset;

  always @(posedge clk)
    out <= out + 1;

  always @(posedge reset)
    force out = 0;

  always @(negedge reset)
    release out;

endmodule // counter
