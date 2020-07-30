module top;
  string q_str [$];
  string elem;
  integer idx;
  bit passed;

  initial begin
    passed = 1'b1;

    if (q_str.size() !== 0) begin
      $display("Failed: queue initial size != 0 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "") begin
      $display("Failed: element [0] != '' (%s)", q_str[0]);
      passed = 1'b0;
    end

    elem = q_str.pop_front(); // Warning: cannot pop_front() an empty queue
    if (elem != "") begin
      $display("Failed: pop_front() != '' (%s)", elem);
      passed = 1'b0;
    end

    elem = q_str.pop_back(); // Warning: cannot pop_back() an empty queue
    if (elem != "") begin
      $display("Failed: pop_back() != '' (%s)", elem);
      passed = 1'b0;
    end

    q_str.push_back("World");
    q_str.push_front("Hello");
    q_str.push_back("!");
    q_str.push_back("This should get deleted");
    q_str.delete(3);
    q_str.delete(3); // Warning: skip an out of range delete()
    q_str.delete(-1); // Warning: skip delete with negative index
    q_str.delete('X); // Warning: skip delete with undefined index

    if (q_str.size !== 3) begin
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

    if (q_str.size !== 1) begin
      $display("Failed: queue size != 1 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if ((q_str[0] != q_str[$]) || (q_str[0] != "World")) begin
      $display("Failed: q_str[0](%s) != q_str[$](%s) != 'World'",
               q_str[0], q_str[$]);
      passed = 1'b0;
    end

    q_str.delete();

    if (q_str.size !== 0) begin
      $display("Failed: queue size != 0 (%0d)", q_str.size);
      passed = 1'b0;
    end

    q_str.push_front("hello");
    q_str.push_front("Will be removed");
    q_str.push_back("Will also be removed");
    elem = q_str.pop_back;
    elem = q_str.pop_front;

    if (q_str.size !== 1) begin
      $display("Failed: queue size != 1 (%0d)", q_str.size);
      passed = 1'b0;
    end

    if (q_str[0] != "hello") begin
      $display("Failed: element [0] != 'hello' (%.1f)", q_str[0]);
      passed = 1'b0;
    end

    q_str[0] = "Hello";
    q_str[1] = "world";
    q_str[1] = "World";
    q_str[2] = "!";
    q_str[-1] = "Will not write"; // Warning: will not be added (negative index)
    q_str['X] = "Will not write"; // Warning: will not be added (undefined index)

    idx = -1;
    q_str[idx] = "Will not write"; // Warning: will not be added (negative index)
    idx = 3'b0x1;
    q_str[idx] = "Will not write"; // Warning: will not be added (undefined index)
    idx = 4;
    q_str[idx] = "Will not write"; // Warning: will not be added (out of range index)

    if (q_str.size !== 3) begin
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

    q_str.delete();
    q_str[0] = "World";
    q_str.insert(1, "Again");
    q_str.insert(0, "Hello");
    q_str.insert(2, "!");
    q_str.insert(-1, "Will not be added"); // Warning: will not be added (negative index)
    q_str.insert('X, "Will not be added"); // Warning: will not be added (undefined index)
    q_str.insert(5, "Will not be added"); // Warning: will not be added (out of range index)

    if (q_str.size !== 4) begin
      $display("Failed: queue size != 4 (%0d)", q_str.size);
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

    if (q_str[3] != "Again") begin
      $display("Failed: element [3] != 'Again' (%s)", q_str[3]);
      passed = 1'b0;
    end

    if (passed) $display("PASSED");

   end
endmodule : top
