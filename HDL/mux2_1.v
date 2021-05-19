module mux2_1 (y,d0,d1,sel);
	parameter width=4;
	
	output [width-1:0] y ;
	input  [width-1:0] d0,d1 ;
	input  sel ;

assign y = sel? d1:d0 ;

endmodule 