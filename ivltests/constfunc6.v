// Test system function calls in constant functions
module constfunc6();

function [7:0] clog2(input [7:0] a);
  clog2 = $clog2(a);
endfunction

function real log10(input [7:0] a);
  log10 = $log10(a);
endfunction

function real sqrt(input real a);
  sqrt = $sqrt(a);
endfunction

function real pow_i(input [7:0] a, input [7:0] b);
  pow_i = $pow(a, b);
endfunction

function real pow_r(input real a, input real b);
  pow_r = $pow(a, b);
endfunction

function signed [7:0] abs_i(input signed [7:0] a);
  abs_i = $abs(a);
endfunction

function real abs_r(input real a);
  abs_r = $abs(a);
endfunction

function [7:0] min_i(input [7:0] a, input [7:0] b);
  min_i = $min(a, b);
endfunction

function [7:0] max_i(input [7:0] a, input [7:0] b);
  max_i = $max(a, b);
endfunction

function real min_r(input real a, input real b);
  min_r = $min(a, b);
endfunction

function real max_r(input real a, input real b);
  max_r = $max(a, b);
endfunction

localparam [7:0] clog2Result = clog2(25);

localparam real  log10Result = log10(100);

localparam real   sqrtResult =  sqrt(25.0);

localparam [7:0]  powIResult = pow_i(4, 3);

localparam [7:0]  absIResult = abs_i(-25);

localparam [7:0]  minIResult = min_i(25, 30);
localparam [7:0]  maxIResult = max_i(25, 30);

localparam real   powRResult = pow_r(4.0, 3.0);

localparam real   absRResult = abs_r(-25.0);

localparam real   minRResult = min_r(25.0, 30.0);
localparam real   maxRResult = max_r(25.0, 30.0);

reg failed;

initial begin
  failed = 0;
  $display("%0d", clog2Result);
  $display("%0g", log10Result);
  $display("%0g",  sqrtResult);
  $display("%0d",  powIResult);
  $display("%0g",  powRResult);
  $display("%0d",  absIResult);
  $display("%0g",  absRResult);
  $display("%0d",  minIResult);
  $display("%0g",  minRResult);
  $display("%0d",  maxIResult);
  $display("%0g",  maxRResult);
  if (clog2Result !== 8'd5)  failed = 1;
  if (log10Result !=  2.0)   failed = 1;
  if ( sqrtResult !=  5.0)   failed = 1;
  if ( powIResult !== 8'd64) failed = 1;
  if ( powRResult !=  64.0)  failed = 1;
  if ( absIResult !== 8'd25) failed = 1;
  if ( absRResult !=  25.0)  failed = 1;
  if ( minIResult !== 8'd25) failed = 1;
  if ( minRResult !=  25.0)  failed = 1;
  if ( maxIResult !== 8'd30) failed = 1;
  if ( maxRResult !=  30.0)  failed = 1;
  if (failed)
    $display("FAILED");
  else
    $display("PASSED");
end

endmodule
