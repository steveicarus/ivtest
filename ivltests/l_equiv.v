module top;
  real rval1, rval2;
  reg val1, val2;
  reg res;
  reg pass;

  initial begin
    pass = 1'b1;

    val1 = 1'b0;
    val2 = 1'b0;
    res = val1 <-> val2;
    if (res !== 1'b1) begin
      $display("FAILED: 1'b0 <-> 1'b0 returned %b not 1'b1", res);
      pass = 1'b0;
    end
    val2 = 1'b1;
    res = val1 <-> val2;
    if (res !== 1'b0) begin
      $display("FAILED: 1'b0 <-> 1'b1 returned %b not 1'b0", res);
      pass = 1'b0;
    end
    val2 = 1'bx;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'b0 <-> 1'bx returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'bz;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'b0 <-> 1'bz returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val1 = 1'b1;
    val2 = 1'b0;
    res = val1 <-> val2;
    if (res !== 1'b0) begin
      $display("FAILED: 1'b1 <-> 1'b0 returned %b not 1'b0", res);
      pass = 1'b0;
    end
    val2 = 1'b1;
    res = val1 <-> val2;
    if (res !== 1'b1) begin
      $display("FAILED: 1'b1 <-> 1'b1 returned %b not 1'b1", res);
      pass = 1'b0;
    end
    val2 = 1'bx;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'b1 <-> 1'bx returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'bz;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'b1 <-> 1'bz returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val1 = 1'bx;
    val2 = 1'b0;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bx <-> 1'b0 returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'b1;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bx <-> 1'b1 returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'bx;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bx <-> 1'bx returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'bz;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bx <-> 1'bz returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val1 = 1'bz;
    val2 = 1'b0;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bz <-> 1'b0 returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'b1;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bz <-> 1'b1 returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'bx;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bz <-> 1'bx returned %b not 1'bx", res);
      pass = 1'b0;
    end
    val2 = 1'bz;
    res = val1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 1'bz <-> 1'bz returned %b not 1'bx", res);
      pass = 1'b0;
    end

    rval1 = 0.0;
    val2 = 1'b0;
    res = rval1 <-> val2;
    if (res !== 1'b1) begin
      $display("FAILED: 0.0 <-> 1'b0 returned %b not 1'b1", res);
      pass = 1'b0;
    end
    val1 = 1'b0;
    rval2 = 2.0;
    res = val1 <-> rval2;
    if (res !== 1'b0) begin
      $display("FAILED: 1'b0 <-> 2.0 returned %b not 1'b0", res);
      pass = 1'b0;
    end
    rval1 = 2.0;
    val2 = 1'bx;
    res = rval1 <-> val2;
    if (res !== 1'bx) begin
      $display("FAILED: 2.0 <-> 1'bx returned %b not 1'bx", res);
      pass = 1'b0;
    end
    rval1 = -5.0;
    rval2 = 2.0;
    res = rval1 <-> rval2;
    if (res !== 1'b1) begin
      $display("FAILED: -5.0 <-> -2.0 returned %b not 1'b1", res);
      pass = 1'b0;
    end

    if (pass) $display("PASSED");
  end
endmodule
