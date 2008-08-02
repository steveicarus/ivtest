`timescale 1ns/1ps

module top;
  realtime rtime;
  time ctime;

  initial begin
    repeat (5) begin
      $display("%4t %.2f %2d %4t %.2f", $time, $time, $time,
               $realtime, $realtime,, $time,, $realtime);
      #0.6;
    end
  end
endmodule
