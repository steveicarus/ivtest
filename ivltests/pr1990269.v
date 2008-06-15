module top;
  reg pass = 1'b1;
  reg [7:0] val;

  initial begin
    val[3:-4] = 8'h6f;
    if (val !== 8'hx6) begin
      $display("FAILED underflow, got %h, expected 8'hx6", val);
      pass = 1'b0;
    end

    val[11:4] = 8'hfe;
    if (val !== 8'he6) begin
      $display("FAILED overflow, got %h, expected 8'he6", val);
      pass = 1'b0;
    end

    if (pass) $display("PASSED");
  end
endmodule
