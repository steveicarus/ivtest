/*
 * Verify that the continuous assignments support a delay that is
 * greater than 32 bits. The top delays are in seconds and the
 * other delays are in ps. The second delays all require more
 * than 32 bits to work correctly.
 */

`timescale 1s/1s
module gt32b;
  wire real #1 rlval = 1.0;
  wire #2 rval = 1'b1;

  initial begin
    $timeformat(-12, 0, " ps", 16);
  end

  always @(rlval) begin
    $display("rl:gt32b- %t", $realtime);
  end

  always @(rval) begin
    $display("rg:gt32b- %t", $realtime);
  end
endmodule

`timescale 1ps/1ps
module ls32b;
  wire real #1 rlval = 1.0;
  wire #2 rval = 1'b1;

  always @(rlval) begin
    $display("rl:ls32b- %t", $realtime);
  end

  always @(rval) begin
    $display("rg:ls32b- %t", $realtime);
  end
endmodule
