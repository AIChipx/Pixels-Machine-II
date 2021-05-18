module testbench_vertex1 ();
	parameter pc_ins_addr_w=8,ins_data_w=60;

	reg clk,enable,reset,we_ins_m;
	reg [pc_ins_addr_w-1:0]addr_ins_m;
	reg [ins_data_w-1:0]din_ins_m;
	
vertex_processor vertext_test(clk,enable,reset,we_ins_m,addr_ins_m,din_ins_m);

//data_for_test
initial 
begin 
	clk=0; 
	addr_ins_m=0; 
 end 

always
begin
	#50
	clk=~clk;
end

always 
begin  
	#100
	addr_ins_m=addr_ins_m+1;
end

endmodule 