//DATA_MEMORY code (data bus 128 bits) & (address bus 8 bits).
module data_mem (clk,we,addr,data_in,data_out) ;
 parameter addr_w=8,data_w=128;

input  clk,we;
input  [addr_w-1:0] addr; 
input  [data_w-1:0] data_in;
output [data_w-1:0] data_out;
reg    [addr_w-1:0] addr_reg;

reg [data_w-1:0] d_mem [2**addr_w-1:0] ;

always@ (posedge clk)
begin
 if (we) 
   d_mem[addr] <= data_in ;
  
 addr_reg <= addr ;
end
assign data_out = d_mem[addr_reg] ;
endmodule 