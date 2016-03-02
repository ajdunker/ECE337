// $Id: $
// File name:   usb_receiver.sv
// Created:     3/1/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: USB Receiver

module usb_receiver
  (
   input wire 	     clk,
   input wire 	     n_rst,
   input wire 	     d_plus,
   input wire 	     d_minus,
   input wire 	     r_enable,
   output wire [7:0] r_data,
   output wire 	     empty,
   output wire 	     full,
   output wire 	     rcving,
   output wire 	     r_error
   );

   logic 	     d_plus_sync, d_minus_sync, d_edge, eop;

   sync_high SH (
		 .clk(clk),
		 .n_rst(n_rst),
		 .async_in(d_plus),
		 .sync_out(d_plus_sync)
		 );

   sync_low SL (
		.clk(clk),
		.n_rst(n_rst),
		.async_in(d_minus),
		.sync_out(d_minus_sync)
		);

   edge_detect ED (
		   .clk(clk),
		   .n_rst(n_rst),
		   .d_plus(d_plus_sync),
		   .d_edge(d_edge)
		   );

   eop_detect EOD (
		   .d_plus(d_plus_sync),
		   .d_minus(d_minus_sync),
		   .eop(eop)
		   );

   timer TM (
	     
	     );
   
   
   
   
endmodule // usb_receiver
