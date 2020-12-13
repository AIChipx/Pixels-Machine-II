//control unit for vector processor 
module control_unit (op_code,we_a_reg,we_b_reg,we_mem,mux0,mux1,mux2,mux3);
	input [2:0]op_code;
	output reg we_a_reg,we_b_reg,we_mem,mux0,mux1,mux2,mux3 ;
	
always@(op_code)
begin

	we_a_reg=0; we_b_reg=0; we_mem=0; mux0=0; mux1=0; mux2=0; mux3=0;
	case(op_code)
		3'b000: begin we_a_reg=1; we_b_reg=0; we_mem=0; mux0=0; mux1=0; mux2=1; mux3=1; end
		3'b001: begin we_a_reg=1; we_b_reg=0; we_mem=0; mux0=0; mux1=0; mux2=1; mux3=1; end
		3'b100: begin we_a_reg=0; we_b_reg=1; we_mem=0; mux0=0; mux1=1; mux2=0; mux3=0; end
		3'b101: begin we_a_reg=0; we_b_reg=0; we_mem=1; mux0=1; mux1=1; mux2=0; mux3=0; end
		3'b110: begin we_a_reg=1; we_b_reg=0; we_mem=0; mux0=0; mux1=0; mux2=1; mux3=1; end
		3'b111: begin we_a_reg=1; we_b_reg=0; we_mem=0; mux0=0; mux1=0; mux2=0; mux3=1; end
	  default: begin we_a_reg=0; we_b_reg=0; we_mem=0; mux0=0; mux1=0; mux2=0; mux3=0; end
	endcase
end	
endmodule 