
// This tests assigning value lists to packed structures

module test #(
   // parameters for array sizes
   parameter WA = 4,  // address dimension size
   parameter WB = 4   // bit     dimension size
)();

   // 2D packed arrays
   logic [WA-1:0] [WB-1:0] array_bg0, array_bg1, array_bg2, array_bg3, array_bg4, array_bg5, array_bg6, array_bg7, array_bg8, array_bg9;  // big endian array
   logic [0:WA-1] [0:WB-1] array_lt0, array_lt1, array_lt2, array_lt3, array_lt4, array_lt5, array_lt6, array_lt7, array_lt8, array_lt9;  // little endian array

   // error counter
   int err = 0;

   initial begin
      array_bg0 = {WA*WB{1'bx}};  array_bg0               <= '{ 3 ,2 ,1, 0 };
      array_bg1 = {WA*WB{1'bx}};  array_bg1               <= '{0:4, 1:5, 2:6, 3:7};
      array_bg2 = {WA*WB{1'bx}};  array_bg2               <= '{default:13};
      array_bg3 = {WA*WB{1'bx}};  array_bg3               <= '{2:15, default:13};
      array_bg4 = {WA*WB{1'bx}};  array_bg4               <= '{WA  {          {WB/2  {2'b10}}  }};
      array_bg5 = {WA*WB{1'bx}};  array_bg5               <= '{WA  { {3'b101, {WB/2-1{2'b10}}} }};
      array_bg6 = {WA*WB{1'bx}};  array_bg6               <= '{WA  {          {WB/2-1{2'b10}}  }};
      array_bg7 = {WA*WB{1'bx}};  array_bg7 [WA/2-1:0   ] <= '{WA/2{          {WB/2  {2'b10}}  }};
      array_bg8 = {WA*WB{1'bx}};  array_bg8 [WA  -1:WA/2] <= '{WA/2{          {WB/2  {2'b01}}  }};
      array_bg9 = {WA*WB{1'bx}};  array_bg9               <= '{cnt+0, cnt+1, cnt+2, cnt+3};
      // check
      if (array_bg0 !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- array_bg0 = 'b%b", array_bg0); err=err+1; end
      if (array_bg1 !== 16'b1111_1111_1111_1111) begin $display("FAILED -- array_bg1 = 'b%b", array_bg1); err=err+1; end
      if (array_bg2 !== 16'bxxxx_xxxx_1111_1111) begin $display("FAILED -- array_bg2 = 'b%b", array_bg2); err=err+1; end
      if (array_bg3 !== 16'b1111_1111_xxxx_xxxx) begin $display("FAILED -- array_bg3 = 'b%b", array_bg3); err=err+1; end
      if (array_bg4 !== 16'bxxxx_xxxx_xxxx_1111) begin $display("FAILED -- array_bg4 = 'b%b", array_bg4); err=err+1; end
      if (array_bg5 !== 16'b1111_xxxx_xxxx_xxxx) begin $display("FAILED -- array_bg5 = 'b%b", array_bg5); err=err+1; end
      if (array_bg6 !== 16'bxxxx_xxxx_xxxx_xx11) begin $display("FAILED -- array_bg6 = 'b%b", array_bg6); err=err+1; end
      if (array_bg7 !== 16'b11xx_xxxx_xxxx_xxxx) begin $display("FAILED -- array_bg7 = 'b%b", array_bg7); err=err+1; end
      if (array_bg8 !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("FAILED -- array_bg8 = 'b%b", array_bg8); err=err+1; end
      if (array_bg9 !== 16'b1xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- array_bg9 = 'b%b", array_bg9); err=err+1; end

      array_lt0 = {WA*WB{1'bx}};  array_lt0               <= '{ 3 ,2 ,1, 0 };
      array_lt1 = {WA*WB{1'bx}};  array_lt1               <= '{0:4, 1:5, 2:6, 3:7};
      array_lt2 = {WA*WB{1'bx}};  array_lt2               <= '{default:13};
      array_lt3 = {WA*WB{1'bx}};  array_lt3               <= '{2:15, default:13};
      array_lt4 = {WA*WB{1'bx}};  array_lt4               <= '{WA  {          {WB/2  {2'b10}}  }};
      array_lt5 = {WA*WB{1'bx}};  array_lt5               <= '{WA  { {3'b101, {WB/2-1{2'b10}}} }};
      array_lt6 = {WA*WB{1'bx}};  array_lt6               <= '{WA  {          {WB/2-1{2'b10}}  }};
      array_lt7 = {WA*WB{1'bx}};  array_lt7 [0   :WA/2-1] <= '{WA/2{          {WB/2  {2'b10}}  }};
      array_lt8 = {WA*WB{1'bx}};  array_lt8 [WA/2:WA  -1] <= '{WA/2{          {WB/2  {2'b01}}  }};
      array_lt9 = {WA*WB{1'bx}};  array_lt9               <= '{cnt+0, cnt+1, cnt+2, cnt+3};
      // check
      if (array_lt0 !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- array_lt0 = 'b%b", array_lt0); err=err+1; end
      if (array_lt1 !== 16'b1111_1111_1111_1111) begin $display("FAILED -- array_lt1 = 'b%b", array_lt1); err=err+1; end
      if (array_lt2 !== 16'bxxxx_xxxx_1111_1111) begin $display("FAILED -- array_lt2 = 'b%b", array_lt2); err=err+1; end
      if (array_lt3 !== 16'b1111_1111_xxxx_xxxx) begin $display("FAILED -- array_lt3 = 'b%b", array_lt3); err=err+1; end
      if (array_lt4 !== 16'bxxxx_xxxx_xxxx_1111) begin $display("FAILED -- array_lt4 = 'b%b", array_lt4); err=err+1; end
      if (array_lt5 !== 16'b1111_xxxx_xxxx_xxxx) begin $display("FAILED -- array_lt5 = 'b%b", array_lt5); err=err+1; end
      if (array_lt6 !== 16'bxxxx_xxxx_xxxx_xx11) begin $display("FAILED -- array_lt6 = 'b%b", array_lt6); err=err+1; end
      if (array_lt7 !== 16'b11xx_xxxx_xxxx_xxxx) begin $display("FAILED -- array_lt7 = 'b%b", array_lt7); err=err+1; end
      if (array_lt8 !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("FAILED -- array_lt8 = 'b%b", array_lt8); err=err+1; end
      if (array_lt9 !== 16'b1xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- array_lt9 = 'b%b", array_lt9); err=err+1; end

      if (err)  $finish();
      else      $display("PASSED");
   end

endmodule // test
