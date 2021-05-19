//vector_register_file  dual port (data bus a&B 128 bits) & (address bus a&b 4 bits).
module vreg_file (clk,we_a,we_b,r_addr_a,r_addr_b,w_addr_a,w_addr_b,data_in_a,data_in_b,data_out_a,data_out_b) ;
	parameter addr_w=4,data_w=128;

	input     clk,we_a,we_b;
	input     [addr_w-1:0] r_addr_a,r_addr_b,w_addr_a,w_addr_b; 
	input     [data_w-1:0] data_in_a,data_in_b;
	output    [data_w-1:0] data_out_a,data_out_b;


reg [data_w-1:0] vreg_file [2**addr_w-1:0] ;

always@ (posedge clk)
begin
 if (we_a) 
     begin
     vreg_file[w_addr_a] <= data_in_a ;
     end
 end
 
assign data_out_a = vreg_file[r_addr_a];
	  
always@ (posedge clk)
begin
 if (we_b) 
     begin
     vreg_file[w_addr_b] <= data_in_b ;
     end
 end
 
assign data_out_b = vreg_file[r_addr_b];

endmodule 