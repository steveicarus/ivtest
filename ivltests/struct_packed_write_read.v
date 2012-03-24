
// This tests unalligned access to packed structures

module test;

   typedef struct packed {
      logic [7:0] high;
      logic [7:0] low;
   } word_t;

   // Declare word1/2/3 as a VARIABLE
   word_t word_se0, word_se1, word_se2, word_se3;
   word_t word_sw0, word_sw1, word_sw2, word_sw3;
   word_t word_sp0, word_sp1, word_sp2, word_sp3;
   word_t word_ep0, word_ep1, word_ep2, word_ep3;

   // access to structure elements
   assign word_se1.high       = {8+0{1'b1}};
   assign word_se1.low        = {8+0{1'b0}};
   assign word_se2.high       = {8+1{1'b1}};
   assign word_se2.low        = {8+1{1'b0}};
   assign word_se3.high       = {8-1{1'b1}};
   assign word_se3.low        = {8-1{1'b0}};
   // access to whole structure
   assign word_sw1            = {16+0{1'b1}};
   assign word_sw2            = {16+1{1'b1}};
   assign word_sw3            = {16-1{1'b1}};
   // access to parts of structure elements
   assign word_ep1.high [3:0] = {4+0{1'b1}};
   assign word_ep1.low  [3:0] = {4+0{1'b0}};
   assign word_ep2.high [3:0] = {4+1{1'b1}};
   assign word_ep2.low  [3:0] = {4+1{1'b0}};
   assign word_ep3.high [3:0] = {4-1{1'b1}};
   assign word_ep3.low  [3:0] = {4-1{1'b0}};
   // access to parts of the whole structure
   assign word_sp1     [11:4] = {8+0{1'b1}};
   assign word_sp2     [11:4] = {8+1{1'b1}};
   assign word_sp3     [11:4] = {8-1{1'b1}};

   initial begin
      #1;
      // access to structure elements
      if (word_se0      !== 16'bxxxxxxxx_xxxxxxxx) begin $display("FAILED -- word_se0      = 'b%b", word_se0     ); $finish; end
      if (word_se1      !== 16'b11111111_00000000) begin $display("FAILED -- word_se1      = 'b%b", word_se1     ); $finish; end
      if (word_se1.high !==  8'b11111111         ) begin $display("FAILED -- word_se1.high = 'b%b", word_se1.high); $finish; end
      if (word_se1.low  !==  8'b00000000         ) begin $display("FAILED -- word_se1.low  = 'b%b", word_se1.low ); $finish; end
      if (word_se2      !== 16'b11111111_00000000) begin $display("FAILED -- word_se2      = 'b%b", word_se2     ); $finish; end
      if (word_se2.high !==  8'b11111111         ) begin $display("FAILED -- word_se2.high = 'b%b", word_se2.high); $finish; end
      if (word_se2.low  !==  8'b00000000         ) begin $display("FAILED -- word_se2.low  = 'b%b", word_se2.low ); $finish; end
      if (word_se3      !== 16'b01111111_00000000) begin $display("FAILED -- word_se3      = 'b%b", word_se3     ); $finish; end
      if (word_se3.high !==  8'b01111111         ) begin $display("FAILED -- word_se3.high = 'b%b", word_se3.high); $finish; end
      if (word_se3.low  !==  8'b00000000         ) begin $display("FAILED -- word_se3.low  = 'b%b", word_se3.low ); $finish; end
      // access to whole structure
      if (word_sw0      !== 16'bxxxxxxxx_xxxxxxxx) begin $display("FAILED -- word_sw0      = 'b%b", word_sw0     ); $finish; end
      if (word_sw1      !== 16'b11111111_11111111) begin $display("FAILED -- word_sw1      = 'b%b", word_sw1     ); $finish; end
      if (word_sw2      !== 16'b11111111_11111111) begin $display("FAILED -- word_sw2      = 'b%b", word_sw2     ); $finish; end
      if (word_sw3      !== 16'b01111111_11111111) begin $display("FAILED -- word_sw3      = 'b%b", word_sw3     ); $finish; end
      // access to parts of structure elements
      if (word_ep0      !== 16'bxxxxxxxx_xxxxxxxx) begin $display("FAILED -- word_ep0      = 'b%b", word_ep0     ); $finish; end
      if (word_ep1      !== 16'bxxxx1111_xxxx0000) begin $display("FAILED -- word_ep1      = 'b%b", word_ep1     ); $finish; end
      if (word_ep1.high !==  8'bxxxx1111         ) begin $display("FAILED -- word_ep1.high = 'b%b", word_ep1.high); $finish; end
      if (word_ep1.low  !==  8'bxxxx0000         ) begin $display("FAILED -- word_ep1.low  = 'b%b", word_ep1.low ); $finish; end
      if (word_ep2      !== 16'bxxxx1111_xxxx0000) begin $display("FAILED -- word_ep2      = 'b%b", word_ep2     ); $finish; end
      if (word_ep2.high !==  8'bxxxx1111         ) begin $display("FAILED -- word_ep2.high = 'b%b", word_ep2.high); $finish; end
      if (word_ep2.low  !==  8'bxxxx0000         ) begin $display("FAILED -- word_ep2.low  = 'b%b", word_ep2.low ); $finish; end
      if (word_ep3      !== 16'bxxxx0111_xxxx0000) begin $display("FAILED -- word_ep3      = 'b%b", word_ep3     ); $finish; end
      if (word_ep3.high !==  8'bxxxx0111         ) begin $display("FAILED -- word_ep3.high = 'b%b", word_ep3.high); $finish; end
      if (word_ep3.low  !==  8'bxxxx0000         ) begin $display("FAILED -- word_ep3.low  = 'b%b", word_ep3.low ); $finish; end
      // access to parts of the whole structure
      if (word_sp0      !== 16'bxxxxxxxx_xxxxxxxx) begin $display("FAILED -- word_sp0      = 'b%b", word_sp0     ); $finish; end
      if (word_sp1      !== 16'bxxxx1111_1111xxxx) begin $display("FAILED -- word_sp1      = 'b%b", word_sp1     ); $finish; end
      if (word_sp2      !== 16'bxxxx1111_1111xxxx) begin $display("FAILED -- word_sp2      = 'b%b", word_sp2     ); $finish; end
      if (word_sp3      !== 16'bxxxx0111_1111xxxx) begin $display("FAILED -- word_sp3      = 'b%b", word_sp3     ); $finish; end

      $display("PASSED");
   end

endmodule // test
