// Quartus Prime Verilog Template
// Simple Dual Port RAM with separate read/write addresses and
// single read/write clock

module FB_red_mem
#(parameter DATA_WIDTH=1, parameter ADDR_WIDTH=20)
(
	input [(DATA_WIDTH-1):0] data,
	input [(ADDR_WIDTH-1):0] read_addr, write_addr, 
	input we_2, clk,
	output reg [(DATA_WIDTH-1):0] q
);
  

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] r_ram[614399:0];
	always @ (posedge clk)
	begin
		// Write
		if (we_2)
		   begin
			r_ram[write_addr] <= data;
         end
	end
	
	always @ (posedge clk)
	begin
	
		
		   q <= r_ram[read_addr] ;
			//r_ram[read_addr] = 0 ;
			
	end

endmodule
