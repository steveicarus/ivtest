module main;

   reg [1:0] src;
   wire [3:0] dst;

   foo_entity dut (.data_o(dst), .data_i(src));

   initial begin
      src = 2'b00;
      #1 if (dst != 4'b0001) begin
	 $display("FAILED");
	 $finish;
      end

      src = 2'b01;
      #1 if (dst != 4'b0010) begin
	 $display("FAILED");
	 $finish;
      end

      src = 2'b10;
      #1 if (dst != 4'b0100) begin
	 $display("FAILED");
	 $finish;
      end

      src = 2'b11;
      #1 if (dst != 4'b1000) begin
	 $display("FAILED");
	 $finish;
      end

      $display("PASSED");
   end
endmodule // main
