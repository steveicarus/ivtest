module top;
  string q_str [$:2];
  bit passed;

  task automatic check_size(integer size,
                            string fname,
                            integer lineno);
    if (q_str.size() !== size) begin
      $display("%s:%0d: Failed: queue initial size != %0d (%0d)",
               fname, lineno, size, q_str.size);
      passed = 1'b0;
    end
  endtask

  task automatic check_idx_value(integer idx,
                                 string expected,
                                 string fname,
                                 integer lineno);
    if (q_str[idx] != expected) begin
      $display("%s:%0d: Failed: element [%0d] != '%s' ('%s')",
               fname, lineno, idx, expected, q_str[idx]);
      passed = 1'b0;
    end
  endtask

  initial begin
    passed = 1'b1;

    check_size(0, `__FILE__, `__LINE__);

    q_str.push_back("World");
    q_str.push_front("Hello");
    q_str.push_back("!");
    q_str.push_back("This will not be added"); // Warning: item not added.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, "Hello", `__FILE__, `__LINE__);
    check_idx_value(1, "World", `__FILE__, `__LINE__);
    check_idx_value(2, "!", `__FILE__, `__LINE__);

    q_str.push_front("I say,"); // Warning: sback item removed.
    q_str[3] = "Will not be added"; // Warning: item not added.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, "I say,", `__FILE__, `__LINE__);
    check_idx_value(1, "Hello", `__FILE__, `__LINE__);
    check_idx_value(2, "World", `__FILE__, `__LINE__);

    q_str.insert(3, "Will not be added"); // Warning: item not added.
    q_str.insert(1, "to you"); // Warning: back item removed.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, "I say,", `__FILE__, `__LINE__);
    check_idx_value(1, "to you", `__FILE__, `__LINE__);
    check_idx_value(2, "Hello", `__FILE__, `__LINE__);

    q_str = '{"Hello", "World", "!", "Will not be added"}; // Warning: items not added.

    check_size(3, `__FILE__, `__LINE__);
    check_idx_value(0, "Hello", `__FILE__, `__LINE__);
    check_idx_value(1, "World", `__FILE__, `__LINE__);
    check_idx_value(2, "!", `__FILE__, `__LINE__);

    if (passed) $display("PASSED");

   end
endmodule : top
