`timescale 1ns/10ps

module top;
// Comment out this line and the $display below to get elaboration to fail.
  integer max = 2 ** 2;

  initial begin
    test_ok;
    test_fail;
    $display("Main: %3d", max);
  end

  // This works.
  task test_ok;
    integer max;

    begin
      max = 2 ** 8;
      $display("OK:   %3d", max);
    end
  endtask

  // And this is failing! It appears to be looking in the wrong scope.
  task test_fail;
    integer max = 2 ** 8;

    begin
      $display("Fail: %3d", max);
    end
  endtask

endmodule
