module top;
  reg [31:0] var;

  initial begin
    $monitor(var);
    var = 0;
    repeat (60) begin
       #1 var = $urandom_range(0,16);
    end
  end
endmodule
