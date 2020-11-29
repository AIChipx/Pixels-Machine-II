//instruction_MEMORY code (data bus 60 bits) & (address bus 8 bits).
module instruction_mem (clk,we,addr,data_in,data_out) ;
 parameter addr_w=8,data_w=60;

input  clk,we;
input  [addr_w-1:0] addr; 
input  [data_w-1:0] data_in;
output [data_w-1:0] data_out;
reg    [addr_w-1:0] addr_reg;

reg [data_w-1:0] instr_mem [2**addr_w-1:0] ;

always@ (posedge clk)
begin
 if (we) 
   instr_mem[addr] <= data_in ;
  
 addr_reg <= addr ;
end
assign data_out = instr_mem[addr_reg] ;
endmodule 