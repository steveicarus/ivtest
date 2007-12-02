// Copyright 2007, Martin Whitaker
// This file may be freely copied for any purpose.
module macro_with_args();

`define	forward_and_reverse(str1,str2,str3) /* comment */ \
  $write(str1); /* comment */ \
  $write(".."); /* comment */ \
  $write(str3); /* comment */ \
  $write(str2); /* comment */ \
  $write(str3); /* comment */ \
  $write(".."); /* comment */ \
  $write(str1); /* comment */ \
  $write("\n")

`define	sqr( x ) (x * x) // comment

`define	sum( a /* comment */ , b /* comment */ ) /* comment */ \
  (a + b)

`define sumsqr( 
    a // comment
  ,
    b // comment
  ) \
  `sum ( \
    `sqr(a) \
   , \
    `sqr(b) \
   )

`define no_args (a,b,c)

`define null1 // null
`define null2

integer	value;

initial begin
  `forward_and_reverse("first"," first,last ","last");

  `forward_and_reverse  // comment
    (			// comment
     "(a`null1)"	// comment
    ,			// comment
     " `no_args "	// comment
    ,			// comment
     "(c`null2)"	// comment
    );			// comment

  value = `sumsqr(3,4);
  $display("sumsqr(3,4)  = %1d", value);
  if (value != `sqr(5)) $display("sumsqr expansion failed");

  value = `sumsqr
           (
            (2 + 3) /* 5 */
           ,
            (4 + 8) /* 12 */
           );
  $display("sumsqr(5,12) = %1d", value);
  if (value != `sqr(13)) $display("sumsqr expansion failed");
end

endmodule
