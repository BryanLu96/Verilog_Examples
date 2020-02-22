module CLA_16(
	input [15:0] 		a, b,
	input 					c_in,
	output [15:0] 	s,
	output 					P, G,
	output					c_out
);
	
	wire g0, p0, g1, p1, g2, p2, g3, p3;
	wire c0, c1, c2, c3, c4;
	
	CLA_4 CLA_4_u0(.a(a[3:0]), .b(b[3:0]), .c_in(c0), .s(s[3:0]), .P(p0), .G(g0), .c_out());
	CLA_4 CLA_4_u1(.a(a[7:4]), .b(b[7:4]), .c_in(c1), .s(s[7:4]), .P(p1), .G(g1), .c_out());
	CLA_4 CLA_4_u2(.a(a[11:8]), .b(b[11:8]), .c_in(c2), .s(s[11:8]), .P(p2), .G(g2), .c_out());
	CLA_4 CLA_4_u3(.a(a[15:12]), .b(b[15:12]), .c_in(c3), .s(s[15:12]), .P(p3), .G(g3), .c_out());

	assign c0 = c_in;
	assign c_out = c4;
	assign c1 = g0 | p0 & c0;
	assign c2 = g1 | p1 & g0 | p1 & p0 & c0;
	assign c3 = g2 | p2 & g1 | p2 & p1 & g0 | p2 & p1 & p0 & c0;
	assign c4 = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0 | p3 & p2 & p1 & p0 & c0;
	
	assign P = p3 & p2 & p1 & p0;
	assign G = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0; 
endmodule