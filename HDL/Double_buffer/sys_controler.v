module sys_controler (clk, reset, vsync, mem_clr_finish, mem_str_clr, swap, str_line_drawing, select);
input clk, reset, vsync, mem_clr_finish ;
output reg mem_str_clr, swap, str_line_drawing, select ;

always @ (posedge clk or posedge reset)
begin
if(reset)
 begin
  swap <= 0;
  mem_str_clr <= 0;
  str_line_drawing <= 0;
  select <= 0 ;
 end
else 
 begin
 if (vsync == 0)
  begin
   swap <= ~swap ;
	mem_str_clr <= 1;
   select <= 1 ;
  end
 else if (vsync == 1 & mem_clr_finish ==0 )
  begin
   mem_str_clr <= 1;
   select <= 1 ;
	swap <= swap ;
  end
  else if (vsync == 1 & mem_clr_finish ==1 )
  begin
   select <= 0 ;
	str_line_drawing <= 1;
	mem_str_clr <= 0 ;
	swap <= swap ;
  end
 end
 
end
endmodule 