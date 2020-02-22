`timescale 1ns/1ps

`define FF 1
module pulse_cnt(
	input i_clk,                    //系统时钟	
	input i_rst_n,                //系统复位，低电平有效	
	input i_pulse_en,          //脉冲使能，高电平有效
	input i_pulse,                //脉冲
	output [2:0] o_bina,                  //计数结果
	output o_ready                 //计数结果有效信号
);
	reg i_pulse_r;
	reg edge_0, edge_1;
	wire posedge_sig;
	reg state;  //"1" enable, "0" disable
	reg [3:0]	cnt;
	
	always @(posedge i_clk, negedge i_rst_n) begin
		if(~i_rst_n)
			i_pulse_r <= 0;
		else
			i_pulse_r <= i_pulse;
	end
	
	
	//i_pulse_en positive edge detect
	always @(posedge i_clk, negedge i_rst_n) begin
		if(~i_rst_n)
			{edge_0, edge_1} <= #`FF 2'b0;
		else 
			{edge_0, edge_1} <= #`FF {i_pulse_en, edge_0};
	end
	
	assign posedge_sig = (edge_0 && (~edge_1)) ? 1'b1 : 1'b0;
	
	
	//start & end generate
	always @(posedge i_clk, negedge i_rst_n) begin
		if(~i_rst_n)
			state <= #`FF 1'b0;		 
		else if(posedge_sig)
			state <= #`FF ~state;  
		else
			state <= #`FF state;
	end
	
	always @(posedge i_clk, negedge i_rst_n) begin
		if(~i_rst_n)
			cnt <= #`FF 4'b0;
		else if(~state)
			cnt <= #`FF 4'b0;
		else if(state && i_pulse_r)
			cnt <= #`FF cnt + 1'b1;
		else
			cnt <= #`FF cnt;
	end
	
	assign o_ready = posedge_sig && state;
	assign o_bina = (cnt == 0 || cnt == 1) ? 3'b001:
									(cnt == 2 || cnt == 3) ? 3'b010:
									(cnt >= 4 && cnt <= 7) ? 3'b100:
									3'b000;
		
endmodule