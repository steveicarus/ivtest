/*
**      The problem:
**      Reading in a series of bytes, one per clock, to create a
**      large vector which holds the bytes in a parallel form.
*/


module  demo_assign_problem;

reg     [7:0] mem_buffer [0:3];
wire    [31:0] big_word;
reg     error;
reg     [31:0] myconst;

integer i;

assign big_word[ 31: 24] = mem_buffer[0];
assign big_word[ 23: 16] = mem_buffer[1];
assign big_word[ 15:  8] = mem_buffer[2];
assign big_word[  7:  0] = mem_buffer[3];

initial 
  begin
  error = 0;

  for (i = 0; i < 4; i = i+1)
    mem_buffer[i] = 0;
  #50;
  mem_buffer[0] = 8'h12;
  #50;
  myconst = 32'h12_00_00_00;
  if(big_word !== 32'h12_00_00_00)
    begin
      $display("FAILED -Memory assign - expect %h, but have %h",
                myconst,,big_word);
      error = 1;
    end
  #100  ; 
  mem_buffer[1] = 8'h34;
  #50;
  myconst = 32'h12_34_00_00;
  if(big_word !== 32'h12_34_00_00)
    begin
      $display("FAILED -Memory assign - expect %h, but have %h",
                 myconst,big_word);
      error = 1;
    end
  #100 ;  
  mem_buffer[2] = 8'h56;
  #50;
  myconst = 32'h12_34_56_00;
  if(big_word !== 32'h12_34_56_00)
    begin
      $display("FAILED -Memory assign - expect %h, but have %h",
                 myconst,big_word);
      error = 1;
    end
  #100;   
  mem_buffer[3] = 8'h78;
  #50;
  myconst = 32'h12_34_56_00;
  if(big_word !== 32'h12_34_56_78)
    begin
      $display("FAILED - Memory assign - expect %h, but have %h",
               myconst,big_word);
      error = 1;
    end
  #100;
  mem_buffer[0] = 8'hab;
  #50;
  myconst = 32'hab_34_56_00;
  if(big_word !== 32'hab_34_56_78)
    begin
      $display("FAILED - Memory assign - expect %h, but have %h",
                myconst,big_word);
      error = 1;
    end

  #100;
  if (error ===0)
     $display("PASSED");


end
endmodule

