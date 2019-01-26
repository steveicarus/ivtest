module test();

struct packed {
  logic [15:0] value;
} data;

initial begin
  data.value[7:0] = 8'h55;
end

endmodule
