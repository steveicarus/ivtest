
module main;

   integer val;

   initial begin
      val = 0;
      #1 $poke_at_simtime(val, 1, 10);

      #8 if (val !== 0) begin
	 $display("FAILED -- val==%0d before delayed poke", val);
	 $finish;
      end

      #1 if (val !== 1) begin
	 $display("FAILED -- val==%0d: poke didn't happen", val);
	 $finish;
      end

      $display("PASSED");
      $finish;
   end

endmodule // main
