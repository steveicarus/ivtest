/*
 * Copyright (c) 2001 Stephan Boettcher <stephan@nevis.columbia.edu>
 *
 *    This source code is free software; you can redistribute it
 *    and/or modify it in source code form under the terms of the GNU
 *    General Public License as published by the Free Software
 *    Foundation; either version 2 of the License, or (at your option)
 *    any later version.
 *
 *    This program is distributed in the hope that it will be useful,
 *    but WITHOUT ANY WARRANTY; without even the implied warranty of
 *    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 *    GNU General Public License for more details.
 *
 *    You should have received a copy of the GNU General Public License
 *    along with this program; if not, write to the Free Software
 *    Foundation, Inc., 59 Temple Place - Suite 330, Boston, MA 02111-1307, USA
 */

// $Id: deposit.v,v 1.1 2001/05/06 17:01:53 ka6s Exp $

// Test for vpi_put_value() to properly propagate in structural context.

module deposit_test;

   reg ck;
   always 
     begin
	#2 ck <= 1;
	#2 ck <= 0;
     end

`ifdef RTL
   reg a, b, c;
   always @(posedge ck)
     begin
	a <= b;
	b <= c;
	c <= ~a;
     end
`else // !ifdef RTL
   wire a, b, c;
   wire na;
   not (na, a);
   E_dff fa (ck,  b, a);
   E_dff fb (ck,  c, b);
   E_dff fc (ck, na, c);
`endif // !ifdef RTL
   
   always #4 $display("%b %b %b", a, b, c);

   initial
     begin
	// $dumpfile("deposit.vcd");
	// $dumpvars(0, deposit_test);
	#11;
	$deposit(a, 1'b0);
	#6;
	$deposit(b, 1'b1);
	#20;
	if ({a,b,c} === 3'b0x1)
	  $display("PASSED");
	else
	  $display("FAILED");
	$finish;
     end

endmodule

`ifdef RTL
`else

module E_dff (CK, D,  Q);
   input  CK, D;
   output Q;
   UDP_dff ff (Q, CK, D);
endmodule

primitive UDP_dff (q,  cp, d);
   output             q;
   reg 	         q;
   input cp, d;
   table
        (01) 1 : ? :  1 ;
        (01) 0 : ? :  0 ;
        (x1) 1 : 1 :  1 ;
        (x1) 0 : 0 :  0 ;
        (0x) 1 : 1 :  1 ;
        (0x) 0 : 0 :  0 ;
        (1x) ? : ? :  - ;
        (?0) ? : ? :  - ;
        ?    * : ? :  - ;
    endtable
endprimitive

`endif // !ifdef RTL
