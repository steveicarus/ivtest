package t;
  class c;
    virtual function create (string name="");
      return null;  // Error: logic returning a null
    endfunction

  endclass : c
endpackage

module m;
  import t::*;
  int idx, idx2;

  c carr [0:1][0:3];

  class c2;
    c val;
    c arr [0:1];
    task check;
      // If the check in PEBComp::test_width(), elab_expr.cc is enabled
      // these fail since we cannot correctly find the class variables.
      // Also the check in do_elab_and_eval(), netmisc.cc is disabled.
      if (val == null) $display("Empty"); // Okay
      if (arr[0] == null) $display("Empty"); // Okay
    endtask
  endclass


  // An implicit logic return type is given a NULL
  function tmp();
    return null;  // Error: logic returning a null
  endfunction

  c cls;

  logic val;

  initial begin
    idx = 0;
    idx2 = 0;
    if (cls == null) $display("Empty"); // Okay
    if (carr[0][0] == null) $display("Empty"); // Okay
    if (carr[idx][idx2] == null) $display("Empty"); // Okay
    // See above for why this does not fail
    if (0 == null) $display("Empty"); // Error: logic comp null
    val = 1|null; // Error: logic binop null
    val = 1<<null; // Error: logic binop null
    val = null<<1; // Error: logic binop null
    val = null==null; // Okay
    val = null<=1; // Error: null binop logic
    val = null<=cls; // Error: not supported
    val = !null; // Error: unary null
    $display("FAILED");
  end
endmodule
