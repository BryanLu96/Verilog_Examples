`timescale 1ns / 1ps

module sim_sequencer(

    );
	
	reg  i_clk = 0;
	reg  i_rst_n = 0;
	reg  i_valid = 0;
	reg  i_data = 0;
	
	wire o_en;
	wire [2:0]o_cnt;
	
    parameter PERIOD = 10;
    always begin
       i_clk = 1'b1;
       #(PERIOD/2) i_clk = 1'b0;
       #(PERIOD/2);
    end	
	
	initial begin
		i_rst_n = 1'b0;
		#100;
		i_rst_n = 1'b1;
		#100;
		
		i_valid = 1'b0;
		i_data = 1'b1;
		#10;
		i_valid = 1'b0;
		i_data = 1'b1;
		#10;
		i_valid = 1'b0;
		i_data = 1'b0;
		#10;
		i_valid = 1'b0;
		i_data = 1'b1;
		#10;
		
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b0;
		#10;
		i_valid = 1'b0;
		i_data = 1'b1;
		#10;		
		i_valid = 1'b1;
		i_data = 1'b0;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b0;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b0;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b0;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b1;
		#10;
		i_valid = 1'b1;
		i_data = 1'b0;
		#10;
	end
	
	sequencer my_sequencer(
	.i_clk(i_clk),             //系统时钟
	.i_rst_n(i_rst_n),         //系统复位，低电平有效
	.i_valid(i_valid),         //输入有效，高电平有效
	.i_data(i_data),           //输入数据
	                           
	.o_en(o_en),               //有效序列检测到标志
	.o_cnt(o_cnt)              //有效序列计数
    );	
	
endmodule
