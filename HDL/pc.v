//abdo 
module pc(addr , data_in , we ,clk);
parameter N=8;
output reg [N-1:0] addr;
input[N-1:0] data_in;
input we ,clk;
always@(posedge clk)
if(we)
addr=data_in+1;
endmodule
