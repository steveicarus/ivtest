module top;
  int q_vec [$];
  int elem;
  integer idx;
  bit passed;

  task automatic check_size(integer size,
                            string fname,
                            integer lineno);
    if (q_vec.size !== size) begin
      $display("%s:%0d: Failed: queue size != %0d (%0d)",
               fname, lineno, size, q_vec.size);
      passed = 1'b0;
    end
  endtask

  task automatic check_idx_value(integer idx,
                                 int expected,
                                 string fname,
                                 integer lineno);
    if (q_vec[idx] != expected) begin
      $display("%s:%0d: Failed: element [%0d] != %0d (%0d)",
               fname, lineno, idx, expected, q_vec[idx]);
      passed = 1'b0;
    end
  endtask

  initial begin
    passed = 1'b1;

    check_size(0, `__FILE__, `__LINE__);
    check_idx_value(0, 0, `__FILE__, `__LINE__);

    elem = q_vec.pop_front(); // Warning: cannot pop_front() an empty queue
    if (elem !== 'X) begin
      $display("Failed: pop_front() != 'X (%0d)", elem);
      passed = 1'b0;
    end

    elem = q_vec.pop_back(); // Warning: cannot pop_back() an empty queue
    if (elem !== 'X) begin
      $display("Failed: pop_back() != 'X (%0d)", elem);
      passed = 1'b0;
    end

    q_vec.push_back(2);
    q_vec.push_front(1);
    q_vec.push_back(3);
    q_vec.push_back(100);
    q_vec.delete(3); // Should $ work here?
    q_vec.delete(3); // Warning: skip an out of range delete()
    q_vec.delete(-1); // Warning: skip delete with negative index
    q_vec.delete('X); // Warning: skip delete with undefined index

    check_size(3, `__FILE__, `__LINE__);

    if (q_vec[0] !== 1) begin
      $display("Failed: element [0] != 1 (%0d)", q_vec[0]);
      passed = 1'b0;
    end

    if (q_vec[1] !== 2) begin
      $display("Failed: element [1] != 2 (%0d)", q_vec[1]);
      passed = 1'b0;
    end

    if (q_vec[2] !== 3) begin
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

    check_idx_value(-1, 0.0, `__FILE__, `__LINE__);
    check_idx_value('X, 0.0, `__FILE__, `__LINE__);

    elem = q_vec.pop_front();
    if (elem !== 1) begin
      $display("Failed: element pop_front() != 1 (%0d)", elem);
      passed = 1'b0;
    end

    elem = q_vec.pop_back();
    if (elem !== 3) begin
      $display("Failed: element pop_back() != 3 (%0d)", elem);
      passed = 1'b0;
    end

    check_size(1, `__FILE__, `__LINE__);

    if ((q_vec[0] !== q_vec[$]) || (q_vec[0] !== 2)) begin
      $display("Failed: q_vec[0](%0d) != q_vec[$](%0d) != 2",
               q_vec[0], q_vec[$]);
      passed = 1'b0;
    end

    q_vec.delete();

    check_size(0, `__FILE__, `__LINE__);

    q_vec.push_front(5);
    q_vec.push_front(100);
    q_vec.push_back(100);
    elem = q_vec.pop_back;
    elem = q_vec.pop_front;

    check_size(1, `__FILE__, `__LINE__);
    check_idx_value(0, 5, `__FILE__, `__LINE__);

    q_vec[0] = 1;
    q_vec[1] = 3;
    q_vec[1] = 2;
    q_vec[2] = 3;
    q_vec[-1] = 10; // Warning: will not be added (negative index)
    q_vec['X] = 10; // Warning: will not be added (undefined index)

    idx = -1;
    q_vec[idx] = 10; // Warning: will not be added (negative index)
    idx = 3'b0x1;
    q_vec[idx] = 10; // Warning: will not be added (undefined index)
    idx = 4;
    q_vec[idx] = 10; // Warning: will not be added (out of range index)

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 1, `__FILE__, `__LINE__);
    check_idx_value(1, 2, `__FILE__, `__LINE__);
    check_idx_value(2, 3, `__FILE__, `__LINE__);

    q_vec.delete();
    q_vec[0] = 2;
    q_vec.insert(1, 4);
    q_vec.insert(0, 1);
    q_vec.insert(2, 3);
    q_vec.insert(-1, 10); // Warning: will not be added (negative index)
    q_vec.insert('X, 10); // Warning: will not be added (undefined index)
    q_vec.insert(5, 10); // Warning: will not be added (out of range index)

    check_size(4, `__FILE__, `__LINE__);
    check_idx_value(0, 1, `__FILE__, `__LINE__);
    check_idx_value(1, 2, `__FILE__, `__LINE__);
    check_idx_value(2, 3, `__FILE__, `__LINE__);
    check_idx_value(3, 4, `__FILE__, `__LINE__);

    q_vec = '{3, 2, 1};

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 3, `__FILE__, `__LINE__);
    check_idx_value(1, 2, `__FILE__, `__LINE__);
    check_idx_value(2, 1, `__FILE__, `__LINE__);

    q_vec = '{};

    check_size(0, `__FILE__, `__LINE__);

    if (passed) $display("PASSED");

   end
endmodule : top
