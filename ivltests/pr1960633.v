
module main;

   reg [7:0] foo;

   wire [3:0] below = foo[2:-1];
   wire [3:0] above = foo[8:5];
   wire [9:0] span = foo[8:-1];

   initial begin
      foo = 'h55;
      #1 ;
      if (below !== 4'b101_x) begin
	 $display("FAILED");
	 $finish;
      end
      if (above !== 4'bx_010) begin
	 $display("FAILED");
	 $finish;
      end
      if (span !== 10'bx_01010101_x) begin
	 $display("FAILED");
	 $finish;
      end
      $display("PASSED");
   end

endmodule // main
