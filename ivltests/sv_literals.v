// This tests literal values, from verilog 2001 and SystemVerilog
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012 by Iztok Jeras.

module test ();

   // logic vector
   logic [15:0] lv;

   // error counter
   bit err = 0;

   initial begin
      // unsized literals without base
      lv = '0;    if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != '0",   lv); err=1; end
      lv = '1;    if (lv !== 16'b1111_1111_1111_1111) begin $display("FAILED -- lv = 'b%b != '1",   lv); err=1; end
      lv = 'x;    if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'x",   lv); err=1; end
      lv = 'z;    if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'z",   lv); err=1; end

      // unsized binary literals single character
      lv = 'b0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'b0",  lv); err=1; end
      lv = 'b1;   if (lv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 'b1",  lv); err=1; end
      lv = 'bx;   if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'bx",  lv); err=1; end
      lv = 'bz;   if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'bz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 'b00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'b00", lv); err=1; end
      lv = 'b11;  if (lv !== 16'b0000_0000_0000_0011) begin $display("FAILED -- lv = 'b%b != 'b11", lv); err=1; end
      lv = 'bxx;  if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'bxx", lv); err=1; end
      lv = 'bzz;  if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'bzz", lv); err=1; end
      lv = 'b1x;  if (lv !== 16'b0000_0000_0000_001x) begin $display("FAILED -- lv = 'b%b != 'b1x", lv); err=1; end
      lv = 'b1z;  if (lv !== 16'b0000_0000_0000_001z) begin $display("FAILED -- lv = 'b%b != 'b1z", lv); err=1; end
      lv = 'bx1;  if (lv !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("FAILED -- lv = 'b%b != 'bx1", lv); err=1; end
      lv = 'bz1;  if (lv !== 16'bzzzz_zzzz_zzzz_zzz1) begin $display("FAILED -- lv = 'b%b != 'bz1", lv); err=1; end

      // unsized binary literals single character
      lv = 'o0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'o0",  lv); err=1; end
      lv = 'o5;   if (lv !== 16'b0000_0000_0000_0101) begin $display("FAILED -- lv = 'b%b != 'o5",  lv); err=1; end
      lv = 'ox;   if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'ox",  lv); err=1; end
      lv = 'oz;   if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'oz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 'o00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'o00", lv); err=1; end
      lv = 'o55;  if (lv !== 16'b0000_0000_0010_1101) begin $display("FAILED -- lv = 'b%b != 'o55", lv); err=1; end
      lv = 'oxx;  if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'oxx", lv); err=1; end
      lv = 'ozz;  if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'ozz", lv); err=1; end
      lv = 'o5x;  if (lv !== 16'b0000_0000_0010_1xxx) begin $display("FAILED -- lv = 'b%b != 'oxx", lv); err=1; end
      lv = 'o5z;  if (lv !== 16'b0000_0000_0010_1zzz) begin $display("FAILED -- lv = 'b%b != 'ozz", lv); err=1; end
      lv = 'ox5;  if (lv !== 16'bxxxx_xxxx_xxxx_x101) begin $display("FAILED -- lv = 'b%b != 'oxx", lv); err=1; end
      lv = 'oz5;  if (lv !== 16'bzzzz_zzzz_zzzz_z101) begin $display("FAILED -- lv = 'b%b != 'ozz", lv); err=1; end

      // unsized binary literals single character
      lv = 'h0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'h0",  lv); err=1; end
      lv = 'h9;   if (lv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 'h9",  lv); err=1; end
      lv = 'hx;   if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'hx",  lv); err=1; end
      lv = 'hz;   if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'hz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 'h00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'h00", lv); err=1; end
      lv = 'h99;  if (lv !== 16'b0000_0000_1001_1001) begin $display("FAILED -- lv = 'b%b != 'h99", lv); err=1; end
      lv = 'hxx;  if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'hxx", lv); err=1; end
      lv = 'hzz;  if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'hzz", lv); err=1; end
      lv = 'h9x;  if (lv !== 16'b0000_0000_1001_xxxx) begin $display("FAILED -- lv = 'b%b != 'hxx", lv); err=1; end
      lv = 'h9z;  if (lv !== 16'b0000_0000_1001_zzzz) begin $display("FAILED -- lv = 'b%b != 'hzz", lv); err=1; end
      lv = 'hx9;  if (lv !== 16'bxxxx_xxxx_xxxx_1001) begin $display("FAILED -- lv = 'b%b != 'hxx", lv); err=1; end
      lv = 'hz9;  if (lv !== 16'bzzzz_zzzz_zzzz_1001) begin $display("FAILED -- lv = 'b%b != 'hzz", lv); err=1; end

      // unsized binary literals single character
      lv = 'd0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'd0",  lv); err=1; end
      lv = 'd9;   if (lv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 'd9",  lv); err=1; end
      lv = 'dx;   if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'dx",  lv); err=1; end
      lv = 'dz;   if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'dz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 'd00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'd00", lv); err=1; end
      lv = 'd99;  if (lv !== 16'b0000_0000_0110_0011) begin $display("FAILED -- lv = 'b%b != 'd99", lv); err=1; end
//    lv = 'dxx;  if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'dxx", lv); err=1; end
//    lv = 'dzz;  if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'dzz", lv); err=1; end


//    the first set of this should be illegal but is accepted in Icarus Verilog
//
//    // unsized literals without base (single character)
//    lv = 15'0;    if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'0",   lv); err=1; end
//    lv = 15'1;    if (lv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 15'1",   lv); err=1; end
//    lv = 15'x;    if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'x",   lv); err=1; end
//    lv = 15'z;    if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'z",   lv); err=1; end
//    // unsized literals without base (two characters)
//    lv = 15'00;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'00",  lv); err=1; end
//    lv = 15'11;   if (lv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 15'11",  lv); err=1; end
//    lv = 15'xx;   if (lv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'xx",  lv); err=1; end
//    lv = 15'zz;   if (lv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'zz",  lv); err=1; end

      // unsized binary literals single character
      lv = 15'b0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'b0",  lv); err=1; end
      lv = 15'b1;   if (lv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 15'b1",  lv); err=1; end
      lv = 15'bx;   if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'bx",  lv); err=1; end
      lv = 15'bz;   if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'bz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 15'b00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'b00", lv); err=1; end
      lv = 15'b11;  if (lv !== 16'b0000_0000_0000_0011) begin $display("FAILED -- lv = 'b%b != 15'b11", lv); err=1; end
      lv = 15'bxx;  if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'bxx", lv); err=1; end
      lv = 15'bzz;  if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'bzz", lv); err=1; end
      lv = 15'b1x;  if (lv !== 16'b0000_0000_0000_001x) begin $display("FAILED -- lv = 'b%b != 15'bxx", lv); err=1; end
      lv = 15'b1z;  if (lv !== 16'b0000_0000_0000_001z) begin $display("FAILED -- lv = 'b%b != 15'bzz", lv); err=1; end
      lv = 15'bx1;  if (lv !== 16'b0xxx_xxxx_xxxx_xxx1) begin $display("FAILED -- lv = 'b%b != 15'bxx", lv); err=1; end
      lv = 15'bz1;  if (lv !== 16'b0zzz_zzzz_zzzz_zzz1) begin $display("FAILED -- lv = 'b%b != 15'bzz", lv); err=1; end

      // unsized binary literals single character
      lv = 15'o0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'o0",  lv); err=1; end
      lv = 15'o5;   if (lv !== 16'b0000_0000_0000_0101) begin $display("FAILED -- lv = 'b%b != 15'o5",  lv); err=1; end
      lv = 15'ox;   if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'ox",  lv); err=1; end
      lv = 15'oz;   if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'oz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 15'o00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'o00", lv); err=1; end
      lv = 15'o55;  if (lv !== 16'b0000_0000_0010_1101) begin $display("FAILED -- lv = 'b%b != 15'o55", lv); err=1; end
      lv = 15'oxx;  if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'oxx", lv); err=1; end
      lv = 15'ozz;  if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'ozz", lv); err=1; end
      lv = 15'o5x;  if (lv !== 16'b0000_0000_0010_1xxx) begin $display("FAILED -- lv = 'b%b != 15'oxx", lv); err=1; end
      lv = 15'o5z;  if (lv !== 16'b0000_0000_0010_1zzz) begin $display("FAILED -- lv = 'b%b != 15'ozz", lv); err=1; end
      lv = 15'ox5;  if (lv !== 16'b0xxx_xxxx_xxxx_x101) begin $display("FAILED -- lv = 'b%b != 15'oxx", lv); err=1; end
      lv = 15'oz5;  if (lv !== 16'b0zzz_zzzz_zzzz_z101) begin $display("FAILED -- lv = 'b%b != 15'ozz", lv); err=1; end

      // unsized binary literals single character
      lv = 15'h0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'h0",  lv); err=1; end
      lv = 15'h9;   if (lv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 15'h9",  lv); err=1; end
      lv = 15'hx;   if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'hx",  lv); err=1; end
      lv = 15'hz;   if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'hz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 15'h00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'h00", lv); err=1; end
      lv = 15'h99;  if (lv !== 16'b0000_0000_1001_1001) begin $display("FAILED -- lv = 'b%b != 15'h99", lv); err=1; end
      lv = 15'hxx;  if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'hxx", lv); err=1; end
      lv = 15'hzz;  if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'hzz", lv); err=1; end
      lv = 15'h9x;  if (lv !== 16'b0000_0000_1001_xxxx) begin $display("FAILED -- lv = 'b%b != 15'hxx", lv); err=1; end
      lv = 15'h9z;  if (lv !== 16'b0000_0000_1001_zzzz) begin $display("FAILED -- lv = 'b%b != 15'hzz", lv); err=1; end
      lv = 15'hx9;  if (lv !== 16'b0xxx_xxxx_xxxx_1001) begin $display("FAILED -- lv = 'b%b != 15'hxx", lv); err=1; end
      lv = 15'hz9;  if (lv !== 16'b0zzz_zzzz_zzzz_1001) begin $display("FAILED -- lv = 'b%b != 15'hzz", lv); err=1; end

      // unsized binary literals single character
      lv = 15'd0;   if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'd0",  lv); err=1; end
      lv = 15'd9;   if (lv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 15'd9",  lv); err=1; end
      lv = 15'dx;   if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'dx",  lv); err=1; end
      lv = 15'dz;   if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'dz",  lv); err=1; end
      // unsized binary literals two characters
      lv = 15'd00;  if (lv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'd00", lv); err=1; end
      lv = 15'd99;  if (lv !== 16'b0000_0000_0110_0011) begin $display("FAILED -- lv = 'b%b != 15'd99", lv); err=1; end
//    lv = 15'dxx;  if (lv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'dxx", lv); err=1; end
//    lv = 15'dzz;  if (lv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'dzz", lv); err=1; end

      if (!err) $display("PASSED");
   end

endmodule // test
