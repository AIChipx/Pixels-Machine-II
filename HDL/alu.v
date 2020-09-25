//ALU code have 2_INPUTS(32 bits) & OUTPUT(64 bits) & OP_INPUT(3 bits).
//operations (signd add) & (signd mul).

module alu (alu_out,op_code,alu_in1,alu_in2) ;
 parameter out_w=64,op_w=3,in_w=32,add=3'b000,mul=3'b001,mad=3'b010 ;    //"_W" mean width 

input        [op_w-1:0] op_code ;
input signed [in_w-1:0] alu_in1,alu_in2 ;
output reg   [out_w-1:0] alu_out ;			

always@ (op_code or alu_in1 or alu_in2 or alu_in3)
 begin
   case(op_code)
      	add:alu_out=alu_in1 + alu_in2;
        mul:alu_out=alu_in1 * alu_in2;
        mad:alu_out=alu_in1 * alu_in2;	
        default:alu_out = 0 ; 
   endcase
 end
endmodule