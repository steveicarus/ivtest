// test that if the signal doesn't exist, an error is thrown
module top;
reg a;
// wire b;
m foo(.a, .b);
endmodule

module m(input a, output b);
assign b = a;
endmodule
