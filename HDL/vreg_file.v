//abdo
module vreg_file ( data_out_a , data_out_b , addr_a , addr_b , data_in_a , data_in_b , we_a , we_b , clk);
parameter N = 4;
parameter M = 128;
output reg [M-1:0] data_out_a , data_out_b;
input [N-1:0] addr_a , addr_b;
input [M-1:0] data_in_a , data_in_b;
input we_a , we_b , clk;
reg  [M-1:0] mem [0:2**(N+1)-1];
always @(posedge clk) 
if (we_a) 
mem[addr_a] = data_in_a;
else
 data_out_a = mem[addr_a] ;
always @(posedge clk)
if (we_b) 
mem[addr_b] = data_in_b;
else
 data_out_b = mem[addr_b] ;
endmodule