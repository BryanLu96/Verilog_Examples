program automatic async_fifo_test #(
	parameter int DATA_SIZE = 32,
	parameter int ADDR_SIZE = 8
)(
	fifo_io.TEST if_t
);
	int						pkg_number_for_test;
	`include "Packet.sv"
	
	logic [DATA_SIZE-1:0]	payload[$];	
	logic [DATA_SIZE-1:0]	pkg2cmp_payload[$];
		Packet pkg2send;
		Packet pkg2cmp;
	
	initial begin
		$timeformat(-9,0,"ns",5);
		pkg_number_for_test = 5;
		reset();


		repeat(pkg_number_for_test) begin
			gen();
			fork 
				send();
				recv();
			join
			check();
		end
		//repeat(15) @(if_t.cb_w);
	end
	
	
	task gen();
		static int pkg_send_number=0;
		pkg2send = new($sformatf("Packet send [%0d]", pkg_send_number));
		a1: assert(pkg2send.randomize())
		else $error("Packet randomize failed.\n");
		payload = pkg2send.data;
	endtask: gen
	
	task send();
		$display("%t: Send %0d packages.",$realtime, Packet::count);
		if_t.cb_w.winc <= 1'b1;		
		for(int i = 0; i < pkg2send.data.size();) begin
			if(~if_t.cb_w.wfull) begin
				if_t.cb_w.wdata <= payload[i];
				i += 1;
			end
			@(if_t.cb_w);
		end
		if_t.cb_w.winc <= 1'b0;
		if_t.cb_w.wdata <= 32'b0;
		@(if_t.cb_w);
	endtask: send
	
	task recv();
		static int pkg_recv_number=0;
		pkg2cmp = new($sformatf("Packet recv [%0d]", pkg_recv_number));
		get_payload();
		pkg2cmp.data = pkg2cmp_payload;
	endtask: recv

	task get_payload();
		if_t.cb_r.rinc <= 1'b1;
		for (int i = 0; i < pkg2send.data.size();) begin
			if(~if_t.cb_r.rempty) begin
				pkg2cmp_payload.push_back(if_t.cb_r.rdata);
				i++;
			end
			@(if_t.cb_r);
		end
		if_t.cb_r.rinc <= 1'b0;
		@(if_t.cb_r);
		//$display("%t: Receive one payload.",$realtime);
	endtask: get_payload
	
	
	task check();
		string message;
		static int pkg_check_number = 0;
		
		if(!pkg2send.compare(pkg2cmp, message)) begin
			$display ("\n%m\n [ERROR] %t  Packet  #%0d  %s\n",  $realtime, pkg_check_number,  message); 
			pkg2send.display("ERROR"); 
			pkg2cmp.display("ERROR");
			$finish;
		end
		else
			$display ("[NOTE] %t  Packet  #%0d  %s\n",  $realtime, pkg_check_number++,  message); 	
	endtask: check
	
	task reset();
		$display("%t: Reset all signals.",$realtime);
		if_t.rrst_n <= 1'b0;
		if_t.wrst_n <= 1'b0;
		repeat(2) @(if_t.cb_w);
		if_t.cb_w.winc <= 1'b0;
		if_t.cb_w.wdata <= 32'b0;
		if_t.cb_w.wrst_n <= 1'b1;
		repeat(2) @(if_t.cb_r);
		if_t.cb_r.rrst_n <= 1'b1;
		if_t.cb_r.rinc <= 1'b0;
		repeat(5) @(if_t.cb_w);
	endtask: reset
	
endprogram: async_fifo_test