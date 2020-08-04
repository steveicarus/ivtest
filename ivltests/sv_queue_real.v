module top;
  real q_real [$];
  real elem;
  integer idx;
  bit passed;

  task automatic check_size(integer size,
                            string fname,
                            integer lineno);
    if (q_real.size !== size) begin
      $display("%s:%0d: Failed: queue size != %0d (%0d)",
               fname, lineno, size, q_real.size);
      passed = 1'b0;
    end
  endtask

  task automatic check_idx_value(integer idx,
                                 real expected,
                                 string fname,
                                 integer lineno);
    if (q_real[idx] != expected) begin
      $display("%s:%0d: Failed: element [%0d] != %.1f (%.1f)",
               fname, lineno, idx, expected, q_real[idx]);
      passed = 1'b0;
    end
  endtask

  initial begin
    passed = 1'b1;

    check_size(0, `__FILE__, `__LINE__);
    check_idx_value(0, 0.0, `__FILE__, `__LINE__);

    elem = q_real.pop_front(); // Warning: cannot pop_front() an empty queue
    if (elem != 0.0) begin
      $display("Failed: pop_front() != 0.0 (%.1f)", elem);
      passed = 1'b0;
    end

    elem = q_real.pop_back(); // Warning: cannot pop_back() an empty queue
    if (elem != 0.0) begin
      $display("Failed: pop_back() != 0.0 (%.1f)", elem);
      passed = 1'b0;
    end

    q_real.push_back(2.0);
    q_real.push_front(1.0);
    q_real.push_back(3.0);
    q_real.push_back(100.0);
    q_real.delete(3); // Should $ work here?
    q_real.delete(3); // Warning: skip an out of range delete()
    q_real.delete(-1); // Warning: skip delete with negative index
    q_real.delete('X); // Warning: skip delete with undefined index

    check_size(3, `__FILE__, `__LINE__);

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

    check_idx_value(-1, 0.0, `__FILE__, `__LINE__);
    check_idx_value('X, 0.0, `__FILE__, `__LINE__);

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

    check_size(1, `__FILE__, `__LINE__);

    if ((q_real[0] != q_real[$]) || (q_real[0] != 2.0)) begin
      $display("Failed: q_real[0](%.1f) != q_real[$](%.1f) != 2.0",
               q_real[0], q_real[$]);
      passed = 1'b0;
    end

    q_real.delete();

    check_size(0, `__FILE__, `__LINE__);

    q_real.push_front(5.0);
    q_real.push_front(100.0);
    q_real.push_back(100.0);
    elem = q_real.pop_back;
    elem = q_real.pop_front;

    check_size(1, `__FILE__, `__LINE__);
    check_idx_value(0, 5.0, `__FILE__, `__LINE__);

    q_real[0] = 1.0;
    q_real[1] = 2.5;
    q_real[1] = 2.0;
    q_real[2] = 3.0;
    q_real[-1] = 10.0; // Warning: will not be added (negative index)
    q_real['X] = 10.0; // Warning: will not be added (undefined index)
// FIXME: is this valid?    q_real[$] = 2.0;
// FIXME: Add support for this?    q_real[$+1] = 3.0;

    idx = -1;
    q_real[idx] = 10.0; // Warning: will not be added (negative index)
    idx = 3'b0x1;
    q_real[idx] = 10.0; // Warning: will not be added (undefined index)
    idx = 4;
    q_real[idx] = 10.0; // Warning: will not be added (out of range index)

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 1.0, `__FILE__, `__LINE__);
    check_idx_value(1, 2.0, `__FILE__, `__LINE__);
    check_idx_value(2, 3.0, `__FILE__, `__LINE__);

    q_real.delete();
    q_real[0] = 2.0;
    q_real.insert(1, 4.0);
    q_real.insert(0, 1.0);
    q_real.insert(2, 3.0);
    q_real.insert(-1, 10.0); // Warning: will not be added (negative index)
    q_real.insert('X, 10.0); // Warning: will not be added (undefined index)
    q_real.insert(5, 10.0); // Warning: will not be added (out of range index)

    check_size(4, `__FILE__, `__LINE__);
    check_idx_value(0, 1.0, `__FILE__, `__LINE__);
    check_idx_value(1, 2.0, `__FILE__, `__LINE__);
    check_idx_value(2, 3.0, `__FILE__, `__LINE__);
    check_idx_value(3, 4.0, `__FILE__, `__LINE__);

    q_real = '{3.0, 2.0, 1.0};

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 3.0, `__FILE__, `__LINE__);
    check_idx_value(1, 2.0, `__FILE__, `__LINE__);
    check_idx_value(2, 1.0, `__FILE__, `__LINE__);

    q_real = '{};

    check_size(0, `__FILE__, `__LINE__);

    if (passed) $display("PASSED");

   end
endmodule : top
