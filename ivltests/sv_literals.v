
// This tests assigning value lists to packed arrays

module test ();

   // logic vector
   logic [15:0] lv;

   // error detection
   bit pass = 1;

   initial begin
      // unsized literals without base
      lv = '0;    if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != '0",   lv); pass=0; end
      lv = '1;    if (lv !== 'b1111_1111_1111_1111) begin $display("FAILED -- lv = 'b%b != '1",   lv); pass=0; end
      lv = 'x;    if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'x",   lv); pass=0; end
      lv = 'z;    if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'z",   lv); pass=0; end

      // unsized binary literals single character
      lv = 'b0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'b0",  lv); pass=0; end
      lv = 'b1;   if (lv !== 'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 'b1",  lv); pass=0; end
      lv = 'bx;   if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'bx",  lv); pass=0; end
      lv = 'bz;   if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'bz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'b00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'b00", lv); pass=0; end
      lv = 'b11;  if (lv !== 'b0000_0000_0000_0011) begin $display("FAILED -- lv = 'b%b != 'b11", lv); pass=0; end
      lv = 'bxx;  if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'bxx", lv); pass=0; end
      lv = 'bzz;  if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'bzz", lv); pass=0; end
      lv = 'b1x;  if (lv !== 'b0000_0000_0000_001x) begin $display("FAILED -- lv = 'b%b != 'b1x", lv); pass=0; end
      lv = 'b1z;  if (lv !== 'b0000_0000_0000_001z) begin $display("FAILED -- lv = 'b%b != 'b1z", lv); pass=0; end
      lv = 'bx1;  if (lv !== 'bxxxx_xxxx_xxxx_xxx1) begin $display("FAILED -- lv = 'b%b != 'bx1", lv); pass=0; end
      lv = 'bz1;  if (lv !== 'bzzzz_zzzz_zzzz_zzz1) begin $display("FAILED -- lv = 'b%b != 'bz1", lv); pass=0; end

      // unsized binary literals single character
      lv = 'o0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'o0",  lv); pass=0; end
      lv = 'o5;   if (lv !== 'b0000_0000_0000_0101) begin $display("FAILED -- lv = 'b%b != 'o5",  lv); pass=0; end
      lv = 'ox;   if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'ox",  lv); pass=0; end
      lv = 'oz;   if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'oz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'o00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'o00", lv); pass=0; end
      lv = 'o55;  if (lv !== 'b0000_0000_0010_1101) begin $display("FAILED -- lv = 'b%b != 'o55", lv); pass=0; end
      lv = 'oxx;  if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'oxx", lv); pass=0; end
      lv = 'ozz;  if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'ozz", lv); pass=0; end

      // unsized binary literals single character
      lv = 'h0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'h0",  lv); pass=0; end
      lv = 'h9;   if (lv !== 'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 'h9",  lv); pass=0; end
      lv = 'hx;   if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'hx",  lv); pass=0; end
      lv = 'hz;   if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'hz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'h00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'h00", lv); pass=0; end
      lv = 'h99;  if (lv !== 'b0000_0000_1001_1001) begin $display("FAILED -- lv = 'b%b != 'h99", lv); pass=0; end
      lv = 'hxx;  if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'hxx", lv); pass=0; end
      lv = 'hzz;  if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'hzz", lv); pass=0; end

      // unsized binary literals single character
      lv = 'd0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'd0",  lv); pass=0; end
      lv = 'd9;   if (lv !== 'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 'd9",  lv); pass=0; end
      lv = 'dx;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 'dx",  lv); pass=0; end
      lv = 'dz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 'dz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'd00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'd00", lv); pass=0; end
      lv = 'd99;  if (lv !== 'b0000_0000_0110_0011) begin $display("FAILED -- lv = 'b%b != 'd99", lv); pass=0; end
//    lv = 'dxx;  if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'dxx", lv); pass=0; end
//    lv = 'dzz;  if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'dzz", lv); pass=0; end


      // unsized literals without base (single character)
      lv = 15'0;    if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'0",   lv); pass=0; end
      lv = 15'1;    if (lv !== 'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 15'1",   lv); pass=0; end
      lv = 15'x;    if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'x",   lv); pass=0; end
      lv = 15'z;    if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'z",   lv); pass=0; end
      // unsized literals without base (two characters)
//    lv = 15'00;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'00",  lv); pass=0; end
//    lv = 15'11;   if (lv !== 'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 15'11",  lv); pass=0; end
//    lv = 15'xx;   if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'xx",  lv); pass=0; end
//    lv = 15'zz;   if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'zz",  lv); pass=0; end

      // unsized binary literals single character
      lv = 15'b0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'b0",  lv); pass=0; end
      lv = 15'b1;   if (lv !== 'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 15'b1",  lv); pass=0; end
      lv = 15'bx;   if (lv !== 'b0000_0000_0000_00xx) begin $display("FAILED -- lv = 'b%b != 15'bx",  lv); pass=0; end
      lv = 15'bz;   if (lv !== 'b0000_0000_0000_000z) begin $display("FAILED -- lv = 'b%b != 15'bz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 15'b00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'b00", lv); pass=0; end
      lv = 15'b11;  if (lv !== 'b0000_0000_0000_0011) begin $display("FAILED -- lv = 'b%b != 15'b11", lv); pass=0; end
      lv = 15'bxx;  if (lv !== 'b0000_0000_0000_00xx) begin $display("FAILED -- lv = 'b%b != 15'bxx", lv); pass=0; end
      lv = 15'bzz;  if (lv !== 'b0000_0000_0000_00zz) begin $display("FAILED -- lv = 'b%b != 15'bzz", lv); pass=0; end

      // unsized binary literals single character
      lv = 15'o0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'o0",  lv); pass=0; end
      lv = 15'o5;   if (lv !== 'b0000_0000_0000_0101) begin $display("FAILED -- lv = 'b%b != 15'o5",  lv); pass=0; end
      lv = 15'ox;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 15'ox",  lv); pass=0; end
      lv = 15'oz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 15'oz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 15'o00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'o00", lv); pass=0; end
      lv = 15'o55;  if (lv !== 'b0000_0000_0010_1101) begin $display("FAILED -- lv = 'b%b != 15'o55", lv); pass=0; end
      lv = 15'oxx;  if (lv !== 'b0000_0000_00xx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'oxx", lv); pass=0; end
      lv = 15'ozz;  if (lv !== 'b0000_0000_00zz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'ozz", lv); pass=0; end

      // unsized binary literals single character
      lv = 15'h0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'h0",  lv); pass=0; end
      lv = 15'h9;   if (lv !== 'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 15'h9",  lv); pass=0; end
      lv = 15'hx;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 15'hx",  lv); pass=0; end
      lv = 15'hz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 15'hz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 15'h00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'h00", lv); pass=0; end
      lv = 15'h99;  if (lv !== 'b0000_0000_1001_1001) begin $display("FAILED -- lv = 'b%b != 15'h99", lv); pass=0; end
      lv = 15'hxx;  if (lv !== 'b0000_0000_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'hxx", lv); pass=0; end
      lv = 15'hzz;  if (lv !== 'b0000_0000_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'hzz", lv); pass=0; end

      // unsized binary literals single character
      lv = 15'd0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'd0",  lv); pass=0; end
      lv = 15'd9;   if (lv !== 'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 15'd9",  lv); pass=0; end
      lv = 15'dx;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 15'dx",  lv); pass=0; end
      lv = 15'dz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 15'dz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 15'd00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 15'd00", lv); pass=0; end
      lv = 15'd99;  if (lv !== 'b0000_0000_0110_0011) begin $display("FAILED -- lv = 'b%b != 15'd99", lv); pass=0; end
//    lv = 15'dxx;  if (lv !== 'b0000_0000_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 15'dxx", lv); pass=0; end
//    lv = 15'dzz;  if (lv !== 'b0000_0000_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 15'dzz", lv); pass=0; end


/*
      // unsized literals without base
      lv = '0;    if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != '0",   lv); pass=0; end
      lv = '1;    if (lv !== 'b1111_1111_1111_1111) begin $display("FAILED -- lv = 'b%b != '1",   lv); pass=0; end
      lv = 'x;    if (lv !== 'bxxxx_xxxx_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'x",   lv); pass=0; end
      lv = 'z;    if (lv !== 'bzzzz_zzzz_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'z",   lv); pass=0; end

      // unsized binary literals single character
      lv = s'b0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'b0",  lv); pass=0; end
      lv = s'b1;   if (lv !== 'b0000_0000_0000_0001) begin $display("FAILED -- lv = 'b%b != 'b1",  lv); pass=0; end
      lv = s'bx;   if (lv !== 'b0000_0000_0000_00xx) begin $display("FAILED -- lv = 'b%b != 'bx",  lv); pass=0; end
      lv = s'bz;   if (lv !== 'b0000_0000_0000_000z) begin $display("FAILED -- lv = 'b%b != 'bz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'b00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'b00", lv); pass=0; end
      lv = 'b11;  if (lv !== 'b0000_0000_0000_0011) begin $display("FAILED -- lv = 'b%b != 'b11", lv); pass=0; end
      lv = 'bxx;  if (lv !== 'b0000_0000_0000_00xx) begin $display("FAILED -- lv = 'b%b != 'bxx", lv); pass=0; end
      lv = 'bzz;  if (lv !== 'b0000_0000_0000_00zz) begin $display("FAILED -- lv = 'b%b != 'bzz", lv); pass=0; end

      // unsized binary literals single character
      lv = 'o0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'o0",  lv); pass=0; end
      lv = 'o5;   if (lv !== 'b0000_0000_0000_0101) begin $display("FAILED -- lv = 'b%b != 'o5",  lv); pass=0; end
      lv = 'ox;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 'ox",  lv); pass=0; end
      lv = 'oz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 'oz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'o00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'o00", lv); pass=0; end
      lv = 'o55;  if (lv !== 'b0000_0000_0010_1101) begin $display("FAILED -- lv = 'b%b != 'o55", lv); pass=0; end
      lv = 'oxx;  if (lv !== 'b0000_0000_00xx_xxxx) begin $display("FAILED -- lv = 'b%b != 'oxx", lv); pass=0; end
      lv = 'ozz;  if (lv !== 'b0000_0000_00zz_zzzz) begin $display("FAILED -- lv = 'b%b != 'ozz", lv); pass=0; end

      // unsized binary literals single character
      lv = 'h0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'h0",  lv); pass=0; end
      lv = 'h9;   if (lv !== 'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 'h9",  lv); pass=0; end
      lv = 'hx;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 'hx",  lv); pass=0; end
      lv = 'hz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 'hz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'h00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'h00", lv); pass=0; end
      lv = 'h99;  if (lv !== 'b0000_0000_1001_1001) begin $display("FAILED -- lv = 'b%b != 'h99", lv); pass=0; end
      lv = 'hxx;  if (lv !== 'b0000_0000_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'hxx", lv); pass=0; end
      lv = 'hzz;  if (lv !== 'b0000_0000_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'hzz", lv); pass=0; end

      // unsized binary literals single character
      lv = 'd0;   if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'd0",  lv); pass=0; end
      lv = 'd9;   if (lv !== 'b0000_0000_0000_1001) begin $display("FAILED -- lv = 'b%b != 'd9",  lv); pass=0; end
      lv = 'dx;   if (lv !== 'b0000_0000_0000_0xxx) begin $display("FAILED -- lv = 'b%b != 'dx",  lv); pass=0; end
      lv = 'dz;   if (lv !== 'b0000_0000_0000_0zzz) begin $display("FAILED -- lv = 'b%b != 'dz",  lv); pass=0; end
      // unsized binary literals two characters
      lv = 'd00;  if (lv !== 'b0000_0000_0000_0000) begin $display("FAILED -- lv = 'b%b != 'd00", lv); pass=0; end
      lv = 'd99;  if (lv !== 'b0000_0000_0110_0011) begin $display("FAILED -- lv = 'b%b != 'd99", lv); pass=0; end
//    lv = 'dxx;  if (lv !== 'b0000_0000_xxxx_xxxx) begin $display("FAILED -- lv = 'b%b != 'dxx", lv); pass=0; end
//    lv = 'dzz;  if (lv !== 'b0000_0000_zzzz_zzzz) begin $display("FAILED -- lv = 'b%b != 'dzz", lv); pass=0; end
*/

      if (pass) $display("PASSED");
   end

endmodule // test
