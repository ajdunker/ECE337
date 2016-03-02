// $Id: $
// File name:   tb_usb_receiver.sv
// Created:     3/1/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for top level

`timescale 1ns / 10ps

module tb_usb_receiver
  ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_d_plus;
   reg tb_d_minus;
   reg tb_r_enable;
   reg [7:0] tb_r_data;
   reg 	     tb_empty;
   reg 	     tb_full;
   reg 	     tb_rcving;
   reg 	     tb_r_error;

   usb_receiver USB (
		     .clk(tb_clk),
		     .n_rst(tb_n_rst),
		     .d_plus(tb_d_plus),
		     .d_minus(tb_d_minus),
		     .r_enable(tb_r_enable),
		     .r_data(tb_r_data),
		     .empty(tb_empty),
		     .full(tb_full),
		     .rcving(tb_rcving),
		     .r_error(tb_r_error)
		     );
   
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   initial
     begin
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	@(posedge tb_clk);
	
     end
   
endmodule; // tb_usb_receiver

   
