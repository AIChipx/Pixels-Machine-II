//special_register_file // Single Port ROM  (data bus 128 bits) & (address bus 4 bits).
module sreg_file (clk,r_addr,data_out) ;
	parameter addr_w=4,data_w=8;

	input     clk;
	input     [addr_w-1:0] r_addr; 
	output  reg  [data_w-1:0] data_out;


reg [data_w-1:0] sregfile[2**addr_w-1:0] ;

initial
	begin
		$readmemb("sreg_file_init.txt", sregfile);
	end
	
always @ (posedge clk)
	begin
		data_out <= sregfile[r_addr];
	end	
	 
endmodule 