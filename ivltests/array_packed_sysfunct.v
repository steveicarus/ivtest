
// This tests assigning value lists to packed structures

module test ();

   // parameters for array sizes
   localparam WA = 4;
   localparam WB = 6;
   localparam WC = 8;

   // 2D packed arrays
   logic [WA-1:0] [WB-1:0] [WC-1:0] array_bg;  // big endian array
   logic [0:WA-1] [0:WB-1] [0:WC-1] array_lt;  // little endian array

   // error counter
   int err = 0;

   // indexing variable
   int i;

   initial begin
      // big endian

      // full array
      if ($dimensions (array_bg) != 3)        begin $display("FAILED -- $dimensions (array_bg) = %d", $dimensions (array_bg)); err=err+1; end;
      if ($bits       (array_bg) != WA*WB*WC) begin $display("FAILED -- $bits       (array_bg) = %d", $bits       (array_bg)); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_bg, dim) != wdt-1) begin $display("FAILED -- $left       (array_bg, dim) = %d", $left       (array_bg, dim)); err=err+1; end;
         if ($right      (array_bg, dim) != 0    ) begin $display("FAILED -- $right      (array_bg, dim) = %d", $right      (array_bg, dim)); err=err+1; end;
         if ($low        (array_bg, dim) != 0    ) begin $display("FAILED -- $low        (array_bg, dim) = %d", $low        (array_bg, dim)); err=err+1; end;
         if ($high       (array_bg, dim) != wdt-1) begin $display("FAILED -- $high       (array_bg, dim) = %d", $high       (array_bg, dim)); err=err+1; end;
         if ($increment  (array_bg, dim) != 1    ) begin $display("FAILED -- $increment  (array_bg, dim) = %d", $increment  (array_bg, dim)); err=err+1; end;
         if ($size       (array_bg, dim) != wdt  ) begin $display("FAILED -- $size       (array_bg, dim) = %d", $size       (array_bg, dim)); err=err+1; end;
      end
      // half array
      if ($dimensions (array_bg[WA/2-1:0]) != 3)          begin $display("FAILED -- $dimensions (array_bg[WA/2-1:0]) = %d", $dimensions (array_bg[WA/2-1:0])); err=err+1; end;
      if ($bits       (array_bg[WA/2-1:0]) != WA/2*WB*WC) begin $display("FAILED -- $bits       (array_bg[WA/2-1:0]) = %d", $bits       (array_bg[WA/2-1:0])); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_bg[WA/2-1:0], dim) != wdt-1) begin $display("FAILED -- $left       (array_bg[WA/2-1:0], dim) = %d", $left       (array_bg[WA/2-1:0], dim)); err=err+1; end;
         if ($right      (array_bg[WA/2-1:0], dim) != 0    ) begin $display("FAILED -- $right      (array_bg[WA/2-1:0], dim) = %d", $right      (array_bg[WA/2-1:0], dim)); err=err+1; end;
         if ($low        (array_bg[WA/2-1:0], dim) != 0    ) begin $display("FAILED -- $low        (array_bg[WA/2-1:0], dim) = %d", $low        (array_bg[WA/2-1:0], dim)); err=err+1; end;
         if ($high       (array_bg[WA/2-1:0], dim) != wdt-1) begin $display("FAILED -- $high       (array_bg[WA/2-1:0], dim) = %d", $high       (array_bg[WA/2-1:0], dim)); err=err+1; end;
         if ($increment  (array_bg[WA/2-1:0], dim) != 1    ) begin $display("FAILED -- $increment  (array_bg[WA/2-1:0], dim) = %d", $increment  (array_bg[WA/2-1:0], dim)); err=err+1; end;
         if ($size       (array_bg[WA/2-1:0], dim) != wdt  ) begin $display("FAILED -- $size       (array_bg[WA/2-1:0], dim) = %d", $size       (array_bg[WA/2-1:0], dim)); err=err+1; end;
      end
      // single array element
      if ($dimensions (array_bg[0]) != 2)     begin $display("FAILED -- $dimensions (array_bg[0]) = %d", $dimensions (array_bg[0])); err=err+1; end;
      if ($bits       (array_bg[0]) != WB*WC) begin $display("FAILED -- $bits       (array_bg[0]) = %d", $bits       (array_bg[0])); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_bg[0], dim-1) != wdt-1) begin $display("FAILED -- $left       (array_bg[0], dim) = %d", $left       (array_bg[0], dim)); err=err+1; end;
         if ($right      (array_bg[0], dim-1) != 0    ) begin $display("FAILED -- $right      (array_bg[0], dim) = %d", $right      (array_bg[0], dim)); err=err+1; end;
         if ($low        (array_bg[0], dim-1) != 0    ) begin $display("FAILED -- $low        (array_bg[0], dim) = %d", $low        (array_bg[0], dim)); err=err+1; end;
         if ($high       (array_bg[0], dim-1) != wdt-1) begin $display("FAILED -- $high       (array_bg[0], dim) = %d", $high       (array_bg[0], dim)); err=err+1; end;
         if ($increment  (array_bg[0], dim-1) != 1    ) begin $display("FAILED -- $increment  (array_bg[0], dim) = %d", $increment  (array_bg[0], dim)); err=err+1; end;
         if ($size       (array_bg[0], dim-1) != wdt  ) begin $display("FAILED -- $size       (array_bg[0], dim) = %d", $size       (array_bg[0], dim)); err=err+1; end;
      end

      // little endian

      // full array
      if ($dimensions (array_lt) != 3)        begin $display("FAILED -- $dimensions (array_lt) = %d", $dimensions (array_lt)); err=err+1; end;
      if ($bits       (array_lt) != WA*WB*WC) begin $display("FAILED -- $bits       (array_lt) = %d", $bits       (array_lt)); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_lt, dim) != 0    ) begin $display("FAILED -- $left       (array_lt, dim) = %d", $left       (array_lt, dim)); err=err+1; end;
         if ($right      (array_lt, dim) != wdt-1) begin $display("FAILED -- $right      (array_lt, dim) = %d", $right      (array_lt, dim)); err=err+1; end;
         if ($low        (array_lt, dim) != 0    ) begin $display("FAILED -- $low        (array_lt, dim) = %d", $low        (array_lt, dim)); err=err+1; end;
         if ($high       (array_lt, dim) != wdt-1) begin $display("FAILED -- $high       (array_lt, dim) = %d", $high       (array_lt, dim)); err=err+1; end;
         if ($increment  (array_lt, dim) != -1   ) begin $display("FAILED -- $increment  (array_lt, dim) = %d", $increment  (array_lt, dim)); err=err+1; end;
         if ($size       (array_lt, dim) != wdt  ) begin $display("FAILED -- $size       (array_lt, dim) = %d", $size       (array_lt, dim)); err=err+1; end;
      end
      // half array
      if ($dimensions (array_lt[0:WA/2-1]) != 3)          begin $display("FAILED -- $dimensions (array_lt[0:WA/2-1]) = %d", $dimensions (array_lt[0:WA/2-1])); err=err+1; end;
      if ($bits       (array_lt[0:WA/2-1]) != WA/2*WB*WC) begin $display("FAILED -- $bits       (array_lt[0:WA/2-1]) = %d", $bits       (array_lt[0:WA/2-1])); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_lt[0:WA/2-1], dim) != 0    ) begin $display("FAILED -- $left       (array_lt[0:WA/2-1], dim) = %d", $left       (array_lt[0:WA/2-1], dim)); err=err+1; end;
         if ($right      (array_lt[0:WA/2-1], dim) != wdt-1) begin $display("FAILED -- $right      (array_lt[0:WA/2-1], dim) = %d", $right      (array_lt[0:WA/2-1], dim)); err=err+1; end;
         if ($low        (array_lt[0:WA/2-1], dim) != 0    ) begin $display("FAILED -- $low        (array_lt[0:WA/2-1], dim) = %d", $low        (array_lt[0:WA/2-1], dim)); err=err+1; end;
         if ($high       (array_lt[0:WA/2-1], dim) != wdt-1) begin $display("FAILED -- $high       (array_lt[0:WA/2-1], dim) = %d", $high       (array_lt[0:WA/2-1], dim)); err=err+1; end;
         if ($increment  (array_lt[0:WA/2-1], dim) != -1   ) begin $display("FAILED -- $increment  (array_lt[0:WA/2-1], dim) = %d", $increment  (array_lt[0:WA/2-1], dim)); err=err+1; end;
         if ($size       (array_lt[0:WA/2-1], dim) != wdt  ) begin $display("FAILED -- $size       (array_lt[0:WA/2-1], dim) = %d", $size       (array_lt[0:WA/2-1], dim)); err=err+1; end;
      end
      // single array element
      if ($dimensions (array_lt[0]) != 2)     begin $display("FAILED -- $dimensions (array_lt) = %d", $dimensions (array_lt)); err=err+1; end;
      if ($bits       (array_lt[0]) != WB*WC) begin $display("FAILED -- $bits       (array_lt) = %d", $bits       (array_lt)); err=err+1; end;
      for (i=1; i<=3; i=i+1) begin
         if ($left       (array_lt[0], dim-1) != 0    ) begin $display("FAILED -- $left       (array_lt[0], dim) = %d", $left       (array_lt[0], dim)); err=err+1; end;
         if ($right      (array_lt[0], dim-1) != wdt-1) begin $display("FAILED -- $right      (array_lt[0], dim) = %d", $right      (array_lt[0], dim)); err=err+1; end;
         if ($low        (array_lt[0], dim-1) != 0    ) begin $display("FAILED -- $low        (array_lt[0], dim) = %d", $low        (array_lt[0], dim)); err=err+1; end;
         if ($high       (array_lt[0], dim-1) != wdt-1) begin $display("FAILED -- $high       (array_lt[0], dim) = %d", $high       (array_lt[0], dim)); err=err+1; end;
         if ($increment  (array_lt[0], dim-1) != -1   ) begin $display("FAILED -- $increment  (array_lt[0], dim) = %d", $increment  (array_lt[0], dim)); err=err+1; end;
         if ($size       (array_lt[0], dim-1) != wdt  ) begin $display("FAILED -- $size       (array_lt[0], dim) = %d", $size       (array_lt[0], dim)); err=err+1; end;
      end

      if (err)  $finish();
      else      $display("PASSED");
   end

endmodule // test
