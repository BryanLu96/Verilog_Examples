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
 
 module sync_w2r #(
	parameter	ADDR_SIZE = 8
 )(
	input					rclk,
	input					rrst_n,
	input	[ADDR_SIZE:0]	wptr,
	output reg	[ADDR_SIZE:0]	rq2_wptr
 );
 
	reg		[ADDR_SIZE:0]	rq1_wptr;
	
	always @(posedge rclk, negedge rrst_n)
	begin
		if(!rrst_n) begin
			rq1_wptr <= 0;
			rq2_wptr <= 0;
		end
		else begin
			rq1_wptr <= wptr;
			rq2_wptr <= rq1_wptr;			
		end
	end
	
endmodule