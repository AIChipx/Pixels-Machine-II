module vreg_file
#(parameter DATA_WIDTH=128, parameter ADDR_WIDTH=4)
(
	input [(DATA_WIDTH-1):0] data_in_a, data_in_b,
	input [(ADDR_WIDTH-1):0] addr_a, addr_b,
	input we_a, we_b, clk,
	output reg [(DATA_WIDTH-1):0] data_out_a, data_out_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[addr_a] <= data_in_a;
			data_out_a <= data_in_a;
		end
		else 
		begin
			data_out_a <= ram[addr_a];
		end 
	end 

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[addr_b] <= data_in_b;
			data_out_b <= data_in_b;
		end
		else 
		begin
			data_out_b <= ram[addr_b];
		end 
	end

endmodule

