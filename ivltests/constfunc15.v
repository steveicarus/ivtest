// Test array variables inside a constant function
module constfunc14();

function [7:0] concat1(input [7:0] value);

reg [3:0] tmp[1:2];

begin
  {tmp[1], tmp[2]} = {value[3:0], value[7:4]};
  {concat1[3:0], concat1[7:4]} = {tmp[2], tmp[1]};
end

endfunction

localparam res1 = concat1(8'h5a);

reg failed = 0;

initial begin
  $display("%h", res1); if (res1 !== 8'ha5) failed = 1;

  if (failed)
    $display("FAILED");
  else
    $display("PASSED");
end

endmodule
