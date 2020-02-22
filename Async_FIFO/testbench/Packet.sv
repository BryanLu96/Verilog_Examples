`ifndef INC_PACKET_SV
`define INC_PACKET_SV

class Packet;
	rand 	logic[31:0] data[$];
			string name;
	static	int	count = 0;
	
	constraint c {
		data.size() inside {[4:8]};
		//data.size() >= 4;
		//data.size() <= 8;
	}
	
	extern function new(string name = "Packet");
	extern function bit compare(Packet pkt2cmp, ref string message);
	extern function void display(string prefix = "NOTE");

endclass: Packet

function Packet::new(string name);
	this.name = name;
	count ++;
endfunction: new

function bit Packet::compare(Packet pkt2cmp, ref string message);
	if(this.data.size() != pkt2cmp.data.size()) begin
		message  =  "Payload Size Mismatch:\n";
		message  = { message, $sformatf("data.size() = %0d, pkt2cmp.data.size() = %0d\n", data.size(), pkt2cmp.data.size())  };
		return 0;
	end
	if(this.data == pkt2cmp.data) begin
		message = "Successfully compared\n";
		return 1;
	end
	else begin
		message = "Payload Content  Mismatch:\n";
		message = {message,$sformatf("Packet Sent: %p\n Pkt Received: %p", data, pkt2cmp.data)}; 
		return 0;
	end
endfunction: compare

function void Packet::display(string prefix);
	foreach(data[i])
		$display("[%s]%t %s data[%0d] = %0d", prefix, $realtime, name, i, data[i]);
endfunction: display

`endif