`timescale 1ns / 1ps

module simu_fifo(

    );
	
	reg 		i_clk = 0;
	reg 		i_rst_n = 0;
	reg  		i_wr_en = 0;
	reg  [7:0]	i_din = 0;
	reg 		i_rd_en = 0;
	reg 		i_back = 0;
	reg  [4:0]  i = 0;
	
	wire [7:0]  o_dout;
	wire        o_rd_valid;
	wire 		o_empty;
	wire 		o_full;
	
    parameter PERIOD = 10;
    always begin
       i_clk = 1'b1;
       #(PERIOD/2) i_clk = 1'b0;
       #(PERIOD/2);
    end	
	
	initial begin
		#100;		
		i_rst_n = 1'b1;
		#101;
		
		for (i = 0; i < 8; i = i + 1) begin
			i_wr_en = 1'b1;
			i_rd_en = 1'b0;
			i_back = 1'b0;
			i_din = i + 8'd1;
			#10;
		end
		
		for (i = 0; i < 8; i = i + 1) begin
			i_wr_en = 1'b0;
			i_rd_en = 1'b1;
			i_back = 1'b0;
			i_din = 8'd0;
			#10;
		end
		
		for (i = 0; i < 4; i = i + 1) begin
			i_wr_en = 1'b1;
			i_rd_en = 1'b1;
			i_back = 1'b0;
			i_din = i + 8'd7;
			#10;
		end
		
		for (i = 0; i < 4; i = i + 1) begin
			i_wr_en = 1'b1;
			i_rd_en = 1'b0;
			i_back = 1'b0;
			i_din = i + 8'd1;
			#10;
		end
		
		i_wr_en = 1'b0;
		i_rd_en = 1'b0;
		i_back = 1'b1;
		i_din = 8'd0;
		#20;
		
		for (i = 0; i < 4; i = i + 1) begin
			i_wr_en = 1'b0;
			i_rd_en = 1'b1;
			i_back = 1'b0;
			i_din = 8'd0;
			#10;
		end
		
	end
	
	fifo my_fifo(
	.i_clk(i_clk),			    //FIFO读写时钟			
	.i_rst_n(i_rst_n),          //复位信号，低电平有效
	.i_wr_en(i_wr_en),          //写使能，高电平有效
	.i_din(i_din),              //写入数据
	.i_rd_en(i_rd_en),          //读使能，高电平有效
	.i_back(i_back),            //回退信号
	                            
	.o_dout(o_dout),            //读数据有效信号，初始状态为0
	.o_rd_valid(o_rd_valid),    //读数据输出，初始状态为0
	.o_empty(o_empty),          //FIFO空信号，初始状态为1
	.o_full(o_full)             //FIFO满信号，初始状态为0
    );	
endmodule
