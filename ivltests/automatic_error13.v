module automatic_error();

task automatic auto_task;

integer local;

begin
  local = 1;
  $fstrobe(1, "%0d", local);
end

endtask

initial auto_task;

endmodule
