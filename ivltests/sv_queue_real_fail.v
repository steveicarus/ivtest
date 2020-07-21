module top;
  int bound = 2;
  real q_real1 [$:-1];
  real q_real2 [$:bound];

  initial $display("FAILED");
endmodule : top
