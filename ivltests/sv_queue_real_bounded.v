module top;
  real q_real [$:2];
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_real.size() != 0) begin
      $display("Failed: unsized queue initial size != 0 (%0d)", q_real.size);
      passed = 1'b0;
    end

    q_real.push_back(2.0);
    q_real.push_front(1.0);
    q_real.push_back(3.0);
    q_real.push_back(100.0); // This should create a warning, item not added.

    if (q_real.size != 3) begin
      $display("Failed: unsized queue size != 3 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if (q_real[0] != 1.0) begin
      $display("Failed: unsized element [0] != 1.0 (%.1f)", q_real[0]);
      passed = 1'b0;
    end

    if (q_real[1] != 2.0) begin
      $display("Failed: unsized element [1] != 2.0 (%.1f)", q_real[1]);
      passed = 1'b0;
    end

    if (q_real[2] != 3.0) begin
      $display("Failed: unsized element [2] != 3.0 (%.1f)", q_real[2]);
      passed = 1'b0;
    end

    q_real.push_front(0.5); // This should create a warning, back item removed.
    q_real[3] = 3.0; // This should create a warning, item not added.

    if (q_real.size != 3) begin
      $display("Failed: unsized queue size != 3 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if (q_real[0] != 0.5) begin
      $display("Failed: unsized element [0] != 0.5 (%.1f)", q_real[0]);
      passed = 1'b0;
    end

    if (q_real[1] != 1.0) begin
      $display("Failed: unsized element [1] != 1.0 (%.1f)", q_real[1]);
      passed = 1'b0;
    end

    if (q_real[2] != 2.0) begin
      $display("Failed: unsized element [2] != 2.0 (%.1f)", q_real[2]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
