`timescale 1 ns/100 ps

//#1�ӳٽ���Ϊ�����ã�ģ�ⴥ����clk��q����ʱ������������
module add(
	input i_clk,			//ϵͳʱ��	
	input i_rst_n,      //ϵͳ��λ���͵�ƽ��Ч
	input [3:0] i_data,        //��������ڣ����λ�Ƿ���λ�����������ʽ 
	input i_valid,      //������Ч������Ч��
	output reg [5:0] o_data,        //������ݿڣ����λ�Ƿ���λ�����������ʽ
	output reg o_ready       //���������Ч
 );
 
	reg [2:0] cnt;
	wire [5:0] data;
	
	assign data = {{2{i_data[3]}},i_data};  //����λ��չ
	
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
			o_data <= #1 o_data + i_data;  //�����������з������Ĳ���ӷ���һ��
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