module top;
  reg pass;
  wire [2:-1] vec;

  assign vec = 4'bxxxx;

  initial begin
    pass = 1'b1;

    force vec[1'bx] = 1'b1;
    if (vec !== 4'bxxx) begin
      $display("Failed vec[1'bx], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx];

    force vec[1'bx:0] = 1'b1;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[1'bx:0], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx:0];

    force vec[0:1'bx] = 1'b1;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[0:1'bx], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[0:1'bx];

    force vec[1'bx:1'bx] = 1'b1;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[1'bx:1'bx], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx:1'bx];

    force vec[1'bx+:1] = 1'b1;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[1'bx+:1], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx+:1];

    force vec[1'bx+:2] = 2'b01;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[1'bx+:2], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx+:2];

    force vec[1'bx-:1] = 1'b1;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[1'bx-:1], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx-:1];

    force vec[1'bx-:2] = 2'b01;
    if (vec !== 4'bxxxx) begin
      $display("Failed vec[1'bx-:2], expected 4'bxxxx, got %b", vec);
      pass = 1'b0;
    end
    release vec[1'bx-:2];

    if (pass) $display("PASSED");
  end
endmodule
