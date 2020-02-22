`timescale 1ns / 1ps

module simu_pulse_cnt();

	reg					i_clk		;//系统时钟	
	reg					i_rst_n		;//系统复位，低电平有效	
	reg					i_pulse_en	;//脉冲使能，高电平有效
	reg					i_pulse		;//脉冲
	wire	[2:0]		o_bina		;//计数结果
	wire				o_ready		;//计数结果有效信号
	
	initial begin
		i_clk = 1'b1;
		forever begin
			#5; i_clk = ~i_clk;
		end
	end
	
	initial begin
		i_rst_n     = 1'b0;
		#100;
		i_rst_n     = 1'b1;
		#100;
		
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#100;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#20;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#30;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b1;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b1;
		i_pulse 	= 1'b0;
		#10;
		i_pulse_en  = 1'b0;
		i_pulse 	= 1'b0;
	end
	
	pulse_cnt my_pulse_cnt(
	.i_clk(i_clk),                    //系统时钟	
	.i_rst_n(i_rst_n),                //系统复位，低电平有效	
	.i_pulse_en(i_pulse_en),          //脉冲使能，高电平有效
	.i_pulse(i_pulse),                //脉冲
	.o_bina(o_bina),                  //计数结果
	.o_ready(o_ready)                 //计数结果有效信号
    );
endmodule
