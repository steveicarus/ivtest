module automatic_error();

task automatic auto_task;

integer local;

begin
  $monitor("%0d", local);
  #1 local = 0;
  #1 local = 1;
end

endtask

initial auto_task;

endmodule
