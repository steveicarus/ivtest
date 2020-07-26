module top;
  real q_real [$];
  real elem;
  integer idx;
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_real.size() != 0) begin
      $display("Failed: queue initial size != 0 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if (q_real[0] != 0.0) begin
      $display("Failed: element [0] != 0.0 (%.1f)", q_real[0]);
      passed = 1'b0;
    end

    elem = q_real.pop_front(); // Warning
    if (elem != 0.0) begin
      $display("Failed: pop_front() != 0.0 (%.1f)", elem);
      passed = 1'b0;
    end

    elem = q_real.pop_back(); // Warning
    if (elem != 0.0) begin
      $display("Failed: pop_back() != 0.0 (%.1f)", elem);
      passed = 1'b0;
    end

    q_real.push_back(2.0);
    q_real.push_front(1.0);
    q_real.push_back(3.0);
    q_real.push_back(100.0);
    q_real.delete(3); // Should $ work here?
    q_real.delete(3); // Warning
    q_real.delete(-1); // Warning
    q_real.delete('X); // Warning

    if (q_real.size != 3) begin
      $display("Failed: queue size != 3 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if (q_real[0] != 1.0) begin
      $display("Failed: element [0] != 1.0 (%.1f)", q_real[0]);
      passed = 1'b0;
    end

    if (q_real[1] != 2.0) begin
      $display("Failed: element [1] != 2.0 (%.1f)", q_real[1]);
      passed = 1'b0;
    end

    if (q_real[2] != 3.0) begin
      $display("Failed: element [2] != 3.0 (%.1f)", q_real[2]);
      passed = 1'b0;
    end

    if (q_real[3] != 0.0) begin
      $display("Failed: element [3] != 0.0 (%.1f)", q_real[3]);
      passed = 1'b0;
    end

    if (q_real[-1] != 0.0) begin
      $display("Failed: element [-1] != 0.0 (%.1f)", q_real[-1]);
      passed = 1'b0;
    end

    if (q_real['X] != 0.0) begin
      $display("Failed: element ['X] != 0.0 (%.1f)", q_real['X]);
      passed = 1'b0;
    end

    idx = 'X;
    if (q_real[idx] != 0.0) begin
      $display("Failed: element [idx] != 0.0 (%.1f)", q_real[idx]);
      passed = 1'b0;
    end

    elem = q_real.pop_front();
    if (elem != 1.0) begin
      $display("Failed: element pop_front() != 1.0 (%.1f)", elem);
      passed = 1'b0;
    end

    elem = q_real.pop_back();
    if (elem != 3.0) begin
      $display("Failed: element pop_back() != 3.0 (%.1f)", elem);
      passed = 1'b0;
    end

    if (q_real.size != 1) begin
      $display("Failed: queue size != 1 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if ((q_real[0] != q_real[$]) || (q_real[0] != 2.0)) begin
      $display("Failed: q_real[0](%.1f) != q_real[$](%.1f) != 2.0",
               q_real[0], q_real[$]);
      passed = 1'b0;
    end

    q_real.delete();

    if (q_real.size != 0) begin
      $display("Failed: queue size != 0 (%0d)", q_real.size);
      passed = 1'b0;
    end

    q_real.push_front(1.0);
    q_real.push_front(100.0);
    q_real.push_back(100.0);
    elem = q_real.pop_back;
    elem = q_real.pop_front;

    if (q_real.size != 1) begin
      $display("Failed: queue size != 1 (%0d)", q_real.size);
      passed = 1'b0;
    end

    if (q_real[0] != 1.0) begin
      $display("Failed: element [0] != 1.0 (%.1f)", q_real[0]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
