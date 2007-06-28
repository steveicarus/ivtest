
// pr1742910

module checktest();

   parameter sum = 1'h1 + 1'h1;

   initial begin
      if (sum !== 2) begin
	 $display("FAILED -- sum = %d", sum);
	 $finish;
      end
      $display("PASSED");
      $finish;
   end

endmodule
