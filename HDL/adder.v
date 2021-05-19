// Signed adder
module adder(dataa,datab,result);
	parameter WIDTH=32 ;

	input signed  [WIDTH-1:0] dataa,datab ;
	output signed [WIDTH-1:0] result ;
	wire   signed [WIDTH:0]temp;


	assign temp = dataa + datab ;
	assign result = temp[WIDTH-1:0] ;

endmodule 