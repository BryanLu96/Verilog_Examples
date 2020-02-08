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
 
 module wptr_full #(
	parameter	ADDR_SIZE = 8
 )(
	input						wclk,
	input						wrst_n,
	input						winc,
	input		[ADDR_SIZE:0]	wq2_rptr,
	
	output reg					wfull,
	output 		[ADDR_SIZE-1:0]	waddr,
	output reg	[ADDR_SIZE:0]	wptr 
 );
 
	reg [ADDR_SIZE:0]	wbin;
	wire [ADDR_SIZE:0]	wbinnext, wgraynext;
	wire wfull_value;
	//generate full
	assign wfull_value = (wgraynext == {~wq2_rptr[ADDR_SIZE:ADDR_SIZE-1],wq2_rptr[ADDR_SIZE-2:0]});
	
	always @(posedge wclk, negedge wrst_n)
	begin
		if(!wrst_n)
			wfull <= 1'b0;
		else
			wfull <= wfull_value;
	end
	
	//bin2gray comb
	assign wgraynext = (wbinnext >> 1) ^ wbinnext;
	
	//generate read address
	assign wbinnext = wbin + (winc & ~wfull);
	assign waddr = wbin[ADDR_SIZE-1:0];
 
	always @(posedge wclk, negedge wrst_n)
	begin
		if(!wrst_n)
			{wbin, wptr} <= 0;
		else
			{wbin, wptr} <= {wbinnext, wgraynext};
	end
	
 endmodule