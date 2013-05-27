module bug();

reg flag1;
reg flag2;

task set_flag1(inout flag);

begin
  #4 flag = 1;
end

endtask

task set_flag2(inout flag);

begin
  #5 flag = 1;
end

endtask

initial begin
  flag1 = 0;
  flag2 = 0;
  fork
    set_flag1(flag1);
    set_flag2(flag2);
  join
  if ((flag1 === 1) && (flag2 === 1))
    $display("PASSED");
  else
    $display("FAILED");
end

endmodule
