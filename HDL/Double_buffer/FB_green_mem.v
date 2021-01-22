// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module FB_green_mem
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH=20)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr,
	input we_2, clk,
	output reg [(DATA_WIDTH-1):0] q
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] g_ram[614399:0];

	always @ (posedge clk)
	begin
		// Write
		if (we_2)
		   begin
			g_ram[write_addr] <= data;
         end
	end
	
	always @ (posedge clk)
	begin
		// Read (if read_addr == write_addr, return OLD data).	To return
		// NEW data, use = (blocking write) rather than <= (non-blocking write)
		// in the write assignment.	 NOTE: NEW data may require extra bypass
		// logic around the RAM.
		
		   q <= g_ram[read_addr];
			//g_ram[read_addr] = 0;
			
	end


endmodule
