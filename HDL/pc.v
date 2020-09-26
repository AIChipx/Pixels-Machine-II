module pc
#(parameter WIDTH=8)
(
	input clk, enable, reset,
	output reg [WIDTH-1:0] addr
);

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			addr <= 0;
		else if (enable == 1'b1)
			addr <= addr + 1;
	end

endmodule

