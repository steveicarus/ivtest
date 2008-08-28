module top;
  reg signed [63:0] a = 'h12345678abcdabcd;
  reg signed [63:0] b = 'h1234;

  initial
    if (a/b !== 'h10004c017806b)
      $display("FAILED: expected 'h10004c017896b, got 64'h%h", a/b);
    else $display("PASSED");
endmodule
