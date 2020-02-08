`timescale 1 ns/1 ns
module async_fifo_tb();
	parameter 	ADDR_SIZE = 8,
				DATA_SIZE = 32;
	parameter	CLOCK_A_PERIOD = 10,
				CLOCK_B_PERIOD = 40;
	
	reg 					wclk, rclk;
	reg						rrst_n, wrst_n;
	reg	 [DATA_SIZE-1:0]	wdata;
	reg						winc, rinc;
	
	wire [DATA_SIZE-1:0]	rdata;	
	wire					wfull, rempty;
	
	
	async_fifo #(DATA_SIZE, ADDR_SIZE) async_fifo_u0 (
		.wclk	(wclk		),
		.winc	(winc		),
		.wdata	(wdata		),
		.wrst_n	(wrst_n		),
		.wfull	(wfull		),
		.rclk	(rclk		),
		.rrst_n	(rrst_n		),
		.rdata	(rdata		),
		.rempty	(rempty		),
		.rinc	(rinc		)
	);
	
	//generate clock
	initial
	begin
		wclk = 1'b0;
		forever 
			#(CLOCK_A_PERIOD/2) wclk = ~wclk;	
	end
	
		//generate clock
	initial
	begin
		rclk = 1'b0;
		forever 
			#(CLOCK_B_PERIOD/2) rclk = ~rclk;	
	end
	
	initial 
	begin
		rrst_n = 1'b0;
		wrst_n = 1'b0;
		winc = 1'b0;
		rinc = 1'b0;
		#80 
		rrst_n = 1'b1;
		wrst_n = 1'b1;
		#10
		winc = 1'b1;
		repeat(2) @(posedge wclk);
		//rinc = 1'b1;
		
		//repeat(15) @(posedge wclk);
		//winc = 1'b0;
		#10000;
		$finish;		
	end
	
	always @(posedge wclk)
		wdata <= {$random}%256;
endmodule