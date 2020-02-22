`timescale 1ns/100ps
module CLA_32_tb;
	reg [31:0] a, b;
	wire [31:0] s;
	reg c_in;
	wire c_out;
	
	initial begin
		#10;
		repeat(10) begin
			#10 c_in = 0;
					a = $urandom;
					b = $urandom;
		end
		repeat(10) begin
			#10 c_in = 1;
					a = $urandom;
					b = $urandom;
		end
	
	end

	CLA_32 CLA_32_u0(.a(a), .b(b), .c_in(c_in), .s(s), .c_out(c_out));

endmodule