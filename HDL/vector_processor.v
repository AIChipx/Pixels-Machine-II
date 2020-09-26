module signed_adder
#(parameter WIDTH=16)
(
	input signed [WIDTH-1:0] dataa,
	input signed [WIDTH-1:0] datab,
	output [WIDTH:0] result
);

	assign result = dataa + datab;

endmodule

module mux
#(parameter WIDTH=4)
(
	input  [WIDTH-1:0] dataa,
	input  [WIDTH-1:0] datab,
	input sel,
	output [WIDTH-1:0] result
);
assign result=sel ? dataa:datab;
endmodule


module mux128
#(parameter WIDTH=128)
(
	input  [WIDTH-1:0] dataa,
	input  [WIDTH-1:0] datab,
	input sel,
	output [WIDTH-1:0] result
);
assign result=sel ? dataa:datab;
endmodule


module pc
#(parameter WIDTH=8)
(
	input clk, enable, reset,
	output reg [WIDTH-1:0] addr
);

	// Reset if needed, or increment if counting is enabled
	always @ (posedge clk or posedge reset)
	begin
		if (reset)
			addr <= 0;
		else if (enable == 1'b1)
			addr <= addr + 1;
	end

endmodule

module instruction_mem 
#(parameter DATA_WIDTH=60, parameter ADDR_WIDTH=8)
(
	input [(DATA_WIDTH-1):0] data_in,
	input [(ADDR_WIDTH-1):0] addr,
	input we, clk,
	output [(DATA_WIDTH-1):0] data_out
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Variable to hold the registered read address
	reg [ADDR_WIDTH-1:0] addr_reg;

	always @ (posedge clk)
	begin
		// Write
		if (we)
			ram[addr] <= data_in;

		addr_reg <= addr;
	end

	// Continuous assignment implies read returns NEW data.
	// This is the natural behavior of the TriMatrix memory
	// blocks in Single Port mode.  
	assign data_out = ram[addr_reg];

endmodule

module vreg_file
#(parameter DATA_WIDTH=128, parameter ADDR_WIDTH=4)
(
	input [(DATA_WIDTH-1):0] data_in_a, data_in_b,
	input [(ADDR_WIDTH-1):0] r_addr_a, r_addr_b,w_addr_a, w_addr_b,
	input we_a, we_b, clk,
	output  [(DATA_WIDTH-1):0] data_out_a, data_out_b
);

	// Declare the RAM variable
	reg [DATA_WIDTH-1:0] ram[2**ADDR_WIDTH-1:0];

	// Port A 
	always @ (posedge clk)
	begin
		if (we_a) 
		begin
			ram[w_addr_a] <= data_in_a;
		end
        end

        assign data_out_a = ram[r_addr_a] ;

	// Port B 
	always @ (posedge clk)
	begin
		if (we_b) 
		begin
			ram[w_addr_b] <= data_in_b;
		end	
	end

        assign data_out_b = ram[r_addr_b] ;
endmodule


module alu (alu_out,op_code,alu_in1,alu_in2) ;
 parameter out_w=32,op_w=3,in_w=32,
				ADD=3'b000,MUL=3'b001,LDR=3'b100,STR=3'b101,MOV=3'b110,DPRO=3'b111 ;  //"_W" mean width 

input         [op_w-1:0] op_code ;
input signed  [in_w-1:0] alu_in1,alu_in2 ;
output signed [out_w-1:0] alu_out ;
reg           [2*out_w-1:0] temb ;

always@ (op_code or alu_in1 or alu_in2)
begin
  case(op_code)
			ADD,LDR,STR:	temb = alu_in1 + alu_in2 ;
			   MUL,DPRO:	temb = alu_in1 * alu_in2 ;
			        MOV:   temb = alu_in1 ;
	            default:   temb = 0 ; 
  endcase
end

assign alu_out=temb[out_w-1:0];

endmodule 

//DATA_MEMORY code (data bus 128 bits) & (address bus 8 bits).
module data_mem (clk,we,addr,data_in,data_out) ;
 parameter addr_w=128,data_w=128;

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
//************************************************************
module vector_processor (clk,enable,reset,data_in,we_ins);

parameter pc_width =8;
parameter DATA_WIDTH=60; parameter ADDR_WIDTH=8;
parameter WIDTH=4;
parameter DATA_WIDTH_reg=128; parameter ADDR_WIDTH_reg=4;
parameter out_w=32,op_w=3,in_w=32;
parameter adder_w=32;
parameter WIDTH_m=128;
parameter addr_w=128,data_w=128;


input clk,enable,reset,we_ins ;
reg sel0,sel1,sel2,we_a,we_b,we_mem ;
input [DATA_WIDTH-1:0] data_in ;
//input [op_w-1:0]op_code;

wire [pc_width-1:0]addr ;
wire [(DATA_WIDTH-1):0] data_out;
wire [WIDTH-1:0] dataa0, datab0,result0;
wire [(DATA_WIDTH_reg-1):0] data_in_a,data_in_b,data_out_a,data_out_b;
wire [(ADDR_WIDTH_reg-1):0] r_addr_a,
      r_addr_b,w_addr_a,w_addr_b;
wire [WIDTH_m-1:0] dataa1, datab1,result1,dataa2, datab2,result2;
wire [out_w-1:0]alu_out0,alu_out1,alu_out2,alu_out3;
wire [in_w-1:0]alu_in10,alu_in11,alu_in12,alu_in13,alu_in20,alu_in21,alu_in22,alu_in23;
wire [adder_w-1:0] addera0,adderb0,res0,addera1,adderb1,res1,addera2,adderb2,res2;
wire [(DATA_WIDTH_reg-1):0]conc;
wire [addr_w-1:0] addr_mem;
wire [data_w-1:0] data_in_mem,data_out_mem;

 pc m1 ( clk, enable, reset, addr);
 
 instruction_mem m2 (  data_in,  addr, we_ins, clk, data_out);
 
  mux m3( data_out[11:8],data_out[3:0], sel0, result0);

 
 vreg_file m4(result2[WIDTH_m-1:0], data_out_mem[data_w-1:0],data_out[7:4],result0[WIDTH-1:0],data_out[11:8],
 data_out[11:8],we_a, we_b, clk,  data_out_a, data_out_b);

 
 mux128 m5( {124'b0,data_out[3:0]} , data_out_b[(DATA_WIDTH_reg-1):0] , sel1, result1);

 
 alu m6 (alu_out0,op_code,data_out_a[31:0],result1[31:0]) ;
 alu m7 (alu_out1,op_code,data_out_a[63:32],result1[63:32]) ;
 alu m8 (alu_out2,op_code,data_out_a[95:64],result1[63:32]) ;
 alu m9 (alu_out3,op_code,data_out_a[127:96],result1[127:96]) ; 


signed_adder m10(  alu_out0[out_w-1:0], alu_out1[out_w-1:0],  res0);
signed_adder m11(  alu_out2[out_w-1:0], alu_out3[out_w-1:0],  res1);
signed_adder m12(  res0[out_w-1:0],  res1[out_w-1:0],  res2);

assign conc[(DATA_WIDTH_reg-1):0]={alu_out3[31:0],alu_out2[31:0],alu_out1[31:0],alu_out0[31:0]};

mux128 m13(conc[(DATA_WIDTH_reg-1):0], {96'b0,res2[out_w-1:0] }, sel2,  result2);

data_mem m14 (clk,we_mem,conc[(DATA_WIDTH_reg-1):0],data_out_b[(DATA_WIDTH_reg-1):0],data_out_mem) ;
always@(posedge clk)
if(op_code== 3'b000)
begin
we_mem=1'b0;
we_a=1'b1;
we_b=1'b0;
sel0=1'b0;
sel1=1'b0;
sel2=1'b1;
end
else if(op_code== 3'b001)
begin
we_mem=1'b0;
we_a=1'b1;
we_b=1'b0;
sel0=1'b0;
sel1=1'b0;
sel2=1'b1;
end
else if(op_code== 3'b100)
begin
we_mem=1'b0;
we_a=1'b0;
we_b=1'b1;
sel0=1'b0;
sel1=1'b1;
sel2=1'b0;
end
else if(op_code== 3'b101)
begin
we_mem=1'b1;
we_a=1'b0;
we_b=1'b0;
sel0=1'b1;
sel1=1'b1;
sel2=1'b0;
end
else if(op_code== 3'b110)
begin
we_mem=1'b0;
we_a=1'b1;
we_b=1'b0;
sel0=1'b0;
sel1=1'b0;
sel2=1'b1;
end
else if(op_code== 3'b111)
begin
we_mem=1'b0;
we_a=1'b1;
we_b=1'b0;
sel0=1'b0;
sel1=1'b0;
sel2=1'b0;
end
else
begin
we_mem=1'b0;
we_a=1'b0;
we_b=1'b0;
sel0=1'b0;
sel1=1'b0;
sel2=1'b0;
end

 
endmodule
