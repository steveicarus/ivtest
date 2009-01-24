// A few simple tests of translating parameters to generics
module top();
  wire [7:0] v1, v2, v3;
  wire [7:0] w1, w2, w3;
  
  child c1(v1, w1);
  child c2(v2, w2);
  child c3(v3, w3);

  defparam c1.MY_VALUE = 6;
  defparam c2.MY_VALUE = 44;

  initial begin
    #2;
    $display("c1 value: %d", v1);
    $display("c2 value: %d", v2);
    $display("c3 value: %d", v3);
    if (v1 !== 6)
      $display("FAILED - v1 !== 6");
    else if (v2 !== 44)
      $display("FAILED - v2 !== 44");
    else if (v3 !== 3)
      $display("FAILED - v3 !== 3");
    else
      $display("PASSED");
  end
  
endmodule // top

module child(value, value_w);
  output [7:0] value, value_w;
  reg [7:0]    value;
  
  parameter MY_VALUE = 3;

  assign value_w = MY_VALUE;

  // Make a non-trivial process
  initial begin
    #1;
    value <= MY_VALUE;
  end
endmodule // child

