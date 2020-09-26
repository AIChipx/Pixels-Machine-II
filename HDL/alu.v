//ALU code have 2_INPUTS(32 bits) & OUTPUT(32 bits) & OP_INPUT(3 bits)  .
//operations signd add & signd mul & LDR & STR & MOV & DOTPRODUCT  .

module alu (alu_out,op_code,alu_in1,alu_in2) ;
	parameter out_w=32,op_w=3,in_w=32,
		ADD=3'b000,MUL=3'b001,LDR=3'b100,STR=3'b101,MOV=3'b110,DPRO=3'b111 ;  _W mean width 

	input         [op_w-10] op_code ;
	input signed  [in_w-10] alu_in1,alu_in2 ;
	output signed [out_w-10] alu_out ;
	reg signed    [2out_w-10] temb ;

always@ (op_code or alu_in1 or alu_in2)
begin
  case(op_code)
			ADD,LDR,STR	temb = alu_in1 + alu_in2 ;
			   MUL,DPRO	temb = alu_in1  alu_in2 ;
			          MOV   temb = alu_in1 ;
	                      default   temb = 0 ; 
  endcase
end

assign alu_out = temb[out_w-10];

endmodule 