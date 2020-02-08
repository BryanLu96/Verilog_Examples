`timescale 1 ns/10 ps

module top;
	parameter 	DSIZE = 32,
				ASIZE = 4;
	
	bit wclk, rclk;
	
	fifo_io fif(wclk, rclk);
	
	async_fifo #(DSIZE, ASIZE) dut(
		.wclk	(fif.wclk	),
		.rclk	(fif.rclk	),
		.rrst_n	(fif.rrst_n	),
		.wrst_n	(fif.wrst_n	),
		.wdata	(fif.wdata	),
		.rdata	(fif.rdata	),
		.winc	(fif.winc	),
		.rinc	(fif.rinc	),
		.wfull	(fif.wfull	),
		.rempty	(fif.rempty	)
	);
	
	async_fifo_test test(fif);

	//generate clock
	initial begin
		wclk = 0;
		forever
			#5 wclk = ~wclk;
	end
	
	initial begin
		rclk = 0;
		forever
			#10 rclk = ~rclk;
	end
endmodule
