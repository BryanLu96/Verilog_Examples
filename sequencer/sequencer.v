module sequencer(
	input i_clk,             //系统时钟
	input i_rst_n,         //系统复位，低电平有效
	input i_valid,         //输入有效，高电平有效
	input i_data,           //输入数据
	                           
	output reg o_en,               //有效序列检测到标志
	output [2:0] o_cnt              //有效序列计数
);

	localparam 	IDLE = 3'b000,
							S_1	= 3'b001,
							S_2 = 3'b010,
							S_3 = 3'b011;
							
							
	reg [2:0] state, next_state;
	reg [2:0] cnt;
	
	assign o_cnt = cnt;
	
	always @(posedge i_clk, negedge i_rst_n) begin
		if(!i_rst_n)
			state <= IDLE;
		else
			state <= next_state;
	end
	
	always @(*) begin
		if(!i_rst_n)
			next_state <= IDLE;
		case (state)
			IDLE:	begin
							if(!i_valid) next_state <= IDLE;
							else if(i_data) next_state <= S_1;
							else next_state <= IDLE;
						end
			S_1:	begin
							if(!i_valid) next_state <= S_1;
							else if(i_data) next_state <= S_2;
							else next_state <= IDLE;
						end
			S_2:	begin
							if(!i_valid) next_state <= S_2;
							else if(i_data) next_state <= S_2;
							else if(~i_data) next_state <= S_3;
							else next_state <= IDLE;
						end
			S_3:	begin
							if(!i_valid) next_state <= S_3;
							else if(i_data) next_state <= IDLE;
							else next_state <= IDLE;
						end
			default: begin
							next_state <= IDLE;
						end
		endcase
	end
	
	always @(posedge i_clk, negedge i_rst_n) begin
		if(!i_rst_n)
			o_en <= 0;
		else if(next_state == S_3 && i_valid && i_data)
			o_en <= 1;
		else 
			o_en <= 0;
	end
	
	always @(posedge i_clk, negedge i_rst_n) begin
		if(!i_rst_n)
			cnt <= 3'b000;
		else if(cnt == 7)
			cnt <= cnt;
		else if(o_en)
			cnt <= cnt + 1;
		else
			cnt <= cnt;
	end
	
endmodule
	