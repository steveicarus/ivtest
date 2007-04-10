/**********************************************************************
 * $pow example -- Verilog HDL test bench.
 *
 * Verilog test bench to test the $pow PLI application.
 *
 * For the book, "The Verilog PLI Handbook" by Stuart Sutherland
 *  Copyright 1999 & 2001, Kluwer Academic Publishers, Norwell, MA, USA
 *   Contact: www.wkap.il
 *  Example copyright 1998, Sutherland HDL Inc, Portland, Oregon, USA
 *   Contact: www.sutherland-hdl.com
 *********************************************************************/
`timescale 1ns / 1ns
module test;
  reg  [32:0] result;
  reg         a, b;

  buf i1 (c,a);
  initial
    begin
      $display("Start simulation pow_test.v");
      a = 1;
      b = 0;
      /* Test $pow with invalid arguments */
      /* These invalid calls will need to be commented out to use */
      /* the valid calls to $pow in simulation */
//      #1 result = $pow;
//      #1 result = $pow();
//      #1 result = $pow(1);
//      #1 result = $pow(2,i1);
//      #1 result = $pow(1,2,3);

      /* Test $pow with valid values */
      #1 $display("$pow(2,3) returns %d", $pow(2,3));
      #1 result = $pow(a,b);
      #1 $display("$pow(a,b) returns %d (a=%d b=%d)", result, a, b);
//      #1 $stop;
      #1 $finish;
    end

endmodule
/*********************************************************************/


 	  	 
