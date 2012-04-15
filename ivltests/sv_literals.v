// This tests literal values, from verilog 2001 and SystemVerilog
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012 by Iztok Jeras.

module test ();

   // logic vector
   logic unsigned [15:0] luv;  // logic unsigned vector
   logic   signed [15:0] lsv;  // logic   signed vector

   // error counter
   bit err = 0;

   initial begin
      // unsized literals without base
      luv = '0;      if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != '0",     luv); err=1; end
      luv = '1;      if (luv !== 16'b1111_1111_1111_1111) begin $display("FAILED -- luv = 'b%b != '1",     luv); err=1; end
      luv = 'x;      if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'x",     luv); err=1; end
      luv = 'z;      if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'z",     luv); err=1; end

      // unsized binary literals single character
      luv = 'b0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'b0",    luv); err=1; end
      luv = 'b1;     if (luv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- luv = 'b%b != 'b1",    luv); err=1; end
      luv = 'bx;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'bx",    luv); err=1; end
      luv = 'bz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'bz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'b00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'b00",   luv); err=1; end
      luv = 'b11;    if (luv !== 16'b0000_0000_0000_0011) begin $display("FAILED -- luv = 'b%b != 'b11",   luv); err=1; end
      luv = 'bxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'bxx",   luv); err=1; end
      luv = 'bzz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'bzz",   luv); err=1; end
      luv = 'b1x;    if (luv !== 16'b0000_0000_0000_001x) begin $display("FAILED -- luv = 'b%b != 'b1x",   luv); err=1; end
      luv = 'b1z;    if (luv !== 16'b0000_0000_0000_001z) begin $display("FAILED -- luv = 'b%b != 'b1z",   luv); err=1; end
      luv = 'bx1;    if (luv !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("FAILED -- luv = 'b%b != 'bx1",   luv); err=1; end
      luv = 'bz1;    if (luv !== 16'bzzzz_zzzz_zzzz_zzz1) begin $display("FAILED -- luv = 'b%b != 'bz1",   luv); err=1; end

      // unsized binary literals single character
      luv = 'o0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'o0",    luv); err=1; end
      luv = 'o5;     if (luv !== 16'b0000_0000_0000_0101) begin $display("FAILED -- luv = 'b%b != 'o5",    luv); err=1; end
      luv = 'ox;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'ox",    luv); err=1; end
      luv = 'oz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'oz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'o00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'o00",   luv); err=1; end
      luv = 'o55;    if (luv !== 16'b0000_0000_0010_1101) begin $display("FAILED -- luv = 'b%b != 'o55",   luv); err=1; end
      luv = 'oxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'oxx",   luv); err=1; end
      luv = 'ozz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'ozz",   luv); err=1; end
      luv = 'o5x;    if (luv !== 16'b0000_0000_0010_1xxx) begin $display("FAILED -- luv = 'b%b != 'o5x",   luv); err=1; end
      luv = 'o5z;    if (luv !== 16'b0000_0000_0010_1zzz) begin $display("FAILED -- luv = 'b%b != 'o5z",   luv); err=1; end
      luv = 'ox5;    if (luv !== 16'bxxxx_xxxx_xxxx_x101) begin $display("FAILED -- luv = 'b%b != 'ox5",   luv); err=1; end
      luv = 'oz5;    if (luv !== 16'bzzzz_zzzz_zzzz_z101) begin $display("FAILED -- luv = 'b%b != 'oz5",   luv); err=1; end

      // unsized binary literals single character
      luv = 'h0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'h0",    luv); err=1; end
      luv = 'h9;     if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 'h9",    luv); err=1; end
      luv = 'hx;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'hx",    luv); err=1; end
      luv = 'hz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'hz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'h00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'h00",   luv); err=1; end
      luv = 'h99;    if (luv !== 16'b0000_0000_1001_1001) begin $display("FAILED -- luv = 'b%b != 'h99",   luv); err=1; end
      luv = 'hxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'hxx",   luv); err=1; end
      luv = 'hzz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'hzz",   luv); err=1; end
      luv = 'h9x;    if (luv !== 16'b0000_0000_1001_xxxx) begin $display("FAILED -- luv = 'b%b != 'h9x",   luv); err=1; end
      luv = 'h9z;    if (luv !== 16'b0000_0000_1001_zzzz) begin $display("FAILED -- luv = 'b%b != 'h9z",   luv); err=1; end
      luv = 'hx9;    if (luv !== 16'bxxxx_xxxx_xxxx_1001) begin $display("FAILED -- luv = 'b%b != 'hx9",   luv); err=1; end
      luv = 'hz9;    if (luv !== 16'bzzzz_zzzz_zzzz_1001) begin $display("FAILED -- luv = 'b%b != 'hz9",   luv); err=1; end

      // unsized binary literals single character
      luv = 'd0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'd0",    luv); err=1; end
      luv = 'd9;     if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 'd9",    luv); err=1; end
      luv = 'dx;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'dx",    luv); err=1; end
      luv = 'dz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'dz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'd00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'd00",   luv); err=1; end
      luv = 'd99;    if (luv !== 16'b0000_0000_0110_0011) begin $display("FAILED -- luv = 'b%b != 'd99",   luv); err=1; end
//    luv = 'dxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'dxx",   luv); err=1; end
//    luv = 'dzz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'dzz",   luv); err=1; end


      // unsized binary literals single character
      luv = 15'b0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'b0",  luv); err=1; end
      luv = 15'b1;   if (luv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- luv = 'b%b != 15'b1",  luv); err=1; end
      luv = 15'bx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'bx",  luv); err=1; end
      luv = 15'bz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'bz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'b00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'b00", luv); err=1; end
      luv = 15'b11;  if (luv !== 16'b0000_0000_0000_0011) begin $display("FAILED -- luv = 'b%b != 15'b11", luv); err=1; end
      luv = 15'bxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'bxx", luv); err=1; end
      luv = 15'bzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'bzz", luv); err=1; end
      luv = 15'b1x;  if (luv !== 16'b0000_0000_0000_001x) begin $display("FAILED -- luv = 'b%b != 15'b1x", luv); err=1; end
      luv = 15'b1z;  if (luv !== 16'b0000_0000_0000_001z) begin $display("FAILED -- luv = 'b%b != 15'b1z", luv); err=1; end
      luv = 15'bx1;  if (luv !== 16'b0xxx_xxxx_xxxx_xxx1) begin $display("FAILED -- luv = 'b%b != 15'bx1", luv); err=1; end
      luv = 15'bz1;  if (luv !== 16'b0zzz_zzzz_zzzz_zzz1) begin $display("FAILED -- luv = 'b%b != 15'bz1", luv); err=1; end

      // unsized binary literals single character
      luv = 15'o0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'o0",  luv); err=1; end
      luv = 15'o5;   if (luv !== 16'b0000_0000_0000_0101) begin $display("FAILED -- luv = 'b%b != 15'o5",  luv); err=1; end
      luv = 15'ox;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'ox",  luv); err=1; end
      luv = 15'oz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'oz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'o00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'o00", luv); err=1; end
      luv = 15'o55;  if (luv !== 16'b0000_0000_0010_1101) begin $display("FAILED -- luv = 'b%b != 15'o55", luv); err=1; end
      luv = 15'oxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'oxx", luv); err=1; end
      luv = 15'ozz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'ozz", luv); err=1; end
      luv = 15'o5x;  if (luv !== 16'b0000_0000_0010_1xxx) begin $display("FAILED -- luv = 'b%b != 15'o5x", luv); err=1; end
      luv = 15'o5z;  if (luv !== 16'b0000_0000_0010_1zzz) begin $display("FAILED -- luv = 'b%b != 15'o5z", luv); err=1; end
      luv = 15'ox5;  if (luv !== 16'b0xxx_xxxx_xxxx_x101) begin $display("FAILED -- luv = 'b%b != 15'ox5", luv); err=1; end
      luv = 15'oz5;  if (luv !== 16'b0zzz_zzzz_zzzz_z101) begin $display("FAILED -- luv = 'b%b != 15'oz5", luv); err=1; end

      // unsized binary literals single character
      luv = 15'h0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'h0",  luv); err=1; end
      luv = 15'h9;   if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 15'h9",  luv); err=1; end
      luv = 15'hx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'hx",  luv); err=1; end
      luv = 15'hz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'hz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'h00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'h00", luv); err=1; end
      luv = 15'h99;  if (luv !== 16'b0000_0000_1001_1001) begin $display("FAILED -- luv = 'b%b != 15'h99", luv); err=1; end
      luv = 15'hxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'hxx", luv); err=1; end
      luv = 15'hzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'hzz", luv); err=1; end
      luv = 15'h9x;  if (luv !== 16'b0000_0000_1001_xxxx) begin $display("FAILED -- luv = 'b%b != 15'h9x", luv); err=1; end
      luv = 15'h9z;  if (luv !== 16'b0000_0000_1001_zzzz) begin $display("FAILED -- luv = 'b%b != 15'h9z", luv); err=1; end
      luv = 15'hx9;  if (luv !== 16'b0xxx_xxxx_xxxx_1001) begin $display("FAILED -- luv = 'b%b != 15'hx9", luv); err=1; end
      luv = 15'hz9;  if (luv !== 16'b0zzz_zzzz_zzzz_1001) begin $display("FAILED -- luv = 'b%b != 15'hz9", luv); err=1; end

      // unsized binary literals single character
      luv = 15'd0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'd0",  luv); err=1; end
      luv = 15'd9;   if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 15'd9",  luv); err=1; end
      luv = 15'dx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'dx",  luv); err=1; end
      luv = 15'dz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'dz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'd00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'd00", luv); err=1; end
      luv = 15'd99;  if (luv !== 16'b0000_0000_0110_0011) begin $display("FAILED -- luv = 'b%b != 15'd99", luv); err=1; end
//    luv = 15'dxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'dxx", luv); err=1; end
//    luv = 15'dzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'dzz", luv); err=1; end




      // unsized binary literals single character
      lsv = 'sb0;     if (lsv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- lsv = 'b%b != 'sb0",    lsv); err=1; end
      lsv = 'sb1;     if (lsv !== 16'b1111_1111_1111_1111) begin $display("FAILED -- lsv = 'b%b != 'sb1",    lsv); err=1; end
      lsv = 'sbx;     if (lsv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lsv = 'b%b != 'sbx",    lsv); err=1; end
      lsv = 'sbz;     if (lsv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lsv = 'b%b != 'sbz",    lsv); err=1; end
      // unsized binary literals two characters
      luv = 'sb00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'sb00",   luv); err=1; end
      luv = 'sb11;    if (luv !== 16'b1111_1111_1111_1111) begin $display("FAILED -- luv = 'b%b != 'sb11",   luv); err=1; end
      luv = 'sbxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'sbxx",   luv); err=1; end
      luv = 'sbzz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'sbzz",   luv); err=1; end
      luv = 'sb1x;    if (luv !== 16'b1111_1111_1111_111x) begin $display("FAILED -- luv = 'b%b != 'sb1x",   luv); err=1; end
      luv = 'sb1z;    if (luv !== 16'b1111_1111_1111_111z) begin $display("FAILED -- luv = 'b%b != 'sb1z",   luv); err=1; end
      luv = 'sbx1;    if (luv !== 16'bxxxx_xxxx_xxxx_xxx1) begin $display("FAILED -- luv = 'b%b != 'sbx1",   luv); err=1; end
      luv = 'sbz1;    if (luv !== 16'bzzzz_zzzz_zzzz_zzz1) begin $display("FAILED -- luv = 'b%b != 'sbz1",   luv); err=1; end

      // unsized binary literals single character
      luv = 'so0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'so0",    luv); err=1; end
      luv = 'so5;     if (luv !== 16'b1111_1111_1111_1101) begin $display("FAILED -- luv = 'b%b != 'so5",    luv); err=1; end
      luv = 'sox;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'sox",    luv); err=1; end
      luv = 'soz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'soz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'so00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'so00",   luv); err=1; end
      luv = 'so55;    if (luv !== 16'b1111_1111_1110_1101) begin $display("FAILED -- luv = 'b%b != 'so55",   luv); err=1; end
      luv = 'soxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'soxx",   luv); err=1; end
      luv = 'sozz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'sozz",   luv); err=1; end
      luv = 'so5x;    if (luv !== 16'b0000_0000_0010_1xxx) begin $display("FAILED -- luv = 'b%b != 'so5x",   luv); err=1; end
      luv = 'so5z;    if (luv !== 16'b0000_0000_0010_1zzz) begin $display("FAILED -- luv = 'b%b != 'so5z",   luv); err=1; end
      luv = 'sox5;    if (luv !== 16'bxxxx_xxxx_xxxx_x101) begin $display("FAILED -- luv = 'b%b != 'sox5",   luv); err=1; end
      luv = 'soz5;    if (luv !== 16'bzzzz_zzzz_zzzz_z101) begin $display("FAILED -- luv = 'b%b != 'soz5",   luv); err=1; end

      // unsized binary literals single character
      luv = 'sh0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'sh0",    luv); err=1; end
      luv = 'sh9;     if (luv !== 16'b1111_1111_1111_1001) begin $display("FAILED -- luv = 'b%b != 'sh9",    luv); err=1; end
      luv = 'shx;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'shx",    luv); err=1; end
      luv = 'shz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'shz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'sh00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'sh00",   luv); err=1; end
      luv = 'sh99;    if (luv !== 16'b1111_1111_1001_1001) begin $display("FAILED -- luv = 'b%b != 'sh99",   luv); err=1; end
      luv = 'shxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'shxx",   luv); err=1; end
      luv = 'shzz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'shzz",   luv); err=1; end
      luv = 'sh9x;    if (luv !== 16'b0000_0000_1001_xxxx) begin $display("FAILED -- luv = 'b%b != 'sh9x",   luv); err=1; end
      luv = 'sh9z;    if (luv !== 16'b0000_0000_1001_zzzz) begin $display("FAILED -- luv = 'b%b != 'sh9z",   luv); err=1; end
      luv = 'shx9;    if (luv !== 16'bxxxx_xxxx_xxxx_1001) begin $display("FAILED -- luv = 'b%b != 'shx9",   luv); err=1; end
      luv = 'shz9;    if (luv !== 16'bzzzz_zzzz_zzzz_1001) begin $display("FAILED -- luv = 'b%b != 'shz9",   luv); err=1; end

      // unsized binary literals single character
      luv = 'sd0;     if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'sd0",    luv); err=1; end
      luv = 'sd9;     if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 'sd9",    luv); err=1; end
      luv = 'sdx;     if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'sdx",    luv); err=1; end
      luv = 'sdz;     if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'sdz",    luv); err=1; end
      // unsized binary literals two characters
      luv = 'sd00;    if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 'sd00",   luv); err=1; end
      luv = 'sd99;    if (luv !== 16'b0000_0000_0110_0011) begin $display("FAILED -- luv = 'b%b != 'sd99",   luv); err=1; end
//    luv = 'sdxx;    if (luv !== 16'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 'sdxx",   luv); err=1; end
//    luv = 'sdzz;    if (luv !== 16'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 'sdzz",   luv); err=1; end


      // unsized binary literals single character
      luv = 15'sb0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'sb0",  luv); err=1; end
      luv = 15'sb1;   if (luv !== 16'b0000_0000_0000_0001) begin $display("FAILED -- luv = 'b%b != 15'sb1",  luv); err=1; end
      luv = 15'sbx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'sbx",  luv); err=1; end
      luv = 15'sbz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'sbz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'sb00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'sb00", luv); err=1; end
      luv = 15'sb11;  if (luv !== 16'b0000_0000_0000_0011) begin $display("FAILED -- luv = 'b%b != 15'sb11", luv); err=1; end
      luv = 15'sbxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'sbxx", luv); err=1; end
      luv = 15'sbzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'sbzz", luv); err=1; end
      luv = 15'sb1x;  if (luv !== 16'b0000_0000_0000_001x) begin $display("FAILED -- luv = 'b%b != 15'sb1x", luv); err=1; end
      luv = 15'sb1z;  if (luv !== 16'b0000_0000_0000_001z) begin $display("FAILED -- luv = 'b%b != 15'sb1z", luv); err=1; end
      luv = 15'sbx1;  if (luv !== 16'b0xxx_xxxx_xxxx_xxx1) begin $display("FAILED -- luv = 'b%b != 15'sbx1", luv); err=1; end
      luv = 15'sbz1;  if (luv !== 16'b0zzz_zzzz_zzzz_zzz1) begin $display("FAILED -- luv = 'b%b != 15'sbz1", luv); err=1; end

      // unsized binary literals single character
      luv = 15'so0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'so0",  luv); err=1; end
      luv = 15'so5;   if (luv !== 16'b0000_0000_0000_0101) begin $display("FAILED -- luv = 'b%b != 15'so5",  luv); err=1; end
      luv = 15'sox;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'sox",  luv); err=1; end
      luv = 15'soz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'soz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'so00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'so00", luv); err=1; end
      luv = 15'so55;  if (luv !== 16'b0000_0000_0010_1101) begin $display("FAILED -- luv = 'b%b != 15'so55", luv); err=1; end
      luv = 15'soxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'soxx", luv); err=1; end
      luv = 15'sozz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'sozz", luv); err=1; end
      luv = 15'so5x;  if (luv !== 16'b0000_0000_0010_1xxx) begin $display("FAILED -- luv = 'b%b != 15'so5x", luv); err=1; end
      luv = 15'so5z;  if (luv !== 16'b0000_0000_0010_1zzz) begin $display("FAILED -- luv = 'b%b != 15'so5z", luv); err=1; end
      luv = 15'sox5;  if (luv !== 16'b0xxx_xxxx_xxxx_x101) begin $display("FAILED -- luv = 'b%b != 15'sox5", luv); err=1; end
      luv = 15'soz5;  if (luv !== 16'b0zzz_zzzz_zzzz_z101) begin $display("FAILED -- luv = 'b%b != 15'soz5", luv); err=1; end

      // unsized binary literals single character
      luv = 15'sh0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'sh0",  luv); err=1; end
      luv = 15'sh9;   if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 15'sh9",  luv); err=1; end
      luv = 15'shx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'shx",  luv); err=1; end
      luv = 15'shz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'shz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'sh00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'sh00", luv); err=1; end
      luv = 15'sh99;  if (luv !== 16'b0000_0000_1001_1001) begin $display("FAILED -- luv = 'b%b != 15'sh99", luv); err=1; end
      luv = 15'shxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'shxx", luv); err=1; end
      luv = 15'shzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'shzz", luv); err=1; end
      luv = 15'sh9x;  if (luv !== 16'b0000_0000_1001_xxxx) begin $display("FAILED -- luv = 'b%b != 15'sh9x", luv); err=1; end
      luv = 15'sh9z;  if (luv !== 16'b0000_0000_1001_zzzz) begin $display("FAILED -- luv = 'b%b != 15'sh9z", luv); err=1; end
      luv = 15'shx9;  if (luv !== 16'b0xxx_xxxx_xxxx_1001) begin $display("FAILED -- luv = 'b%b != 15'shx9", luv); err=1; end
      luv = 15'shz9;  if (luv !== 16'b0zzz_zzzz_zzzz_1001) begin $display("FAILED -- luv = 'b%b != 15'shz9", luv); err=1; end

      // unsized binary literals single character
      luv = 15'sd0;   if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'sd0",  luv); err=1; end
      luv = 15'sd9;   if (luv !== 16'b0000_0000_0000_1001) begin $display("FAILED -- luv = 'b%b != 15'sd9",  luv); err=1; end
      luv = 15'sdx;   if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'sdx",  luv); err=1; end
      luv = 15'sdz;   if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'sdz",  luv); err=1; end
      // unsized binary literals two characters
      luv = 15'sd00;  if (luv !== 16'b0000_0000_0000_0000) begin $display("FAILED -- luv = 'b%b != 15'sd00", luv); err=1; end
      luv = 15'sd99;  if (luv !== 16'b0000_0000_0110_0011) begin $display("FAILED -- luv = 'b%b != 15'sd99", luv); err=1; end
//    luv = 15'sdxx;  if (luv !== 16'b0xxx_xxxx_xxxx_xxxx) begin $display("FAILED -- luv = 'b%b != 15'sdxx", luv); err=1; end
//    luv = 15'sdzz;  if (luv !== 16'b0zzz_zzzz_zzzz_zzzz) begin $display("FAILED -- luv = 'b%b != 15'sdzz", luv); err=1; end

      if (!err) $display("PASSED");
   end

endmodule // test
