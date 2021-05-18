module double (reset, clk, we_line_drawin, vsync, line_drawing_data, line_drawing_addr_1, vga_addr_2, 
               outdata_r, outdata_g, outdata_b, str_line_drawing );
input reset, clk, we_line_drawin, vsync, line_drawing_data ;
input [18 : 0] line_drawing_addr_1, vga_addr_2 ;
output  outdata_r, outdata_g, outdata_b, str_line_drawing ; 
wire [18 : 0] mem_clr_addr, line_addr_1;  
wire [19 : 0] mem_addr_w1, mem_addr_r2 ;

sys_controler b1 (clk, reset, vsync, mem_clr_finish, mem_str_clr, swap, str_line_drawing, select);
mem_clear b2 ( clk, mem_str_clr, reset, mem_clr_addr, mem_clr_data, mem_clr_finish, we_mem_clr );
multiplixer b3 (line_drawing_addr_1, mem_clr_addr, line_addr_1, select);
addr_arbiter b4 (clk, reset, swap, line_addr_1, vga_addr_2, mem_addr_w1, mem_addr_r2);
multiplixer #(1) b5 (line_drawing_data, mem_clr_data, data_in, select);
or b6 (we, we_mem_clr, we_line_drawin ); 
Frame_buffer b7 (clk, we, mem_addr_r2, mem_addr_w1, data_in, outdata_r, outdata_g, outdata_b);
  
endmodule 