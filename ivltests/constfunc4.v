// Test unary operators in constant functions
module constfunc4();

function [7:0] LAbs(input signed [7:0] x);
  LAbs = abs(x);
endfunction

function real RAbs(input real x);
  RAbs = abs(x);
endfunction

function [7:0] LInv(input [7:0] x);
  LInv = ~x;
endfunction

function [7:0] LNeg(input [7:0] x);
  LNeg = -x;
endfunction

function real RNeg(input real x);
  RNeg = -x;
endfunction

function LAnd(input [7:0] x);
  LAnd = &x;
endfunction

function LNot(input [7:0] x);
  LNot = !x;
endfunction

function RNot(input real x);
  RNot = !x;
endfunction

localparam [7:0] ResultLAb1 = LAbs(8'sh01);
localparam [7:0] ResultLAb2 = LAbs(8'shff);
localparam real  ResultRAb1 = RAbs( 2.0);
localparam real  ResultRAb2 = RAbs(-2.0);
localparam [7:0] ResultLInv = LInv(8'h0f);
localparam [7:0] ResultLNeg = LNeg(8'h0f);
localparam real  ResultRNeg = RNeg(15.0);
localparam       ResultLAnd = LAnd(8'hff);
localparam       ResultLNot = LNot(8'h00);
localparam       ResultRNot = RNot(0.0);

reg failed;

initial begin
  failed = 0;
  $display("%h", ResultLAb1);
  $display("%h", ResultLAb2);
  $display("%g", ResultRAb1);
  $display("%g", ResultRAb2);
  $display("%h", ResultLInv);
  $display("%h", ResultLNeg);
  $display("%g", ResultRNeg);
  $display("%b", ResultLAnd);
  $display("%b", ResultLNot);
  $display("%b", ResultRNot);
  if (ResultLAb1 !== 8'h01) failed = 1;
  if (ResultLAb2 !== 8'h01) failed = 1;
  if (ResultRAb1 !=  2.0)   failed = 1;
  if (ResultRAb2 !=  2.0)   failed = 1;
  if (ResultLNeg !== 8'hf1) failed = 1;
  if (ResultRNeg != -15.0)  failed = 1;
  if (ResultLAnd !== 1'b1)  failed = 1;
  if (ResultLNot !== 1'b1)  failed = 1;
  if (ResultRNot !== 1'b1)  failed = 1;
  if (failed)
    $display("FAILED");
  else
    $display("PASSED");
end

endmodule
