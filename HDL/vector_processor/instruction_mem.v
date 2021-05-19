//instruction_MEMORY code (data bus 60 bits) & (address bus 8 bits).
module instruction_mem (clk,we,addr_ins,addr_in,data_in,data_out) ;
 parameter addr_w=8,data_w=15;

input  clk,we;
input  [addr_w-1:0] addr_ins,addr_in; 
input  [data_w-1:0] data_in;
output reg[data_w-1:0] data_out;

reg [data_w-1:0] instr_mem [2**addr_w-1:0] ;

always@ (posedge clk)
begin
 if (we) 
  begin
   instr_mem[addr_in] <= data_in ;
  end	
  
	data_out = instr_mem[addr_ins] ;
end
endmodule 