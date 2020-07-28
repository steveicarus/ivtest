module top;
  string q_str [$:2];
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_str.size() != 0) begin
      $display("Failed: unsized queue initial size != 0 (%0d)", q_str.size);
      passed = 1'b0;
    end

    q_str.push_back("World");
    q_str.push_front("Hello");
    q_str.push_back("!");
    q_str.push_back("This will not be added"); // This should create a warning, item not added.

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

    q_str.push_front("I say,"); // This should create a warning, back item removed.
    q_str[3] = "Will not be added"; // This should create a warning, item not added.

    if (q_str.size != 3) begin
      $display("Failed: unsized queue size != 3 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "I say,") begin
      $display("Failed: unsized element [0] != 'I say,' (%s)", q_str[0]);
      passed = 1'b0;
    end

    if (q_str[1] != "Hello") begin
      $display("Failed: unsized element [1] != 'Hello' (%s)", q_str[1]);
      passed = 1'b0;
    end

    if (q_str[2] != "World") begin
      $display("Failed: unsized element [2] != 'World' (%s)", q_str[2]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
