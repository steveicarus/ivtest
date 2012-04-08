
// This tests end labes

module test ();

   // error counter
   bit err = 0;

   initial
   begin : dummy_label
      if (!err) $display("PASSED");
   end : dummy_label_bad

endmodule : test_bad
