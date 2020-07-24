module top;
  real q_real [$];
  real elem;
  integer idx;
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_real.size() != 0) begin
      $display("Failed: unsized queue initial size != 0 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if (q_real[0] != 0.0) begin
      $display("Failed: unsized element [0] != 0.0 (%.1f)", q_real[0]);
      passed = 1'b0;
    end

    elem = q_real.pop_front();
    if (elem != 0.0) begin
      $display("Failed: pop_front() != 0.0 (%.1f)", elem);
      passed = 1'b0;
    end

    elem = q_real.pop_back();
    if (elem != 0.0) begin
      $display("Failed: pop_back() != 0.0 (%.1f)", elem);
      passed = 1'b0;
    end

    q_real.push_back(2.0);
    q_real.push_front(1.0);
    q_real.push_back(3.0);

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

    if (q_real[3] != 0.0) begin
      $display("Failed: unsized element [3] != 0.0 (%.1f)", q_real[3]);
      passed = 1'b0;
    end

    if (q_real[-1] != 0.0) begin
      $display("Failed: unsized element [-1] != 'X (%.1f)", q_real[-1]);
      passed = 1'b0;
    end

    if (q_real['X] != 0.0) begin
      $display("Failed: unsized element ['X] != 'X (%.1f)", q_real['X]);
      passed = 1'b0;
    end

    elem = q_real.pop_front();
    if (elem != 1.0) begin
      $display("Failed: unsized element pop_front() != 1.0 (%.1f)", elem);
      passed = 1'b0;
    end

    elem = q_real.pop_back();
    if (elem != 3.0) begin
      $display("Failed: unsized element pop_back() != 3.0 (%.1f)", elem);
      passed = 1'b0;
    end

    if (q_real.size != 1) begin
      $display("Failed: unsized queue size != 1 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if ((q_real[0] != q_real[$]) || (q_real[0] != 2.0)) begin
      $display("Failed: q_real[0](%.1f) != q_real[$](%.1f) != 2.0",
               q_real[0], q_real[$]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
