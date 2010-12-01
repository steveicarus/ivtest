
module main;

   shortint foo, bar = 10;

   shortint wire_res;
   shortint var_res;

   assign wire_res = foo*bar;
   initial begin
      foo = 9;
      var_res = foo * bar;
      $display("%0d * %0d = %0d %0d %0d", foo, bar, foo * bar, wire_res, var_res);

      if ((foo * bar) !== 90) begin
	 $display("FAILED");
	 $finish;
      end

      if (wire_res !== 90) begin
	 $display("FAILED");
	 $finish;
      end

      if (var_res !== 90) begin
	 $display("FAILED");
	 $finish;
      end

      $display("PASSED");
   end

endmodule // main
