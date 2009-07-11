`timescale 1s / 1s

timeunit 100us;
timeprecision 1us;

module slow (out);
   output out;
   reg 	  out;

   initial begin
      #0 out = 0;
      #1 out = 1; // 100us
   end

endmodule // slow


module fast (out);
   timeunit 10us;
   timeprecision 1us;
   output out;
   reg 	  out;

   initial begin
      #0 out = 0;
      #1 out = 1; // 10us
   end

endmodule // fast


module sas(out);
   output out;
   reg 	  out;

   initial begin
      #0 out = 0;
      #1 out = 1; // 100us
   end

endmodule // sas

`timescale 1us / 1us
module main;
   reg pass;
   wire slow, fast,sas;

   slow m1 (slow);
   fast m2 (fast);
   sas m3 (sas);

   initial begin
      pass = 1'b1;
      #9;
	if (slow !== 1'b0) begin
	   $display("FAILED: slow at 9us, expected 1'b0, got %b.", slow);
	   pass = 1'b0;
	end
	if (sas !== 1'b0) begin
	   $display("FAILED: sas at 9us, expected 1'b0, got %b.", sas);
	   pass = 1'b0;
	end

        if (fast !== 1'b0) begin
	   $display("FAILED: fast at 9us, expected 1'b0, got %b.", fast);
	   pass = 1'b0;
	end

      #2 // 11us
	if (slow !== 1'b0) begin
	   $display("FAILED: slow at 11us, expected 1'b0, got %b.", slow);
	   pass = 1'b0;
	end

	if (sas !== 1'b0) begin
	   $display("FAILED: sas at 11us, expected 1'b0, got %b.", sas);
	   pass = 1'b0;
	end

        if (fast !== 1'b1) begin
	   $display("FAILED: fast at 11us, expected 1'b1, got %b.", fast);
	   pass = 1'b0;
	end

      #88 // 99 us
	if (slow !== 1'b0) begin
	   $display("FAILED: slow at 99us, expected 1'b0, got %b.", slow);
	   pass = 1'b0;
	end

	if (sas !== 1'b0) begin
	   $display("FAILED: sas at 99us, expected 1'b0, got %b.", sas);
	   pass = 1'b0;
	end

        if (fast !== 1'b1) begin
	   $display("FAILED: fast at 99us, expected 1'b1, got %b.", fast);
	   pass = 1'b0;
	end

      #2 // 101 us
	if (slow !== 1'b1) begin
	   $display("FAILED: slow at 101us, expected 1'b1, got %b.", slow);
	   pass = 1'b0;
	end
	
	if (sas !== 1'b1) begin
	   $display("FAILED: sas at 101us, expected 1'b1, got %b.", sas);
	   pass = 1'b0;
	end

        if (fast !== 1'b1) begin
	   $display("FAILED: fast at 101us, expected 1'b1, got %b.", fast);
	   pass = 1'b0;
	end

      if (pass) $display("PASSED");

   end // initial begin
endmodule // main

