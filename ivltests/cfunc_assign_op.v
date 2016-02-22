module test();

function integer pre_inc(input integer x);
begin
  ++x;
  pre_inc = x;
end
endfunction

function integer pre_dec(input integer x);
begin
  --x;
  pre_dec = x;
end
endfunction

function integer post_inc(input integer x);
begin
  x++;
  post_inc = x;
end
endfunction

function integer post_dec(input integer x);
begin
  x--;
  post_dec = x;
end
endfunction

function integer add2(input integer x);
begin
  x += 2;
  add2 = x;
end
endfunction

function integer sub2(input integer x);
begin
  x -= 2;
  sub2 = x;
end
endfunction

function integer mul2(input integer x);
begin
  x *= 2;
  mul2 = x;
end
endfunction

function integer div2(input integer x);
begin
  x /= 2;
  div2 = x;
end
endfunction

function integer mod2(input integer x);
begin
  x %= 2;
  mod2 = x;
end
endfunction

function [3:0] and6(input [3:0] x);
begin
  x &= 4'h6;
  and6 = x;
end
endfunction

function [3:0] or6(input [3:0] x);
begin
  x |= 4'h6;
  or6 = x;
end
endfunction

function [3:0] xor6(input [3:0] x);
begin
  x ^= 4'h6;
  xor6 = x;
end
endfunction

function integer lsl2(input integer x);
begin
  x <<= 2;
  lsl2 = x;
end
endfunction

function integer lsr2(input integer x);
begin
  x >>= 2;
  lsr2 = x;
end
endfunction

function integer asl2(input integer x);
begin
  x <<<= 2;
  asl2 = x;
end
endfunction

function integer asr2(input integer x);
begin
  x >>>= 2;
  asr2 = x;
end
endfunction

localparam pre_inc_5 = pre_inc(5);
localparam pre_dec_5 = pre_dec(5);

localparam post_inc_5 = post_inc(5);
localparam post_dec_5 = post_dec(5);

localparam add2_5 = add2(5);
localparam sub2_5 = sub2(5);
localparam mul2_5 = mul2(5);
localparam div2_5 = div2(5);
localparam mod2_5 = mod2(5);

localparam and6_f = and6(4'hf);
localparam  or6_0 =  or6(4'h0);
localparam xor6_f = xor6(4'hf);

localparam lsl2_p25 = lsl2( 25);
localparam lsr2_m25 = lsr2(-25);
localparam asl2_m25 = asl2(-25);
localparam asr2_m25 = asr2(-25);

reg failed = 0;

initial begin
  $display("pre_inc_5 = %0d", pre_inc_5);
  if (pre_inc_5 !== pre_inc(5)) failed = 1;

  $display("pre_dec_5 = %0d", pre_dec_5);
  if (pre_dec_5 !== pre_dec(5)) failed = 1;

  $display("post_inc_5 = %0d", post_inc_5);
  if (post_inc_5 !== post_inc(5)) failed = 1;

  $display("post_dec_5 = %0d", post_dec_5);
  if (post_dec_5 !== post_dec(5)) failed = 1;

  $display("add2_5 = %0d", add2_5);
  if (add2_5 !== add2(5)) failed = 1;

  $display("sub2_5 = %0d", sub2_5);
  if (sub2_5 !== sub2(5)) failed = 1;

  $display("mul2_5 = %0d", mul2_5);
  if (mul2_5 !== mul2(5)) failed = 1;

  $display("div2_5 = %0d", div2_5);
  if (div2_5 !== div2(5)) failed = 1;

  $display("mod2_5 = %0d", mod2_5);
  if (mod2_5 !== mod2(5)) failed = 1;

  $display("and6_f = %h", and6_f);
  if (and6_f !== and6(4'hf)) failed = 1;

  $display("or6_0 = %h", or6_0);
  if (or6_0 !==  or6(4'h0)) failed = 1;

  $display("xor6_f = %h", xor6_f);
  if (xor6_f !== xor6(4'hf)) failed = 1;

  $display("lsl2_p25 = %0d", lsl2_p25);
  if (lsl2_p25 !== lsl2( 25)) failed = 1;

  $display("lsr2_m25 = %0d", lsr2_m25);
  if (lsr2_m25 !== lsr2(-25)) failed = 1;

  $display("asl2_m25 = %0d", asl2_m25);
  if (asl2_m25 !== asl2(-25)) failed = 1;

  $display("asr2_m25 = %0d", asr2_m25);
  if (asr2_m25 !== asr2(-25)) failed = 1;

  if (failed)
    $display("FAILED");
  else
    $display("PASSED");
end

endmodule
