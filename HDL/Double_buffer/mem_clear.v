module mem_clear ( clk, start, reset, addr, data, finish, we_2 );
input start, reset, clk ;
output reg [18:0] addr ;
output reg data, finish, we_2 ;
always@( posedge clk or posedge reset )
begin
 if (reset)
   begin
    finish = 0 ;
    addr = 0 ;
    data = 0 ;
	 we_2 = 0 ;
   end
 else if (start) 
   begin
	    if (addr <= 307199)
		  begin
		  	addr = addr + 1 ;
		  	we_2 = 1 ;
		   data = 0 ;
			finish = 0 ;
		  end
		 else 
		   begin
			finish = 1 ;
			we_2 = 0 ;
			end
			
	end
 else
  begin
   addr = 0 ;
   data = 0 ;
	we_2 = 0 ;
  end	
end
endmodule















