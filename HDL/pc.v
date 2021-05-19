//programe counter 
// Binary counter

module pc (clk,enable,reset,count);
	parameter WIDTH=8;
 
	input clk,enable,reset ;
	output reg [WIDTH-1:0] count ;

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			count <= 0;
		else if (enable)
			count <= count + 8'd1;
	end

endmodule
