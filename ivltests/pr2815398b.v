module top;
  reg pass;
  wire [2:0] arr [0:7];
  reg rarr [0:7];
  integer i;

  initial begin
    pass = 1'b1;
    #1;
    for (i = 0; i <=7 ; i = i + 1) begin
      if (arr[i] !== i) begin
        $display("FAILED: index %1d, expected %1d, got %1d", i, i, arr[i]);
        pass = 1'b0;
      end
    end

    if (pass) $display("PASSED");
  end

  // This should display a warning and just ignore the whole statement.
  assign arr[20] = 'b0;
  assign arr[-1] = 'b0;


  genvar m;
  generate
    // This like above should warn when 8 <= m <= 15.
    for (m=0; m<=15; m=m+1) begin: arr_loop
      assign arr[m] = m;
    end
  endgenerate
endmodule

 	  	 
