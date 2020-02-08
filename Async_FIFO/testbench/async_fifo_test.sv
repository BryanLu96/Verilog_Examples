program automatic async_fifo_test #(
	parameter int DATA_SIZE = 32,
	parameter int ADDR_SIZE = 8
)(
	fifo_io.TEST if_t
);
	logic [DATA_SIZE-1:0]	payload[$];	
	logic 					winc,rinc;
	logic [DATA_SIZE-1:0]	pkg2cmp_payload[$];
	int						pkg_number;
	
	initial begin
		$timeformat(-9,0,"ns",5);
		reset();
		
		pkg_number = 5;
		repeat(pkg_number) begin
			gen();
			fork 
			send();
			recv();
			join
			check();
		end
		repeat(15) @(if_t.cb_w);
	end
	
	
	// task send();
		// gen();
		// send_package();
	// endtask: send
	
	task gen();
		payload.delete();
		repeat(8)
			payload.push_back($urandom);
	endtask: gen
	
	task send();
		$display("%t: Send %d packages.",$realtime, pkg_number);
		
		foreach(payload[index]) begin
			if(~if_t.cb_w.wfull) begin
				if_t.cb_w.winc <= 1'b1;
				if_t.cb_w.wdata <= payload[index];
			end
			@(if_t.cb_w);
		end
		if_t.cb_w.winc <= 1'b0;
		@(if_t.cb_w);
	endtask: send
	
	task recv();
		pkg2cmp_payload.delete();
		for (int i = 0; i < 8; i++) begin
			if(~if_t.cb_r.rempty) begin
				if_t.cb_r.rinc <= 1'b1;
				pkg2cmp_payload.push_back(if_t.cb_r.rdata);
			end
			@(if_t.cb_r);
		end
		if_t.cb_r.rinc <= 1'b0;
		@(if_t.cb_r);
		$display("%t: Receive one packages.",$realtime);

	endtask: recv
	
	task check();
		for (int i = 0; i < 8; i++) begin
			if(pkg2cmp_payload[i] == payload[i])
			$display("%t: [ERROR] %d packages fail.",$realtime, i);
				//$finish;
				return;
		end
		$display("%t: [NOTE] packages success.",$realtime);
	
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