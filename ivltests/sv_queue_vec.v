module top;
  int q_vec [$];
  int elem;
  integer idx;
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_vec.size() != 0) begin
      $display("Failed: queue initial size != 0 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    if (q_vec[0] !== 'X) begin
      $display("Failed: element [0] != 'X (%0d)", q_vec[0]);
      passed = 1'b0;
    end

    elem = q_vec.pop_front(); // Warning
    if (elem !== 'X) begin
      $display("Failed: pop_front() != 'X (%0d)", elem);
      passed = 1'b0;
    end

    elem = q_vec.pop_back(); // Warning
    if (elem !== 'X) begin
      $display("Failed: pop_back() != 'X (%0d)", elem);
      passed = 1'b0;
    end

    q_vec.push_back(2);
    q_vec.push_front(1);
    q_vec.push_back(3);
    q_vec.push_back(100);
    q_vec.delete(3);
    q_vec.delete(3); // Warning
    q_vec.delete(-1); // Warning
    q_vec.delete('X); // Warning

    if (q_vec.size != 3) begin
      $display("Failed: queue size != 3 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    if (q_vec[0] != 1) begin
      $display("Failed: element [0] != 1 (%0d)", q_vec[0]);
      passed = 1'b0;
    end

    if (q_vec[1] != 2) begin
      $display("Failed: element [1] != 2 (%0d)", q_vec[1]);
      passed = 1'b0;
    end

    if (q_vec[2] != 3) begin
      $display("Failed: element [2] != 3 (%0d)", q_vec[2]);
      passed = 1'b0;
    end

    if (q_vec[3] !== 'X) begin
      $display("Failed: element [3] != 'X (%0d)", q_vec[3]);
      passed = 1'b0;
    end

    if (q_vec[-1] !== 'X) begin
      $display("Failed: element [-1] != 'X (%0d)", q_vec[-1]);
      passed = 1'b0;
    end

    if (q_vec['X] !== 'X) begin
      $display("Failed: element ['X] != 'X (%0d)", q_vec['X]);
      passed = 1'b0;
    end

    idx = 'X;
    if (q_vec[idx] !== 'X) begin
      $display("Failed: element [idx] != 'X (%0d)", q_vec[idx]);
      passed = 1'b0;
    end

    elem = q_vec.pop_front();
    if (elem != 1) begin
      $display("Failed: element pop_front() != 1 (%0d)", elem);
      passed = 1'b0;
    end

    elem = q_vec.pop_back();
    if (elem != 3) begin
      $display("Failed: element pop_back() != 3 (%0d)", elem);
      passed = 1'b0;
    end

    if (q_vec.size != 1) begin
      $display("Failed: queue size != 1 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    if ((q_vec[0] != q_vec[$]) || (q_vec[0] != 2)) begin
      $display("Failed: q_vec[0](%0d) != q_vec[$](%0d) != 2",
               q_vec[0], q_vec[$]);
      passed = 1'b0;
    end

    q_vec.delete();

    if (q_vec.size != 0) begin
      $display("Failed: queue size != 0 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    q_vec.push_front(1);
    q_vec.push_front(100);
    q_vec.push_back(100);
    elem = q_vec.pop_back;
    elem = q_vec.pop_front;

    if (q_vec.size != 1) begin
      $display("Failed: queue size != 1 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    if (q_vec[0] != 1) begin
      $display("Failed: element [0] != 1 (%0d)", q_vec[0]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
