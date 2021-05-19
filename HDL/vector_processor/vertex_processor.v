//vertex_processor
module vertex_processor (clk,enable,reset,we_ins_m,addr_ins_m,din_ins_m
                          ,info_in,addr_inf,we_inf,vert_out);
								  
	parameter pc_ins_addr_w=8,ins_data_w=15,data_bus_w=128,
	          op_code_w=3,operands_w=4,adder_w=32,info_w=128,info__add_W=8;
	
	input clk,enable,reset,we_ins_m,we_inf;
	input [pc_ins_addr_w-1:0]addr_ins_m;
	input [ins_data_w-1:0]din_ins_m;
	input [info__add_W-1:0]addr_inf;
	input [info_w-1:0]info_in;
	output[info_w-1:0]vert_out;
	
	wire we_a_vregf,we_b_vregf,we_dmem,mux0_dest,mux1_src2,mux2_alu_out,mux3_src1;
	wire [pc_ins_addr_w-1:0] pc_ins_addr;
	wire [ins_data_w-1:0]  ins_data;
	wire [op_code_w-1:0]   op_code;
	wire [operands_w-1:0]  rd,sr1,sr2;
	wire [operands_w-1:0]  mux0_out;
	wire [adder_w-1:0]     adder1_out,adder2_out,adder3_out;
	wire [data_bus_w-1:0]  data_out_a_vregf,data_out_b_vregf,
	                       data_in_a_vregf,data_in_b_vregf,sr2_extend,alu_in1,alu_in2,
								   alu_out,adders_out,sregf_extend;
	wire [7:0]data_out_sregf;		 
	
	
	//assign pc_ins_addr = addr_ins_m;
	assign op_code = ins_data[14:12];
	assign rd  = ins_data[11:8];
	assign sr1 = ins_data[7:4];
	assign sr2 = ins_data[3:0];
	assign sr2_extend = {{28{sr2[3]}},sr2,{28{sr2[3]}},sr2,{28{sr2[3]}},sr2,{28{sr2[3]}},sr2};
	assign sregf_extend = {{24{data_out_sregf[7]}},data_out_sregf,
	                       {24{data_out_sregf[7]}},data_out_sregf,
								  {24{data_out_sregf[7]}},data_out_sregf,
								  {24{data_out_sregf[7]}},data_out_sregf};
	assign adders_out = {96'b0,adder3_out};
	
//blocks	
pc pc0 (clk,enable,reset,pc_ins_addr);

instruction_mem ins_mem0 (clk,we_ins_m,pc_ins_addr,addr_ins_m,din_ins_m,ins_data);
	
control_unit control0 (op_code,we_a_vregf,we_b_vregf,we_dmem,
                       mux0_dest,mux1_src2,mux2_alu_out,mux3_src1);
	
mux2_1 mux0 (mux0_out,sr2,rd,mux0_dest);
	               
sreg_file reg_file0 (clk,sr1,data_out_sregf);
	
vreg_file reg_file1 (clk,we_a_vregf,we_b_vregf,sr1,mux0_out,rd,rd,data_in_a_vregf,
                     data_in_b_vregf,data_out_a_vregf,data_out_b_vregf);
						  
mux2_1 #(128) mux3 (alu_in1,sregf_extend,data_out_a_vregf,mux3_src1);

mux2_1 #(128) mux1 (alu_in2,data_out_b_vregf,sr2_extend,mux1_src2);

alu alu0 (alu_out[31:0],op_code,alu_in1[31:0],alu_in2[31:0]);

alu alu1 (alu_out[63:32],op_code,alu_in1[63:32],alu_in2[63:32]);

alu alu2 (alu_out[95:64],op_code,alu_in1[95:64],alu_in2[95:64]);

alu alu3 (alu_out[127:96],op_code,alu_in1[127:96],alu_in2[127:96]);
	
adder adder1 (alu_out[31:0],alu_out[63:32],adder1_out);	

adder adder2 (alu_out[95:64],alu_out[127:96],adder2_out);

adder adder3 (adder1_out,adder2_out,adder3_out);

mux2_1 #(128) mux2 (data_in_a_vregf,adders_out,alu_out,mux2_alu_out);

data_mem d_mem0 (clk,we_dmem,alu_out[7:0],data_out_b_vregf,data_in_b_vregf
                 ,info_in,addr_inf,we_inf,vert_out);
 
endmodule 