// $Id: $
// File name:   tb_rx_fifo.sv
// Created:     2/25/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for the receive FIFO block

`timescale 1ns / 10ps

module tb_rx_fifo
  ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_re;
   reg tb_we;
   reg [7:0] tb_wd;
   reg [7:0] tb_rd;
   reg 	     tb_empty;
   reg 	     tb_full;
   
   rx_fifo DUT (
		.clk(tb_clk), 
		.n_rst(tb_n_rst), 
		.r_enable(tb_re), 
		.w_enable(tb_we), 
		.w_data(tb_wd), 
		.r_data(tb_rd), 
		.empty(tb_empty), 
		.full(tb_full));

   reg [7:0] i;
   
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   initial
     begin
	tb_re = 0;
	tb_we = 0;
	tb_wd = 8'b00000000;
	
	tb_n_rst = 1;
	@(posedge tb_clk);
	tb_n_rst = 0;
	@(posedge tb_clk);
	tb_n_rst = 1;
	@(posedge tb_clk);

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b00000000;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b00000000;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b00000000;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b00000000;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b00000000;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	tb_wd = 8'b00000000;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;
	
	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;
	
	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;
	
	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;

	tb_n_rst = 1;
	@(posedge tb_clk);
	tb_n_rst = 0;
	@(posedge tb_clk);
	tb_n_rst = 1;
	@(posedge tb_clk);

	tb_wd = 8'b11111111;
	@(posedge tb_clk);
	tb_we = 1;
	@(posedge tb_clk);
	tb_we = 0;

	@(posedge tb_clk);
	tb_re = 1;
	@(posedge tb_clk);
	tb_re = 0;
	
     end
endmodule // tb_rx_fifo
