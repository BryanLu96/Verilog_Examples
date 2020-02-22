`timescale 1 ns/100 ps

//#1延迟仅仅为仿真用，模拟触发器clk→q的延时，无其他意义
module add(
	input i_clk,			//系统时钟	
	input i_rst_n,      //系统复位，低电平有效
	input [3:0] i_data,        //数据输入口（最高位是符号位），补码的形式 
	input i_valid,      //数据有效（高有效）
	output reg [5:0] o_data,        //输出数据口（最高位是符号位），补码的形式
	output reg o_ready       //输出数据有效
 );
 
	reg [2:0] cnt;
	wire [5:0] data;
	
	assign data = {{2{i_data[3]}},i_data};  //符号位扩展
	
	always@(posedge i_clk, negedge i_rst_n) begin
		if(~i_rst_n)
			cnt <= #1 3'b0;
		else if(cnt == 3)
			cnt <= #1 3'b0;
		else if(i_valid)
			cnt <= #1 cnt + 1'b1;
		else
			cnt <= #1 cnt;
	end
	
	always@(posedge i_clk, negedge i_rst_n) begin
		if(!i_rst_n) begin
			o_data <= #1 6'b0;
		end
		else if(cnt == 0 && i_valid)
			o_data <= #1 i_data;
		else if((cnt <= 3 && cnt >= 1) && i_valid) begin
			o_data <= #1 o_data + i_data;  //无论正负，有符号数的补码加法都一致
		end
		else
			o_data <= o_data;
	end
	
	always@(posedge i_clk, negedge i_rst_n) begin
		if(!i_rst_n) begin
			o_ready <= #1 1'b0;
		end
		else if(cnt == 3)
			o_ready <= #1 1'b1;
		else
			o_ready <= #1 1'b0;
	end
	
endmodule