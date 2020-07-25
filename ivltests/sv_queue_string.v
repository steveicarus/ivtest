module top;
  string q_str [$];
  string elem;
  integer idx;
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_str.size() != 0) begin
      $display("Failed: queue initial size != 0 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "") begin
      $display("Failed: element [0] != '' (%s)", q_str[0]);
      passed = 1'b0;
    end

    elem = q_str.pop_front(); // Warning
    if (elem != "") begin
      $display("Failed: pop_front() != '' (%s)", elem);
      passed = 1'b0;
    end

    elem = q_str.pop_back(); // Warning
    if (elem != "") begin
      $display("Failed: pop_back() != '' (%s)", elem);
      passed = 1'b0;
    end

    q_str.push_back("World");
    q_str.push_front("Hello");
    q_str.push_back("!");
    q_str.push_back("This should get deleted");
    q_str.delete(3);
    q_str.delete(3); // Warning
    q_str.delete(-1); // Warning
    q_str.delete('X); // Warning

    if (q_str.size != 3) begin
      $display("Failed: queue size != 3 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "Hello") begin
      $display("Failed: element [0] != 'Hello' (%s)", q_str[0]);
      passed = 1'b0;
    end

    if (q_str[1] != "World") begin
      $display("Failed: element [1] != 'World' (%s)", q_str[1]);
      passed = 1'b0;
    end

    if (q_str[2] != "!") begin
      $display("Failed: element [2] != '!' (%s)", q_str[2]);
      passed = 1'b0;
    end

    if (q_str[3] != "") begin
      $display("Failed: element [3] != '' (%s)", q_str[3]);
      passed = 1'b0;
    end

    if (q_str[-1] != "") begin
      $display("Failed: element [-1] != '' (%s)", q_str[-1]);
      passed = 1'b0;
    end

    if (q_str['X] != "") begin
      $display("Failed: element ['X] != '' (%s)", q_str['X]);
      passed = 1'b0;
    end

    idx = 'X;
    if (q_str[idx] != "") begin
      $display("Failed: element [idx] != '' (%s)", q_str[idx]);
      passed = 1'b0;
    end

    elem = q_str.pop_front();
    if (elem != "Hello") begin
      $display("Failed: element pop_front() != 'Hello' (%s)", elem);
      passed = 1'b0;
    end

    elem = q_str.pop_back();
    if (elem != "!") begin
      $display("Failed: element pop_back() != '!' (%s)", elem);
      passed = 1'b0;
    end

    if (q_str.size != 1) begin
      $display("Failed: queue size != 1 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if ((q_str[0] != q_str[$]) || (q_str[0] != "World")) begin
      $display("Failed: q_str[0](%s) != q_str[$](%s) != 'World'",
               q_str[0], q_str[$]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
