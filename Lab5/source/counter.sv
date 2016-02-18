// $Id: $
// File name:   counter.sv
// Created:     2/17/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Counter unit.

module counter
(
	input	wire clk,
	input	wire n_reset,
	input	wire cnt_up,
	input	wire clear,
	output 	wire one_k_samples
);

flex_counter #(10) count1000
(
      .clk(clk),
      .n_rst(n_rst),
      .clear(clear),
      .count_enable(cnt_up),
      .rollover_val(10'd1000),
      .rollover_flag(one_k_samples)
);

endmodule