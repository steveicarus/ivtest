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

// $Id: deposit.v,v 1.2 2001/05/18 13:14:49 ka6s Exp $

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
From - Fri May 18 05:18:49 2001
Return-Path: <stephan@nevis1.nevis.columbia.edu>
Received: from h14.mail.home.com ([24.0.95.48])
          by femail2.sdc1.sfba.home.com
          (InterMail vM.4.01.03.20 201-229-121-120-20010223) with ESMTP
          id <20010518072611.ZSAT1420.femail2.sdc1.sfba.home.com@h14.mail.home.com>
          for <stevew@mail.frmt1.sfba.home.com>;
          Fri, 18 May 2001 00:26:11 -0700
Received: from mx8-w.mail.home.com (mx8-w.mail.home.com [24.0.95.73])
	by h14.mail.home.com (8.9.3/8.9.0) with ESMTP id AAA11035
	for <stevew@home.com>; Fri, 18 May 2001 00:26:10 -0700 (PDT)
Received: from inspjury.offline.home (nevser-port2.nevis.columbia.edu [192.12.82.42])
	by mx8-w.mail.home.com (8.11.1/8.11.1) with ESMTP id f4I7Q8D23980
	for <stevew@home.com>; Fri, 18 May 2001 00:26:08 -0700 (PDT)
Received: (from stephan@localhost)
        by inspjury.offline.home (8.12.0.Beta5/8.12.0.Beta5/Debian 8.12.0-1) id f4I7Q1FF017881;
	Fri, 18 May 2001 03:26:01 -0400
Sender: stephan@nevis.columbia.edu
To: Stephen Williams <steve@icarus.com>, Steve Wilson <stevew@home.com>
Subject: Bogus ivltests/deposit.v
From: Stephan Boettcher <stephan@nevis1.nevis.columbia.edu>
Date: 18 May 2001 03:26:00 -0400
Message-ID: <rdae4bp187.fsf@inspjury.offline.home>
Lines: 35
User-Agent: Gnus/5.0808 (Gnus v5.8.8) Emacs/20.7
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="=-=-="
X-Mozilla-Status: 8001
X-Mozilla-Status2: 00000000
X-UIDL: <rdae4bp187.fsf@inspjury.offline.home>

--=-=-=


Hi Steve, Steve,

ivltests/deposit.v fails on Verilog-XL exactly the same way as on
VVP.  To work as expected, vpi_put_value() would need to propagate
the value back to the driving gate, so that at the next (clock) edge a
change to the old value can be detected and propagated.  

The conclusion is that the ivltests/deposit.v test is bogus.  I
replaced it with a better one (attached).

VVM and VVP both fail the new test, but VVP is almost there.  Stephen
changed the vvp code generator to pass the signal through all wires of
the nexus, but not always in the correct order.  A structural netlist
simulation works, but behavioural probes into the netlist fail
sometimes.

I would go and try to solve this via .alias, and make all wires on a
nexus physically the same functor, but I guess this conflicts with
the work on drive strength modeling.

Cheers
Stephan

Tests passed: 228, failed: 56, Unhandled: 45 Unable: 28, Assert: 48, Parse Errs: 2


--=-=-=
Content-Type: text/x-verilog
Content-Disposition: attachment; filename=deposit.v
Content-Description: ivltests/deposit.v

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

// $Id: deposit.v,v 1.2 2001/05/18 13:14:49 ka6s Exp $

// Test for vpi_put_value() to properly propagate in structural context.

module deposit_test;

   reg ck;

   reg start;
   initial start = 0;
   
`ifdef RTL

   reg [3:0] cnt;
   wire      cnt_tc = &cnt;
   
   always @(posedge ck)
     if (start | ~cnt_tc)
       cnt <= cnt + 1;

`else // !ifdef RTL

   wire [3:0] cnt;
   wire [3:0] cnt_1;
   wire [3:0] cnt_c;
   wire       cnt_tc;
   wire       ne, e;
   
   and (cnt_tc, cnt[0], cnt[1], cnt[2], cnt[3]);
   not (ne, cnt_tc);
   or (e, ne, start);

   had A0 (cnt[0],     1'b1,  cnt_c[0], cnt_1[0]);
   had A1 (cnt[1], cnt_c[0],  cnt_c[1], cnt_1[1]);
   had A2 (cnt[2], cnt_c[1],  cnt_c[2], cnt_1[2]);
   had A3 (cnt[3], cnt_c[2],  cnt_c[3], cnt_1[3]);
   
   dffe C0 (ck, e, cnt_1[0], cnt[0]);
   dffe C1 (ck, e, cnt_1[1], cnt[1]);
   dffe C2 (ck, e, cnt_1[2], cnt[2]);
   dffe C3 (ck, e, cnt_1[3], cnt[3]);

`endif // !ifdef RTL
   
   integer    r0; initial r0 = 0;
   integer    r1; initial r1 = 0;

   always
     begin
	#5 ck <= 0;
	#4;
	$display("%b %b %d %d", cnt, cnt_tc, r0, r1);
	if (cnt_tc === 1'b0) r0 = r0 + 1;
	if (cnt_tc === 1'b1) r1 = r1 + 1;
	#1 ck <= 1;
     end
   
   initial
     begin
	// $dumpfile("deposit.vcd");
	// $dumpvars(0, deposit_test);
	#22;
`ifdef RTL
	cnt <= 4'b 1010;
`else
	$deposit(C0.Q, 1'b0);
	$deposit(C1.Q, 1'b1);
	$deposit(C2.Q, 1'b0);
	$deposit(C3.Q, 1'b1);
`endif
	#1 if (cnt !== 4'b1010)
	  $display("FAILED");
	#99;
	$display("%d/%d", r0, r1);
	if (r0===5 && r1===5)
	  $display("PASSED");
	else
	  $display("FAILED");
	$finish;
     end
   
endmodule

`ifdef RTL
`else

module dffe (CK, E, D,  Q);
   input  CK, E, D;
   output Q;
   UDP_dffe ff (Q, CK, E, D);
endmodule

primitive UDP_dffe (q,  cp, e, d);
   output                q;
   reg 	            q;
   input cp, e, d;
   table
        (01) 1  1 : ? :  1 ;
        (01) 1  0 : ? :  0 ;
         *   0  ? : ? :  - ;
         *   ?  1 : 1 :  - ;
         *   ?  0 : 0 :  - ;
        (1x) ?  ? : ? :  - ;
        (?0) ?  ? : ? :  - ;
         ?   ?  * : ? :  - ;
         ?   *  ? : ? :  - ;
    endtable
endprimitive

module had (A, B,  C, S);
   input A, B;
   output C, S;
   xor s (S, A, B);
   and c (C, A, B);
endmodule

`endif // !ifdef RTL

--=-=-=



-- 
Stephan Boettcher                                   FAX: +1-914-591-4540
Columbia University, Nevis Labs                     Tel: +1-914-591-2863
P.O. Box 137, 136 South Broadway       mailto:stephan@nevis.columbia.edu
Irvington, NY 10533, USA          http://www.nevis.columbia.edu/~stephan

--=-=-=--
