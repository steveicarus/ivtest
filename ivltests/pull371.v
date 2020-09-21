
typedef enum { A, B } E;

module main;
   E in;
   wire E out;

   M foo (in, out);

   initial begin
      in = A;
      #1 if (out !== A) begin
	 $display("FAIL: in=%0d, out=%0d", in, out);
	 $finish;
      end

      in = B;
      #1 if (out !== B) begin
	 $display("FAIL: in=%0d, out=%0d", in, out);
	 $finish;
      end

      $display("PASSED");
      $finish;
   end
endmodule // main

module M (input  E ei,
	  output E eo);

   always_comb eo = ei;

endmodule // M
