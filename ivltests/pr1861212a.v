module top2;
  reg real vo;

  initial begin
    vo = 3.3;
    #1000 vo = 4.5776;
    #1000 vo = -4;
  end

  always @(vo)
    $display("Real value is %f at %g", vo, $time);
endmodule
