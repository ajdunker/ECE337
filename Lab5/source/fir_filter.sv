// $Id: $
// File name:   fir_filter.sv
// Created:     2/17/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Top level.

module fir_filter
  (
   input wire 	      clk,
   input wire 	      n_reset,
   input wire [15:0]  sample_data,
   input wire [15:0]  fir_coefficient,
   input wire 	      data_ready,
   input wire 	      load_coeff,
   input wire 	      one_k_samples,
   output wire 	      modwait,
   output wire [15:0] fir_out,
   output 	      err
   );

   logic [2:0] 	      operation;
   logic [3:0] 	      source1;
   logic [3:0] 	      source2;
   logic [3:0] 	      destination;
   logic 	      count_up;
   logic 	      clear;
   logic [16:0]       dpout;
   logic 	      overflow;
   
   logic 	      syncDR;
   logic 	      syncLC;   

   sync syn1 (
	      .clk(clk),
	      .n_rst(n_reset),
	      .async_in(data_ready),
	      .sync_out(syncDR)
	      );

   sync syn2 (
	      .clk(clk),
	      .n_rst(n_reset),
	      .async_in(load_coeff),
	      .sync_out(syncLC)
	      );
   
   
   controller ctlr (
		    .clk(clk),
		    .n_reset(n_reset),
		    .dr(syncDR),
		    .lc(syncLC),
		    .overflow(overflow),
		    .cnt_up(count_up),
		    .clear(clear),
		    .modwait(modwait),
		    .op(operation),
		    .src1(source1),
		    .src2(source2),
		    .dest(destination),
		    .err(err)
		    );

   counter cnt (
		.clk(clk),
		.n_reset(n_reset),
		.cnt_up(count_up),
		.clear(clear),
		.one_k_samples(one_k_samples)
		);
   
   magnitude mag (
		  .in(dpout),
		  .out(fir_out)
		  );

   datapath dp (
		.clk(clk),
		.n_reset(n_reset),
		.op(operation),
		.src1(source1),
		.src2(source2),
		.dest(destination),
		.ext_data1(sample_data),
		.ext_data2(fir_coefficient),
		.outreg_data(dpout),
		.overflow(overflow)
		);
   
   
endmodule
