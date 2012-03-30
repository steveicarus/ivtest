
// This tests assigning value lists to packed arrays

module test ();

   // parameters for array sizes
   localparam WA = 4;
   localparam WB = 4;

   // 2D packed arrays
   logic [WA-1:0] [WB-1:0] array_bg0, array_bg1, array_bg2, array_bg3, array_bg4, array_bg5, array_bg6, array_bg7, array_bg8, array_bg9;  // big    endian array
   logic [0:WA-1] [0:WB-1] array_lt0, array_lt1, array_lt2, array_lt3, array_lt4, array_lt5, array_lt6, array_lt7, array_lt8, array_lt9;  // little endian array

   // error counter
   int err = 0;

   initial begin
      array_bg0               = '{ 3 ,2 ,1, 0 };
      array_bg1               = '{0:4, 1:5, 2:6, 3:7};
      array_bg2               = '{default:13};
      array_bg3               = '{2:15, default:13};
      array_bg4               = '{WA  {          {WB/2  {2'b10}}  }};
      array_bg5               = '{WA  { {3'b101, {WB/2-1{2'b10}}} }};
      array_bg6               = '{WA  {          {WB/2-1{2'b10}}  }};
      array_bg7 [WA/2-1:0   ] = '{WA/2{          {WB/2  {2'b10}}  }};
      array_bg8 [WA  -1:WA/2] = '{WA/2{          {WB/2  {2'b01}}  }};
      array_bg9               = '{err+0, err+1, err+2, err+3};
      // check
      if (array_bg0 !== 16'b0011_0010_0001_0000) begin $display("FAILED -- array_bg0 = 'b%b", array_bg0); err=err+1; end
      if (array_bg1 !== 16'b0111_0110_0101_0100) begin $display("FAILED -- array_bg1 = 'b%b", array_bg1); err=err+1; end
      if (array_bg2 !== 16'b1101_1101_1101_1101) begin $display("FAILED -- array_bg2 = 'b%b", array_bg2); err=err+1; end
      if (array_bg3 !== 16'b1101_1111_1101_1101) begin $display("FAILED -- array_bg3 = 'b%b", array_bg3); err=err+1; end
      if (array_bg4 !== 16'b1010_1010_1010_1010) begin $display("FAILED -- array_bg4 = 'b%b", array_bg4); err=err+1; end
      if (array_bg5 !== 16'b0110_0110_0110_0110) begin $display("FAILED -- array_bg5 = 'b%b", array_bg5); err=err+1; end
      if (array_bg6 !== 16'b0010_0010_0010_0010) begin $display("FAILED -- array_bg6 = 'b%b", array_bg6); err=err+1; end
      if (array_bg7 !== 16'bxxxx_xxxx_1010_1010) begin $display("FAILED -- array_bg7 = 'b%b", array_bg7); err=err+1; end
      if (array_bg8 !== 16'b1010_1010_xxxx_xxxx) begin $display("FAILED -- array_bg8 = 'b%b", array_bg8); err=err+1; end
      if (array_bg9 !== 16'b0000_0001_0010_0011) begin $display("FAILED -- array_bg9 = 'b%b", array_bg9); err=err+1; end

      array_lt0               = '{ 3 ,2 ,1, 0 };
      array_lt1               = '{0:4, 1:5, 2:6, 3:7};
      array_lt2               = '{default:13};
      array_lt3               = '{2:15, default:13};
      array_lt4               = '{WA  {          {WB/2  {2'b10}}  }};
      array_lt5               = '{WA  { {3'b101, {WB/2-1{2'b10}}} }};
      array_lt6               = '{WA  {          {WB/2-1{2'b10}}  }};
      array_lt7 [0   :WA/2-1] = '{WA/2{          {WB/2  {2'b10}}  }};
      array_lt8 [WA/2:WA  -1] = '{WA/2{          {WB/2  {2'b01}}  }};
      array_lt9               = '{err+0, err+1, err+2, err+3};
      // check
      if (array_lt0 !== 16'b0011_0010_0001_0000) begin $display("FAILED -- array_lt0 = 'b%b", array_lt0); err=err+1; end
      if (array_lt1 !== 16'b0100_0101_0110_0111) begin $display("FAILED -- array_lt1 = 'b%b", array_lt1); err=err+1; end
      if (array_lt2 !== 16'b1101_1101_1101_1101) begin $display("FAILED -- array_lt2 = 'b%b", array_lt2); err=err+1; end
      if (array_lt3 !== 16'b1101_1101_1111_1101) begin $display("FAILED -- array_lt3 = 'b%b", array_lt3); err=err+1; end
      if (array_lt4 !== 16'b1010_1010_1010_1010) begin $display("FAILED -- array_lt4 = 'b%b", array_lt4); err=err+1; end
      if (array_lt5 !== 16'b0110_0110_0110_0110) begin $display("FAILED -- array_lt5 = 'b%b", array_lt5); err=err+1; end
      if (array_lt6 !== 16'b0010_0010_0010_0010) begin $display("FAILED -- array_lt6 = 'b%b", array_lt6); err=err+1; end
      if (array_lt7 !== 16'b1010_1010_xxxx_xxxx) begin $display("FAILED -- array_lt7 = 'b%b", array_lt7); err=err+1; end
      if (array_lt8 !== 16'bxxxx_xxxx_1010_1010) begin $display("FAILED -- array_lt8 = 'b%b", array_lt8); err=err+1; end
      if (array_lt9 !== 16'b0000_0001_0010_0011) begin $display("FAILED -- array_lt9 = 'b%b", array_lt9); err=err+1; end

      if (err)  $finish();
      else      $display("PASSED");
   end

endmodule // test
