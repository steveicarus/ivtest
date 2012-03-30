
// This tests system functions operationg on packed arrays

module test ();

   // parameters for array sizes
   localparam WA = 4;
   localparam WB = 6;
   localparam WC = 8;

   function int wdt (input int i);
     wdt = 2 + 2*i;
   endfunction

   // 2D packed arrays
   logic [WA-1:0] [WB-1:0] [WC-1:0] array_bg;  // big    endian array
   logic [0:WA-1] [0:WB-1] [0:WC-1] array_lt;  // little endian array

   // error counter
   int err = 0;

   // indexing variable
   int i;

   initial begin
      // big endian

      // full array
      if ($dimensions (array_bg) != 3)        begin $display("FAILED -- $dimensions (array_bg) = %0d", $dimensions (array_bg)); err=err+1; end;
      if ($bits       (array_bg) != WA*WB*WC) begin $display("FAILED -- $bits       (array_bg) = %0d", $bits       (array_bg)); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_bg          , i) != wdt(i  )-1) begin $display("FAILED -- $left       (array_bg          , %0d) = %0d", i, $left       (array_bg          , i)); err=err+1; end;
         if ($right      (array_bg          , i) != 0         ) begin $display("FAILED -- $right      (array_bg          , %0d) = %0d", i, $right      (array_bg          , i)); err=err+1; end;
         if ($low        (array_bg          , i) != 0         ) begin $display("FAILED -- $low        (array_bg          , %0d) = %0d", i, $low        (array_bg          , i)); err=err+1; end;
         if ($high       (array_bg          , i) != wdt(i  )-1) begin $display("FAILED -- $high       (array_bg          , %0d) = %0d", i, $high       (array_bg          , i)); err=err+1; end;
         if ($increment  (array_bg          , i) != 1         ) begin $display("FAILED -- $increment  (array_bg          , %0d) = %0d", i, $increment  (array_bg          , i)); err=err+1; end;
         if ($size       (array_bg          , i) != wdt(i  )  ) begin $display("FAILED -- $size       (array_bg          , %0d) = %0d", i, $size       (array_bg          , i)); err=err+1; end;
      end
      // half array
      if ($dimensions (array_bg[WA/2-1:0]) != 3)          begin $display("FAILED -- $dimensions (array_bg[WA/2-1:0]) = %0d", $dimensions (array_bg[WA/2-1:0])); err=err+1; end;
      if ($bits       (array_bg[WA/2-1:0]) != WA/2*WB*WC) begin $display("FAILED -- $bits       (array_bg[WA/2-1:0]) = %0d", $bits       (array_bg[WA/2-1:0])); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_bg[WA/2-1:0], i) != wdt(i  )-1) begin $display("FAILED -- $left       (array_bg[WA/2-1:0], %0d) = %0d", i, $left       (array_bg[WA/2-1:0], i)); err=err+1; end;
         if ($right      (array_bg[WA/2-1:0], i) != 0         ) begin $display("FAILED -- $right      (array_bg[WA/2-1:0], %0d) = %0d", i, $right      (array_bg[WA/2-1:0], i)); err=err+1; end;
         if ($low        (array_bg[WA/2-1:0], i) != 0         ) begin $display("FAILED -- $low        (array_bg[WA/2-1:0], %0d) = %0d", i, $low        (array_bg[WA/2-1:0], i)); err=err+1; end;
         if ($high       (array_bg[WA/2-1:0], i) != wdt(i  )-1) begin $display("FAILED -- $high       (array_bg[WA/2-1:0], %0d) = %0d", i, $high       (array_bg[WA/2-1:0], i)); err=err+1; end;
         if ($increment  (array_bg[WA/2-1:0], i) != 1         ) begin $display("FAILED -- $increment  (array_bg[WA/2-1:0], %0d) = %0d", i, $increment  (array_bg[WA/2-1:0], i)); err=err+1; end;
         if ($size       (array_bg[WA/2-1:0], i) != wdt(i  )  ) begin $display("FAILED -- $size       (array_bg[WA/2-1:0], %0d) = %0d", i, $size       (array_bg[WA/2-1:0], i)); err=err+1; end;
      end
      // single array element
      if ($dimensions (array_bg[0]) != 2)     begin $display("FAILED -- $dimensions (array_bg[0]) = %0d", $dimensions (array_bg[0])); err=err+1; end;
      if ($bits       (array_bg[0]) != WB*WC) begin $display("FAILED -- $bits       (array_bg[0]) = %0d", $bits       (array_bg[0])); err=err+1; end;
      for (i=1; i<=2; i=i+1) begin
         if ($left       (array_bg[0]       , i) != wdt(i+1)-1) begin $display("FAILED -- $left       (array_bg[0]       , %0d) = %0d", i, $left       (array_bg[0]       , i)); err=err+1; end;
         if ($right      (array_bg[0]       , i) != 0         ) begin $display("FAILED -- $right      (array_bg[0]       , %0d) = %0d", i, $right      (array_bg[0]       , i)); err=err+1; end;
         if ($low        (array_bg[0]       , i) != 0         ) begin $display("FAILED -- $low        (array_bg[0]       , %0d) = %0d", i, $low        (array_bg[0]       , i)); err=err+1; end;
         if ($high       (array_bg[0]       , i) != wdt(i+1)-1) begin $display("FAILED -- $high       (array_bg[0]       , %0d) = %0d", i, $high       (array_bg[0]       , i)); err=err+1; end;
         if ($increment  (array_bg[0]       , i) != 1         ) begin $display("FAILED -- $increment  (array_bg[0]       , %0d) = %0d", i, $increment  (array_bg[0]       , i)); err=err+1; end;
         if ($size       (array_bg[0]       , i) != wdt(i+1)  ) begin $display("FAILED -- $size       (array_bg[0]       , %0d) = %0d", i, $size       (array_bg[0]       , i)); err=err+1; end;
      end

      // little endian

      // full array
      if ($dimensions (array_lt) != 3)        begin $display("FAILED -- $dimensions (array_lt) = %0d", $dimensions (array_lt)); err=err+1; end;
      if ($bits       (array_lt) != WA*WB*WC) begin $display("FAILED -- $bits       (array_lt) = %0d", $bits       (array_lt)); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_lt          , i) != 0         ) begin $display("FAILED -- $left       (array_lt          , %0d) = %0d", i, $left       (array_lt          , i)); err=err+1; end;
         if ($right      (array_lt          , i) != wdt(i  )-1) begin $display("FAILED -- $right      (array_lt          , %0d) = %0d", i, $right      (array_lt          , i)); err=err+1; end;
         if ($low        (array_lt          , i) != 0         ) begin $display("FAILED -- $low        (array_lt          , %0d) = %0d", i, $low        (array_lt          , i)); err=err+1; end;
         if ($high       (array_lt          , i) != wdt(i  )-1) begin $display("FAILED -- $high       (array_lt          , %0d) = %0d", i, $high       (array_lt          , i)); err=err+1; end;
         if ($increment  (array_lt          , i) != -1        ) begin $display("FAILED -- $increment  (array_lt          , %0d) = %0d", i, $increment  (array_lt          , i)); err=err+1; end;
         if ($size       (array_lt          , i) != wdt(i  )  ) begin $display("FAILED -- $size       (array_lt          , %0d) = %0d", i, $size       (array_lt          , i)); err=err+1; end;
      end
      // half array
      if ($dimensions (array_lt[0:WA/2-1]) != 3)          begin $display("FAILED -- $dimensions (array_lt[0:WA/2-1]) = %0d", $dimensions (array_lt[0:WA/2-1])); err=err+1; end;
      if ($bits       (array_lt[0:WA/2-1]) != WA/2*WB*WC) begin $display("FAILED -- $bits       (array_lt[0:WA/2-1]) = %0d", $bits       (array_lt[0:WA/2-1])); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_lt[0:WA/2-1], i) != 0         ) begin $display("FAILED -- $left       (array_lt[0:WA/2-1], %0d) = %0d", i, $left       (array_lt[0:WA/2-1], i)); err=err+1; end;
         if ($right      (array_lt[0:WA/2-1], i) != wdt(i  )-1) begin $display("FAILED -- $right      (array_lt[0:WA/2-1], %0d) = %0d", i, $right      (array_lt[0:WA/2-1], i)); err=err+1; end;
         if ($low        (array_lt[0:WA/2-1], i) != 0         ) begin $display("FAILED -- $low        (array_lt[0:WA/2-1], %0d) = %0d", i, $low        (array_lt[0:WA/2-1], i)); err=err+1; end;
         if ($high       (array_lt[0:WA/2-1], i) != wdt(i  )-1) begin $display("FAILED -- $high       (array_lt[0:WA/2-1], %0d) = %0d", i, $high       (array_lt[0:WA/2-1], i)); err=err+1; end;
         if ($increment  (array_lt[0:WA/2-1], i) != -1        ) begin $display("FAILED -- $increment  (array_lt[0:WA/2-1], %0d) = %0d", i, $increment  (array_lt[0:WA/2-1], i)); err=err+1; end;
         if ($size       (array_lt[0:WA/2-1], i) != wdt(i  )  ) begin $display("FAILED -- $size       (array_lt[0:WA/2-1], %0d) = %0d", i, $size       (array_lt[0:WA/2-1], i)); err=err+1; end;
      end
      // single array element
      if ($dimensions (array_lt[0]) != 2)     begin $display("FAILED -- $dimensions (array_lt) = %0d", $dimensions (array_lt)); err=err+1; end;
      if ($bits       (array_lt[0]) != WB*WC) begin $display("FAILED -- $bits       (array_lt) = %0d", $bits       (array_lt)); err=err+1; end;
      for (i=1; i<=2; i=i+1) begin
         if ($left       (array_lt[0]       , i) != 0         ) begin $display("FAILED -- $left       (array_lt[0]       , %0d) = %0d", i, $left       (array_lt[0]       , i)); err=err+1; end;
         if ($right      (array_lt[0]       , i) != wdt(i+1)-1) begin $display("FAILED -- $right      (array_lt[0]       , %0d) = %0d", i, $right      (array_lt[0]       , i)); err=err+1; end;
         if ($low        (array_lt[0]       , i) != 0         ) begin $display("FAILED -- $low        (array_lt[0]       , %0d) = %0d", i, $low        (array_lt[0]       , i)); err=err+1; end;
         if ($high       (array_lt[0]       , i) != wdt(i+1)-1) begin $display("FAILED -- $high       (array_lt[0]       , %0d) = %0d", i, $high       (array_lt[0]       , i)); err=err+1; end;
         if ($increment  (array_lt[0]       , i) != -1        ) begin $display("FAILED -- $increment  (array_lt[0]       , %0d) = %0d", i, $increment  (array_lt[0]       , i)); err=err+1; end;
         if ($size       (array_lt[0]       , i) != wdt(i+1)  ) begin $display("FAILED -- $size       (array_lt[0]       , %0d) = %0d", i, $size       (array_lt[0]       , i)); err=err+1; end;
      end

      if (err)  $finish();
      else      $display("PASSED");
   end

endmodule // test
