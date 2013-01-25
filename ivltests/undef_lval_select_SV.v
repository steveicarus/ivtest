module top;
  reg pass;
  reg [1:-1][3:0] vec;

  initial begin
    pass = 1'b1;

    vec[1] = 4'bxxxx;
    vec[0] = 4'bxxxx;
    vec[-1] = 4'bxxxx;
    vec[1'bx] = 4'b1001;
    if ((vec[1] !== 4'bxxx) && (vec[0] !== 4'bxxxx) &&
        (vec[-1] !== 4'bxxxx)) begin
      $display("Failed vec[1'bx], expected 4'bxxxx, got %b, %b,%b",
               vec[1], vec[0], vec[-1]);
      pass = 1'b0;
    end

    if (pass) $display("PASSED");
  end
endmodule
