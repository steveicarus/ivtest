module bittest;

reg signed [5:0] m;
reg signed [7:0] n;
reg signed [18:0] p;
reg signed [8:0] s;
reg b;
reg signed c;
reg d;

always @(m, n, c) begin  
    p <= m * n;
    s <= m + b;
    d <= c == 1;
end

initial begin
    #10;
    m <= -25;
    n <= 29;
    b <= 1;
    c <= 1;
    #10;
    $display("p=%d s=%d d=%d", p, s, d);
    if (s !== -9'd24) begin
       $display("FAILED -- s='b%b", s);
       $finish;
    end
    if (p !== -19'd725) begin
      $display("FAILED == p='b%b", p);
      $finish;
    end
    $display("PASSED");
end

endmodule
