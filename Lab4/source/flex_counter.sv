// $Id: $
// File name:   flex_counter.sv
// Created:     2/5/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 
// Flexible and Scalable Counter with Controlled Rollover.

module flex_counter
#(
	parameter NUM_CNT_BITS =4
)
(
	input wire clk,
	input wire n_rst,
	input wire count_enable,
	input wire clear,
	input wire [(NUM_CNT_BITS-1):0] rollover_val,
	output wire rollover_flag,
	output wire [(NUM_CNT_BITS-1):0] count_out
);

	reg [(NUM_CNT_BITS-1):0] tmpCount;
	reg tmpFlag;

	always @ (posedge clk, negedge n_rst) begin
		if (n_rst == 0) begin
			tmpCount[(NUM_CNT_BITS-1):0] <= {(NUM_CNT_BITS-1){1'b0}};
			tmpFlag <= 1'b0;
		end else begin
			if (clear == 1) begin
				tmpCount[(NUM_CNT_BITS-1):0] <= {(NUM_CNT_BITS-1){1'b0}};
			end
			if (count_enable == 1) begin
				if (tmpCount == rollover_val) begin
					tmpCount[(NUM_CNT_BITS-1):0] <= {(NUM_CNT_BITS-1){1'b0}};
					tmpFlag <= 1'b1;
				end else begin
					tmpCount <= tmpCount + 1;
					tmpFlag <= 1'b0;
				end
			end
		end
	end
	
	assign rollover_flag = tmpFlag;
	assign count_out[(NUM_CNT_BITS-1):0] = tmpCount[(NUM_CNT_BITS-1):0];
endmodule