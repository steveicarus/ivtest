module top;
  string q_str [$];
  string elem;
  integer idx;
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_str.size() != 0) begin
      $display("Failed: unsized queue initial size != 0 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "") begin
      $display("Failed: unsized element [0] != '' (%s)", q_str[0]);
      passed = 1'b0;
    end

    q_str.push_back("World");
    q_str.push_front("Hello");
    q_str.push_back("!");

    if (q_str.size != 3) begin
      $display("Failed: unsized queue size != 3 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "Hello") begin
      $display("Failed: unsized element [0] != 'Hello' (%s)", q_str[0]);
      passed = 1'b0;
    end

    if (q_str[1] != "World") begin
      $display("Failed: unsized element [1] != 'World' (%s)", q_str[1]);
      passed = 1'b0;
    end

    if (q_str[2] != "!") begin
      $display("Failed: unsized element [2] != '!' (%s)", q_str[2]);
      passed = 1'b0;
    end

    if (q_str[3] != "") begin
      $display("Failed: unsized element [3] != '' (%s)", q_str[3]);
      passed = 1'b0;
    end

    elem = q_str.pop_front();
    if (elem != "Hello") begin
      $display("Failed: unsized element pop_front() != 'Hello' (%s)", elem);
      passed = 1'b0;
    end

    elem = q_str.pop_back();
    if (elem != "!") begin
      $display("Failed: unsized element pop_back() != '!' (%s)", elem);
      passed = 1'b0;
    end

    if (q_str.size != 1) begin
      $display("Failed: unsized queue size != 1 (%0d)", q_str.size);
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
