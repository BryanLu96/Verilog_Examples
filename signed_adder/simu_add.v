`timescale 1ns / 1ps

module simu_add();

	reg					i_clk		;//系统时钟	
	reg					i_rst_n		;//系统复位，低电平有效
	reg		[3:0]		i_data		;//数据输入口（最高位是符号位）
	reg					i_valid		;//数据有效（高有效）
	wire	[5:0]		o_data		;//输出数据口（最高位是符号位）
	wire				o_ready	 	;//输出数据有效
	
	initial begin
		i_clk = 1'b1;
		forever begin
			#5; i_clk = ~i_clk;
		end
	end
	
	initial begin
		i_data  = 4'b0000;
		i_valid = 1'b0;
		i_rst_n   = 1'b0;
		#200;
		i_rst_n   = 1'b1;
		#100;
		i_data  = 4'b0001;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b1110;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0011;
		i_valid = 1'b0;
		#10;
		i_data  = 4'b0010;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0001;
		i_valid = 1'b1;
		
		#10;
		i_data  = 4'b1101;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0010;
		i_valid = 1'b0;
		#10;
		i_data  = 4'b0011;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b1110;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0010;
		i_valid = 1'b1;
		
		#10;
		i_data  = 4'b0110;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0011;
		i_valid = 1'b0;
		#10;
		i_data  = 4'b0101;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b1101;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0010;
		i_valid = 1'b1;
		
		#10;
		i_data  = 4'b1011;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0011;
		i_valid = 1'b0;
		#10;
		i_data  = 4'b0010;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b1101;
		i_valid = 1'b1;
		#10;
		i_data  = 4'b0010;
		i_valid = 1'b1;
		#10;
		i_valid = 1'b0;
	end
	
	add my_add(
	.i_clk(i_clk),			//系统时钟	
	.i_rst_n(i_rst_n),      //系统复位，低电平有效
	.i_data(i_data),        //数据输入口（最高位是符号位）
	.i_valid(i_valid),      //数据有效（高有效）
	.o_data(o_data),        //输出数据口（最高位是符号位）
	.o_ready(o_ready)       //输出数据有效
    );
endmodule
