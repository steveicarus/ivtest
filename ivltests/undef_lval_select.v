module top;
  reg pass;
  reg [2:-1] vec;

  initial begin
    pass = 1'b1;

    vec = 4'bxxxx;
    vec[1'bx] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[1'bx], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end

    vec = 4'bxxxx;
    vec[1'bx:0] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[1'bx:0], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end

    vec = 4'bxxxx;
    vec[0:1'bx] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[0:1'bx], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end

    vec = 4'bxxxx;
    vec[1'bx:1'bx] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[1'bx:1'bx], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end

    vec = 4'bxxxx;
    vec[1'bx+:1] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[1'bx+:1], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end

    vec = 4'bxxxx;
    vec[1'bx-:1] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[1'bx-:1], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end

    if (pass) $display("PASSED");
  end
endmodule
