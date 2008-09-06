/**********************************************************************
 * $my_monitor example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $my_monitor PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Copyright 1999 & 2001, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland-hdl.com
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg   a, b, ci, clk;
  wire  sum, co;

  addbit i1 (a, b, ci, sum, co);

  initial
    $my_monitor(i1);
  
  initial
    begin
      #0 a = 0; b = 0; ci = 0;
      #10 a = 1;
      #10 a = 0;
      #10 b = 1;
      #10 a = 1;
      #10 $finish;
    end

endmodule

/*** A gate level 1 bit adder model ***/
`timescale 1ns / 1ns
module addbit (a, b, ci, sum, co);
  input  a, b, ci;
  output sum, co;

  wire  a, b, ci, sum, co,
        n1, n2, n3;

/*
  assign n1 = a ^ b;
  assign sum = n1 ^ ci;
  assign n2 = a & b;
  assign n3 = n1 & ci;
  assign co = n2 | n3;
*/
  xor    (n1, a, b);
  xor    (sum, n1, ci);
  and    (n2, a, b);
  and    (n3, n1, ci);
  or     (co, n2, n3);

endmodule
/*********************************************************************/

