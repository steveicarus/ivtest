
module main;

   reg src;
   reg clk;
   wire dst0, dst1;

   test #(.parm(0)) test0 (.dst(dst0), .src(src), .clk(clk));
   test #(.parm(1)) test1 (.dst(dst1), .src(src), .clk(clk));

   initial begin
      clk = 0;
      src = 0;
      #1 clk = 1;
      #1 if (dst0 !== 1'b0 || dst1 !== 1'b1) begin
	 $display("FAILED: src=%b, dst0=%b dst1=%b", src, dst0, dst1);
	 $finish;
      end
      clk = 0;
      src = 1;
      #1 clk = 1;
      #1 if (dst0 !== 1'b1 || dst1 !== 1'b0) begin
	 $display("FAILED: src=%b, dst0=%b dst1=%b", src, dst0, dst1);
	 $finish;
      end
      $display("PASSED");
   end // initial begin

endmodule // main
