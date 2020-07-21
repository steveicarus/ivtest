module top;
  int q_vec [$:2];
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_vec.size() != 0) begin
      $display("Failed: unsized queue initial size != 0 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    q_vec.push_back(2);
    q_vec.push_front(1);
    q_vec.push_back(3);
    q_vec.push_back(100); // This should create a warning, item not added.

    if (q_vec.size != 3) begin
      $display("Failed: unsized queue size != 3 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    if (q_vec[0] != 1) begin
      $display("Failed: unsized element [0] != 1 (%.1f)", q_vec[0]);
      passed = 1'b0;
    end

    if (q_vec[1] != 2) begin
      $display("Failed: unsized element [1] != 2 (%.1f)", q_vec[1]);
      passed = 1'b0;
    end

    if (q_vec[2] != 3) begin
      $display("Failed: unsized element [2] != 3 (%.1f)", q_vec[2]);
      passed = 1'b0;
    end

    q_vec.push_front(5); // This should create a warning, back item removed.

    if (q_vec.size != 3) begin
      $display("Failed: unsized queue size != 3 (%0d)", q_vec.size);
      passed = 1'b0;
    end

    if (q_vec[0] != 5) begin
      $display("Failed: unsized element [0] != 5 (%.1f)", q_vec[0]);
      passed = 1'b0;
    end

    if (q_vec[1] != 1) begin
      $display("Failed: unsized element [1] != 1 (%.1f)", q_vec[1]);
      passed = 1'b0;
    end

    if (q_vec[2] != 2) begin
      $display("Failed: unsized element [2] != 2 (%.1f)", q_vec[2]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
