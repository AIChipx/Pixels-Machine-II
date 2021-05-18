module multiplixer(x,y,z,sel);
parameter N = 19 ;
input [ N-1 : 0 ] x,y ;
input sel ;
output [ N-1 : 0 ] z ;

assign z = sel ? y : x ;

endmodule
