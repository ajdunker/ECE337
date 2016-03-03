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

   logic 	     d_plus_sync, d_minus_sync, d_edge, eop, shift_enable, byte_received;
   logic [7:0] 	     rcv_data;
   logic 	     d_orig, w_enable;
	     
   
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

   eop_detect EOPD (
		   .d_plus(d_plus_sync),
		   .d_minus(d_minus_sync),
		   .eop(eop)
		   );

   timer TM (
	     .clk(clk),
	     .n_rst(n_rst),
	     .d_edge(d_edge),
	     .rcving(rcving),
	     .shift_enable(shift_enable),
	     .byte_received(byte_received)
	     );

   shift_register SR (
		      .clk(clk),
		      .n_rst(n_rst),
		      .shift_enable(shift_enable),
		      .d_orig(d_orig),
		      .rcv_data(rcv_data)
		    );

   rcu RCU (
	    .clk(clk),
	    .n_rst(n_rst),
	    .d_edge(d_edge),
	    .eop(eop),
	    .shift_enable(shift_enable),
	    .rcv_data(rcv_data),
	    .byte_received(byte_received),
	    .rcving(rcving),
	    .w_enable(w_enable),
	    .r_error(r_error)
	    );
   
   
   rx_fifo RF (
	       .clk(clk),
	       .n_rst(n_rst),
	       .r_enable(r_enable),
	       .w_enable(w_enable),
	       .w_data(rcv_data),
	       .r_data(r_data),
	       .empty(empty),
	       .full(full)
	       );

   decode DC (
	      .clk(clk),
	      .n_rst(n_rst),
	      .d_plus(d_plus),
	      .shift_enable(shift_enable),
	      .eop(eop),
	      .d_orig(d_orig)
	      );
   
   
endmodule // usb_receiver
