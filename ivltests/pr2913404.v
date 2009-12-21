module bug;

time a;
time b;
time c;

initial begin
  a = 1;
  b = 2;
  c = 3;
  if (a - b < 0.5*c)
    // a - b is a self-determined expression, so should result in a
    // very large unsigned number
    $display("FAILED");
  else
    $display("PASSED");
end

endmodule
