module CLA_4(
	input [3:0] 	a, b,
	input 				c_in,
	output [3:0] 	s,
	output 				P, G,
	output				c_out
);
	
	wire g0, p0, g1, p1, g2, p2, g3, p3;
	wire c0, c1, c2, c3, c4;
	
	CLA_1 CLA_1_u0(.a(a[0]), .b(b[0]), .c_in(c0), .s(s[0]), .p(p0), .g(g0) );
	CLA_1 CLA_1_u1(.a(a[1]), .b(b[1]), .c_in(c1), .s(s[1]), .p(p1), .g(g1) );
	CLA_1 CLA_1_u2(.a(a[2]), .b(b[2]), .c_in(c2), .s(s[2]), .p(p2), .g(g2) );
	CLA_1 CLA_1_u3(.a(a[3]), .b(b[3]), .c_in(c3), .s(s[3]), .p(p3), .g(g3) );

	assign c0 = c_in;
	assign c_out = c4;
	assign c1 = g0 | p0 & c0;
	assign c2 = g1 | p1 & g0 | p1 & p0 & c0;
	assign c3 = g2 | p2 & g1 | p2 & p1 & g0 | p2 & p1 & p0 & c0;
	assign c4 = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0 | p3 & p2 & p1 & p0 & c0;
	
	assign P = p3 & p2 & p1 & p0;
	assign G = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0; 
endmodule