// the high level hierarchy for frame buffer memory
// memory implemented as rom memory

module Frame_buffer (clk, we_2, read_addr, write_addr, data_in, outdata_r, outdata_g, outdata_b);
input   clk, we_2, data_in ;
input   [19:0] read_addr, write_addr;
output  outdata_r, outdata_g, outdata_b;

FB_red_mem   D1 (data_in, read_addr, write_addr, we_2, clk, outdata_r );
FB_green_mem D2 (data_in, read_addr, write_addr, we_2, clk, outdata_g );
FB_blue_mem  D3 (data_in, read_addr, write_addr, we_2, clk, outdata_b );

endmodule 