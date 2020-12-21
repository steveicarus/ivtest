`timescale 1ns/1ns
module top;
  real rtrig = 0.0;
  reg itrig = 1'b0;
  wire real rtm;
  wire [31:0] tm, stm;

  assign rtm = rtrig * $realtime;
  assign tm = itrig * $time;
  assign stm = itrig * $stime;

  initial begin
    $monitor(rtm,, tm,, stm);
    #1 itrig = 1'b1; rtrig = 1.0;
    #1 itrig = 1'b0; rtrig = 0.0;
    #1 itrig = 1'b1; rtrig = 1.0;
    #1 itrig = 1'b0; rtrig = 0.0;
  end

endmodule
