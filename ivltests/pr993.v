
/*
 * This example is a distillation of the essence of PR#993.
 * Or at least the essence that led to a bug report.
 */

module main;

   integer length;
   wire [31:0] length_bits  = ((length * 8 )/11)+(((length * 8 )%11) != 0);

   initial begin
      for (length = 1 ;  length < 25 ;  length = length + 1)
	 #1 $display("length=%3d, length_bits=%3d", length, length_bits);

      $finish;
   end

endmodule // main
