module CLA_1(
	input a, b ,c_in,
	output s,
	output g, p
);
	assign s = a ^ b ^ c_in;
	assign g = a & b; 
	assign p = a | b;

endmodule