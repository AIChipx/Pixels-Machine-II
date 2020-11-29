//special_register_file   (data bus 128 bits) & (address bus 4 bits).
module sreg_file (clk,we,r_addr,w_addr,data_in,data_out) ;
	parameter addr_w=4,data_w=128;

	input     clk,we;
	input     [addr_w-1:0] r_addr,w_addr; 
	input     [data_w-1:0] data_in;
	output    [data_w-1:0] data_out;


reg [data_w-1:0] sreg_file [2**addr_w-1:0] ;

always@ (posedge clk)
begin
 if (we) 
     begin
     sreg_file[w_addr] <= data_in ;
     end
end
 
assign data_out = sreg_file[r_addr];
	 
endmodule 