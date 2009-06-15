module top;
  reg[63:0] a;

  initial begin
    a = 64'h7fe8000000000000;
    // This used to fail because we printed floating point using
    // the default buffer which was only 256 bytes long. To fix
    // this the default size was changed to 512 bytes which can
    // under very contrived formats still fail (%6.300f, %6.600e,
    // etc.) so don't do that.
    $display("%6.3f", $bitstoreal(a));
    $display("PASSED");
  end
endmodule
