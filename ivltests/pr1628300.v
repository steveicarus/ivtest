module bug;

function real sin;
	input x;
	real x;
	sin = 1.570794*x;
endfunction

real ax, ay;
initial begin
	ax = 2.0;
	ay = sin(ax);
	$display("sin(", ax, ") is not really ", ay);
end
endmodule
