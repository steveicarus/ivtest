module test;
    reg [800:1] string;
    integer code;
    real f;

    initial begin
        string = "1e1";
        code = $sscanf(string, "%f", f);
        if (f != 10.0) $display("FAILED: got %f", f);
        else $display("PASSED");
    end
endmodule
