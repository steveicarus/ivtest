module top;
  int q_vec [$:2];
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

    q_vec.push_back(2);
    q_vec.push_front(1);
    q_vec.push_back(3);
    q_vec.push_back(100); // Warning: item not added.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 1, `__FILE__, `__LINE__);
    check_idx_value(1, 2, `__FILE__, `__LINE__);
    check_idx_value(2, 3, `__FILE__, `__LINE__);

    q_vec.push_front(5); // Warning: back item removed.
    q_vec[3] = 3; // Warning: item not added.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 5, `__FILE__, `__LINE__);
    check_idx_value(1, 1, `__FILE__, `__LINE__);
    check_idx_value(2, 2, `__FILE__, `__LINE__);

    q_vec.insert(3, 10); // Warning: item not added.
    q_vec.insert(1, 2); // Warning: back item removed.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 5, `__FILE__, `__LINE__);
    check_idx_value(1, 2, `__FILE__, `__LINE__);
    check_idx_value(2, 1, `__FILE__, `__LINE__);

    q_vec = '{1, 2, 3, 4}; // Warning: items not added.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, 1, `__FILE__, `__LINE__);
    check_idx_value(1, 2, `__FILE__, `__LINE__);
    check_idx_value(2, 3, `__FILE__, `__LINE__);

    if (passed) $display("PASSED");

   end
endmodule : top
