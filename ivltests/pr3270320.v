module bug();

function [7:0] dup;

input [7:0] i;

begin
  dup = i;
end

endfunction

wire [7:0] a;
wire [7:0] b;

assign a = dup(missing);

assign b = $abs(missing);

endmodule
