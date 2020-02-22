module CLA_32(
	input [31:0] 		a, b,
	input 					c_in,
	output [31:0] 	s,
	//output 					P, G
	output					c_out
);
	
	wire g0, p0, g1, p1;
	wire c0, c1, c2;
	
	CLA_16 CLA_16_u0(.a(a[15:0]), .b(b[15:0]), .c_in(c0), .s(s[15:0]), .P(p0), .G(g0), .c_out());
	CLA_16 CLA_16_u1(.a(a[31:16]), .b(b[31:16]), .c_in(c1), .s(s[31:16]), .P(p1), .G(g1), .c_out());
	
	assign c0 = c_in;
	assign c_out = c2;
	assign c1 = g0 | p0 & c0;
	assign c2 = g1 | p1 & g0 | p1 & p0 & c0;
	//assign c3 = g2 | p2 & g1 | p2 & p1 & g0 | p2 & p1 & p0 & c0;
	//assign c4 = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0 | p3 & p2 & p1 & p0 & c0;
	
	//assign P = p3 & p2 & p1 & p0;
	//assign G = g3 | p3 & g2 | p3 & p2 & g1 | p3 & p2 & p1 & g0; 
endmodule