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
 
 module sync_r2w #(
	parameter	ADDR_SIZE = 8
 )(
	input					wclk,
	input					wrst_n,
	input	[ADDR_SIZE:0]	rptr,
	output reg	[ADDR_SIZE:0]	wq2_rptr
 );
 
	reg		[ADDR_SIZE:0]	wq1_rptr;
	
	always @(posedge wclk, negedge wrst_n)
	begin
		if(!wrst_n) begin
			wq1_rptr <= 0;
			wq2_rptr <= 0;
		end
		else begin
			wq1_rptr <= rptr;
			wq2_rptr <= wq1_rptr;			
		end
	end
	
endmodule