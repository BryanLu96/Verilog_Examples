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
 `timescale 1 ns/10 ps
 interface fifo_io (input bit wclk, input bit rclk);
	logic			rrst_n, wrst_n;
	logic [31:0]	rdata, wdata;
	logic 			winc, rinc;
	logic			wfull, rempty;
	
	clocking cb_w @(posedge wclk);
        default input #1ns output #1ns;
		output wrst_n;
        output wdata;
        output winc;
        input  wfull;
    endclocking: cb_w
	
	clocking cb_r @(posedge rclk);
        default input #1ns output #1ns;
		output rrst_n;
        input rdata;
        output rinc;
        input  rempty;
    endclocking: cb_r
	
	modport TEST (clocking cb_w,clocking cb_r, output wrst_n, output rrst_n);
	
	modport DUT (input wclk, rclk, wdata, winc, rinc, wrst_n, rrst_n,
				output wfull, rempty, rdata);
	
	
 endinterface: fifo_io


	