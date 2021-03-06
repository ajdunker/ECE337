// $Id: $
// File name:   decode.sv
// Created:     2/23/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Decode Block
//
// The decode block is responsible for removing the NRZ encoding
// The block will store the incoming bit present on the rising edge
// of the clk line when shift_enable is high, then output a 1 as
// long as the current input and the stored value match. Or a 0 if
// the current input and the sotred input differ. The block should 
// synchronously reset to an idle-line state when an EOP is detected
// at the same time as a shift enable.

module decode
  (
   input wire  clk,
   input wire  n_rst,
   input wire  d_plus,
   input wire  shift_enable,
   input wire  eop,
   output wire d_orig
   );
   
   logic       mux, muxO, dp;
   
   always_ff @ (posedge clk, negedge n_rst) begin
      if (1'b0 == n_rst) begin
	 dp <= 1;
	 muxO <= 1;
      end else begin
	 muxO <= mux;
	 dp <= d_plus;
      end
   end
   
   assign d_orig = ~(dp ^ muxO);
   
   always_comb begin
      if (shift_enable) begin
	 if (eop) begin
	    mux = 1'b1;
	 end else begin
	    mux = d_plus;
	 end
      end else begin
	 mux = muxO;
      end // else: !if(shift_enable)
   end // always_comb
   
endmodule // decode
