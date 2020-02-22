module fifo(
	input i_clk,			    //FIFO��дʱ��			
	input i_rst_n,          //��λ�źţ��͵�ƽ��Ч
	input i_wr_en,          //дʹ�ܣ��ߵ�ƽ��Ч
	input [7:0] i_din,              //д������
	input i_rd_en,          //��ʹ�ܣ��ߵ�ƽ��Ч
	input i_back,            //�����ź�
	                            
	output reg [7:0] o_dout,            //��������Ч�źţ���ʼ״̬Ϊ0
	output reg o_rd_valid,    //�������������ʼ״̬Ϊ0
	output o_empty,          //FIFO���źţ���ʼ״̬Ϊ1
	output o_full             //FIFO���źţ���ʼ״̬Ϊ0
);	



reg    [7:0] ram[7:0];//dual port��RAM
reg    [2:0] wr_ptr,rd_ptr;//д�Ͷ�ָ��
reg    [3:0] counter;//�����жϿ���

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
				o_dout<=o_empty ? 0:ram[rd_ptr];//�Ƚ��ȳ�����˶��Ļ����ɰ��մ�����
				o_rd_valid <= o_empty ? 1'b0 : 1'b1;
				counter<=o_empty ? counter :counter-1;
				wr_ptr <= wr_ptr;
				rd_ptr<=o_empty ? rd_ptr :((rd_ptr==7)?0:rd_ptr+1);
		  end
			2'b10: begin
				ram[wr_ptr]<=o_full ? ram[wr_ptr] : i_din;//д����
				counter<=o_full ? counter : counter+1;
				o_rd_valid <= 1'b0;
				rd_ptr <= rd_ptr;
				wr_ptr<=o_full ? wr_ptr : ((wr_ptr==7)?0:wr_ptr+1);
		  end
			2'b11: begin
				ram[wr_ptr]<=o_full ? ram[wr_ptr] : i_din;//��дͬʱ���У���ʱcounter������
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
