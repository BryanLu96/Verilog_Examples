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
 
 module rptr_empty #(
	parameter	ADDR_SIZE = 8
 )(
	input						rclk,
	input						rrst_n,
	input						rinc,
	input		[ADDR_SIZE:0]	rq2_wptr,
	
	output reg					rempty,
	output 		[ADDR_SIZE-1:0]	raddr,
	output reg	[ADDR_SIZE:0]	rptr 
 );
 
	reg [ADDR_SIZE:0]	rbin;
	wire [ADDR_SIZE:0]	rbinnext, rgraynext;
	wire rempty_value;
	//generate full
	assign rempty_value = (rgraynext == rq2_wptr);
	
	always @(posedge rclk, negedge rrst_n)
	begin
		if(!rrst_n)
			rempty <= 1'b1;
		else
			rempty <= rempty_value;
	end
	
	//bin2gray comb
	assign rgraynext = (rbinnext >> 1) ^ rbinnext;
	
	//generate read address
	assign rbinnext = rbin + (rinc & ~rempty);
	assign raddr = rbin[ADDR_SIZE-1:0];
 
	always @(posedge rclk, negedge rrst_n)
	begin
		if(!rrst_n)
			{rbin, rptr} <= 0;
		else
			{rbin, rptr} <= {rbinnext, rgraynext};
	end
	
 endmodule