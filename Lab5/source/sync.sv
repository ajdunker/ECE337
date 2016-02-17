// $Id: $
// File name:   sync_low.sv
// Created:     1/27/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Reset to Logic Low Synchronizer

module sync
(
	input wire clk,
	input wire n_rst,
	input wire async_in,
	output wire sync_out
);

reg pass;
reg out;

always_ff @ (posedge clk, negedge n_rst) 
begin: FFL
	if(1'b0 == n_rst) begin
		pass <= 0;
		out <= 0;
	end else begin
		pass <= async_in;
		out <= pass;
	end
end

assign sync_out = out;

endmodule