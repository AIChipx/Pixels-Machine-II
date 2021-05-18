module triangle (x_Coordinate_1, x_Coordinate_2, y_Coordinate_1, y_Coordinate_2,
                 x_vertice_1, x_vertice_2, x_vertice_3, y_vertice_1, y_vertice_2, y_vertice_3,
					  clk, reset);
input [31:0] x_vertice_1, x_vertice_2, x_vertice_3, y_vertice_1, y_vertice_2, y_vertice_3 ;
input clk, reset ;
output reg [31:0] x_Coordinate_1, x_Coordinate_2, y_Coordinate_1, y_Coordinate_2 ;

always @ (posedge clk or posedge reset)
if(reset)
 begin
   x_Coordinate_1 = 0 ;
	x_Coordinate_2 = 0 ;
	y_Coordinate_1 = 0 ;
	y_Coordinate_2 = 0 ;
 end
else 
 begin
  if (x_Coordinate_1 == 0 && x_Coordinate_2 == 0 && y_Coordinate_1 == 0 && y_Coordinate_2 == 0)
   begin
    x_Coordinate_1 =  x_vertice_1 ;
    x_Coordinate_2 =  x_vertice_2 ;
	 y_Coordinate_1 =  y_vertice_1 ;
    y_Coordinate_2 =  y_vertice_2 ;
   end 
  else if (x_Coordinate_1 == x_vertice_2 && x_Coordinate_2 == x_vertice_3 && y_Coordinate_1 == y_vertice_2 
            && y_Coordinate_2 == y_vertice_3)
   begin
    x_Coordinate_1 =  x_vertice_1 ;
    x_Coordinate_2 =  x_vertice_2 ;
	 y_Coordinate_1 =  y_vertice_1 ;
    y_Coordinate_2 =  y_vertice_2 ;
   end 
  else if(x_Coordinate_1 == x_vertice_1 && x_Coordinate_2 == x_vertice_2 && y_Coordinate_1 == y_vertice_1
          && y_Coordinate_2 == y_vertice_2 )
   begin
    x_Coordinate_1 =  x_vertice_1 ;
    x_Coordinate_2 =  x_vertice_3 ;
	 y_Coordinate_1 =  y_vertice_1 ;
    y_Coordinate_2 =  y_vertice_3 ;
   end
  else if(x_Coordinate_1 == x_vertice_1 && x_Coordinate_2 == x_vertice_3
          && y_Coordinate_1 == y_vertice_1 && y_Coordinate_2 == y_vertice_3 )
   begin
    x_Coordinate_1 = x_vertice_2 ;
    x_Coordinate_2 = x_vertice_3 ;
	 y_Coordinate_1 = y_vertice_2 ;
    y_Coordinate_2 = y_vertice_3 ;
   end  
end
endmodule 