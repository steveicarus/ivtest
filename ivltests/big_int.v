
module main();

   reg [34:0] my_reg;
   reg 	      error;
   reg [34:0] ref_val;
   reg [34:0] ref_val2;
   reg [7:0]  count;
   

   initial
      begin
	 error = 0;

	 // Create reference value that is bigger than 32 bits...
	 ref_val = 0;
	 ref_val[0] = 1;
	 ref_val[34] = 1;
	 $display("*:%d", ref_val);

	 ref_val2 = 35'hffffffffff;
	 $display("*:%d", ref_val2);
	 
	 // Trivial test to see that small unsized integers still work.
	 my_reg = 100;
	 if (my_reg != 'h64)
	    begin
	       error = 1;
	       $display("Error: expected 100");
	    end

	 // Unsized integers bigger than 32 bits are truncated...
	 // Value below has bit 34 and bit 0 set to '1'
	 my_reg = 17179869185;
	 $display("1:%d", my_reg);

	 if (my_reg != 1)
	    begin
	       error = 1;
	       $display("Error: expected 1");
	    end


	 // Another unsized integer, but this time 'd specifier...
	 my_reg = 'd17179869184;
	 $display("2:%d", my_reg);

	 if (my_reg != 0)
	    begin
	       error = 1;
	       $display("Error: expected 1");
	    end

	 // This should finally work!
	 my_reg = 35'sd17179869185;
	 $display("3:%d", my_reg);

	 if (my_reg != ref_val)
	    begin
	       error = 1;
	       $display("Error: expected 17179869185");
	    end

	 // This should work too.
	 my_reg = 35'd 17179869185;
	 $display("4:%d", my_reg);

	 if (my_reg != ref_val)
	    begin
	       error = 1;
	       $display("Error: expected 17179869185");
	    end

	 // Overflow...
	 my_reg = 35'd 34359738369;
	 $display("5:%d", my_reg);

	 if (my_reg != 1)
	    begin
	       error = 1;
	       $display("Error: expected 1");
	    end

	 // Just no overflow
	 my_reg = 35'd 34359738367;
	 $display("6:%d", my_reg);

	 if (my_reg != ref_val2)
	    begin
	       error = 1;
	       $display("Error: expected 34359738367");
	    end

	 // Unsized integers bigger than 32 bits are truncated...
	 // Here all the bits are set. Since there is no 'd prefix, 
	 // it will be sign extended later on.
	 my_reg = 17179869183;
	 $display("7:%d", my_reg);

	 if (my_reg != ref_val2)
	    begin
	       error = 1;
	       $display("Error: expected 34359738367");
	    end

	 // Unsized integers bigger than 32 bits are truncated...
	 // Here all the bits are set. Since there *IS* a 'd prefix
	 // it will NOT be sign extended later on.
	 my_reg = 'd17179869183;
	 $display("8:%d", my_reg);

	 if (my_reg != 'd4294967295)
	    begin
	       error = 1;
	       $display("Error: expected 4294967295");
	    end

	 if (error==1)
	    begin
	       $display("FAILED");
	    end 
	 else
	    begin
	       $display("PASSED");
	    end 

	 $finish;
      end

endmodule
