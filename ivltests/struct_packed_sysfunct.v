
// This tests system functions available for packed structures

module test;

   typedef struct packed {
      logic [7:0] high;
      logic [7:0] low;
   } word_t;

   // Declare word0 as a VARIABLE
   word_t word0;

   // error counter
   int err = 0;

   initial begin
      #1;
      if ($bits(word0     ) !== 16) begin $display("FAILED -- $bits(word0     ) = %d", $bits(word0     )); err=err+1; end
      if ($bits(word0.high) !==  8) begin $display("FAILED -- $bits(word0.high) = %d", $bits(word0.high)); err=err+1; end
      if ($bits(word0.low ) !==  8) begin $display("FAILED -- $bits(word0.low ) = %d", $bits(word0.low )); err=err+1; end

      if (err)  $finish();
      else      $display("PASSED");
   end

endmodule // test
