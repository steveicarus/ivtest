module test();

reg [4:1] value;

reg failed;

initial begin
  failed = 0;
  value = 4'b0000;
  value[5] = 1'b1;
  $display("%b", value);
  if (value !== 4'b0000) failed = 1;
  value[5:5] = 1'b1;
  $display("%b", value);
  if (value !== 4'b0000) failed = 1;
  value[5:4] = 2'b11;
  $display("%b", value);
  if (value !== 4'b1000) failed = 1;

  if (failed)
    $display("FAILED");
  else
    $display("PASSED");
end

endmodule
