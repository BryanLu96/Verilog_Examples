 /*                                                                      
 Copyright 2020 Bryan Lu.
                                                                         
 Licensed under the Apache License, Version 2.0 (the "License");         
 you may not use this file except in compliance with the License.        
 You may obtain a copy of the License at                                 
                                                                         
     http://www.apache.org/licenses/LICENSE-2.0                          
                                                                         
 Unless required by applicable law or agreed to in writing, software    
 distributed under the License is distributed on an "AS IS" BASIS,       
 WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 See the License for the specific language governing permissions and     
 limitations under the License.                                          
 */
 
 //----------------------------------------
 //	Authur:	Bryan Lu
 //	Date:	2020.02.02
 //	Description: 	
 //		
 //----------------------------------------
 
module async_fifo #(
	parameter	DATA_WIDTH = 16,
	parameter	ADDR_SIZE = 8
)(
	//write clock domain
	input						wclk,
	input						winc,
	input	[DATA_WIDTH-1:0]	wdata,
	input						wrst_n,
	output						wfull,
	
	//read clock domain
	input						rclk,
	input						rrst_n,
	input						rinc,
	output	[DATA_WIDTH-1:0]	rdata,
	output						rempty
);

	wire	[ADDR_SIZE:0]		wptr, rptr, wq2_rptr, rq2_wptr;
	wire	[ADDR_SIZE-1:0]		waddr, raddr;
	
	fifomem #(DATA_WIDTH, ADDR_SIZE) fifomem_u0 (
		.wdata	(wdata			),
		.waddr	(waddr			),
		.wclken	(winc			),
		.wfull	(wfull			),
		.wclk	(wclk			),
		.raddr	(raddr			),
		.rdata	(rdata			)			
	);
	
	sync_w2r #(ADDR_SIZE) sync_w2r_u0 (
		.rclk	(rclk			),
		.rrst_n	(rrst_n			),
		.wptr	(wptr			),
		.rq2_wptr	(rq2_wptr	)
	);
	
	sync_r2w #(ADDR_SIZE) sync_r2w_u0 (
		.wclk	(wclk			),
		.wrst_n	(wrst_n			),
		.rptr	(rptr			),
		.wq2_rptr	(wq2_rptr	)
	);
	
	rptr_empty #(ADDR_SIZE) rptr_empty_u0 (
		.rclk	(rclk			),
		.rrst_n	(rrst_n			),
		.rinc	(rinc			),
		.rq2_wptr	(rq2_wptr	),
		.rempty	(rempty			),
		.raddr	(raddr			),
		.rptr 	(rptr			)
	);
	
	wptr_full #(ADDR_SIZE) wptr_full_u0 (
		.wclk	(wclk			),
		.wrst_n	(wrst_n			),
		.winc	(winc			),
		.wq2_rptr	(wq2_rptr	),
		.wfull	(wfull			),
		.waddr	(waddr			),
		.wptr 	(wptr			)
	);
	
endmodule

