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

module fifomem #(
	parameter	DATA_WIDTH = 16,
	parameter	ADDR_SIZE = 8
)(
	//clock WR domain
	input 	[DATA_WIDTH-1:0]	wdata,
	input 	[ADDR_SIZE-1:0]		waddr,
	input						wclken,
	input						wfull,
	input						wclk,
	//clock RD domain
	input 	[ADDR_SIZE-1:0]		raddr,
	output 	[DATA_WIDTH-1:0]	rdata
);
	
	localparam	DEPTH = 1 << ADDR_SIZE;
	
	reg [DATA_WIDTH-1:0]	mem [0:DEPTH-1];
	
	//fifomem write
	always @(posedge wclk)
	begin
		if(wclken && (!wfull)) begin
			mem[waddr] <= wdata;
		end
	end
	
	//fifomem read
	assign rdata = mem[raddr];


endmodule