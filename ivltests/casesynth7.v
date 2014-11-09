// We don't support incomplete case statements in asynchronous logic synthesis.
// Such constructs are dangerous in synthesisable code, as in real hardware
// the inferred latch will be sensitive to glitches as the case select value
// changes. Check that the compiler correctly rejects this code.
module mux(

input wire [2:0] sel,
input wire [2:0] i1,
input wire [2:0] i2,
input wire [2:0] i3,
input wire [2:0] i4,
output reg [2:0] o

);

always @* begin
  case (sel)
    0 : o = 0;
    1 : o = i1;
    2 : o = i2;
    3 : o = i3;
    4 : o = i4;
  endcase
end

endmodule
