// This tests SystemVerilog casding support
//
// This file ONLY is placed into the Public Domain, for any use,
// without warranty, 2012 by Iztok Jeras.

module test ();

   // variables used in casting
   byte       var_08;
   shortint   var_16;
   bit [23:0] var_24;
   int        var_32;
   longint    var_64;

   // error counter
   bit err = 0;

   initial begin
      var_08 = byte'(4'h5);  if (var_08 != 8'h05) begin $display("FAILED -- var_08 =  'h%0h != 8'h05", var_08); err=1; end

      if (!err) $display("PASSED");
   end

endmodule // test
