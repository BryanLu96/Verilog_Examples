module fifo(
	input i_clk,			    //FIFO读写时钟			
	input i_rst_n,          //复位信号，低电平有效
	input i_wr_en,          //写使能，高电平有效
	input [7:0] i_din,              //写入数据
	input i_rd_en,          //读使能，高电平有效
	input i_back,            //回退信号
	                            
	output reg [7:0] o_dout,            //读数据有效信号，初始状态为0
	output reg o_rd_valid,    //读数据输出，初始状态为0
	output o_empty,          //FIFO空信号，初始状态为1
	output o_full             //FIFO满信号，初始状态为0
);	



reg    [7:0] ram[7:0];//dual port　RAM
reg    [2:0] wr_ptr,rd_ptr;//写和读指针
reg    [3:0] counter;//用来判断空满

always@(posedge i_clk, negedge i_rst_n) begin
	if(!i_rst_n) begin
		counter <= 0;
		o_dout <= 0;
		wr_ptr <= 0;
		rd_ptr <= 0;
		o_rd_valid <= 0;
	end
	else if(i_back) begin
		if(counter == 0) begin
			counter <= 0;
			o_dout <= 0;
			wr_ptr <= 0;
			rd_ptr <= 0;
			o_rd_valid <= 0;
		end
		else begin
			counter <= counter-1;
			wr_ptr <= wr_ptr - 1;
			rd_ptr <= rd_ptr;
			o_dout <= 0;
			o_rd_valid <= 1'b0;
		end
	end
	else begin
		case({i_wr_en,i_rd_en})
			2'b00: begin
				counter<=counter;
				wr_ptr <= wr_ptr;
				rd_ptr <= rd_ptr;
				o_dout <= 0;
				o_rd_valid <= 1'b0;
			end
			2'b01: begin
				o_dout<=o_empty ? 0:ram[rd_ptr];//先进先出，因此读的话依旧按照次序来
				o_rd_valid <= o_empty ? 1'b0 : 1'b1;
				counter<=o_empty ? counter :counter-1;
				wr_ptr <= wr_ptr;
				rd_ptr<=o_empty ? rd_ptr :((rd_ptr==7)?0:rd_ptr+1);
		  end
			2'b10: begin
				ram[wr_ptr]<=o_full ? ram[wr_ptr] : i_din;//写操作
				counter<=o_full ? counter : counter+1;
				o_rd_valid <= 1'b0;
				rd_ptr <= rd_ptr;
				wr_ptr<=o_full ? wr_ptr : ((wr_ptr==7)?0:wr_ptr+1);
		  end
			2'b11: begin
				ram[wr_ptr]<=o_full ? ram[wr_ptr] : i_din;//读写同时进行，此时counter不增加
				o_dout<=o_empty ? 0:ram[rd_ptr];
				o_rd_valid <= o_empty ? 1'b0 : 1'b1;
				wr_ptr<=o_full ? wr_ptr : ((wr_ptr==7)?0:wr_ptr+1);
				rd_ptr<=o_empty ? rd_ptr :((rd_ptr==7)?0:rd_ptr+1);
				counter <= o_empty ? counter + 1 : o_full ? counter-1 : counter;
			end
			
		endcase
	end
end

assign o_empty=(counter==0)?1:0;
assign o_full =(counter==8)?1:0;


endmodule
