// $Id: $
// File name:   flex_spts_sr.sv
// Created:     2/3/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: N-bit Parrallel-to-Serial Shift Register Design.


module flex_pts_sr
  #(
    parameter NUM_BITS = 4,
    parameter SHIFT_MSB = 1
    )
   (
    input wire 			clk,
    input wire 			n_rst,
    input wire 			shift_enable,
    input wire 			load_enable,
    input wire [(NUM_BITS-1):0] parallel_in,
    output wire 		serial_out
    );

   reg [(NUM_BITS-1):0] 	buff;

   always @ (posedge clk, negedge n_rst) begin
      if (n_rst == 0) begin
	 buff[(NUM_BITS-1):0] <= {NUM_BITS{1'b1}};
      end else begin
	 if (load_enable == 1'b1) begin
	    buff[(NUM_BITS-1):0] <= parallel_in[(NUM_BITS-1):0];
	 end else begin
	    if (shift_enable == 1'b1) begin
	       if (SHIFT_MSB == 1'b1) begin
		  buff[(NUM_BITS-1):0] <= {buff[(NUM_BITS-2):0], 1'b1};
	       end else begin
		  buff[(NUM_BITS-1):0] <= {1'b1, buff[(NUM_BITS-1):1]};
	       end
	    end else begin
	       buff[(NUM_BITS-1):0] <= buff[(NUM_BITS-1):0];
	    end
	 end
      end
   end

   assign serial_out = (buff[(NUM_BITS-1)] & SHIFT_MSB) + (buff[0] & (~SHIFT_MSB));

endmodule
