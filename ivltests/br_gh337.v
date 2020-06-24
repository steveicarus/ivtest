module test();

int x2;
int z2;

function int y2(int x);
endfunction

wire int w2 = y2(x2);

integer x4;
integer z4;

function integer y4(integer x);
endfunction

wire integer w4 = y4(x4);

initial begin
  #1;
  $display(w2);
  z2 = y2(x2);
  $display(z2);
  $display(w4);
  z4 = y4(x4);
  $display(z4);
  if (w2 === 0 && z2 === 0 && w4 === 'bx && z4 === 'bx)
    $display("PASSED");
  else
    $display("FAILED");
end

endmodule
