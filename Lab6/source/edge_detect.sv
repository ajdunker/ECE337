// $Id: $
// File name:   edge_detect.sv
// Created:     2/23/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Edge Detector Block
//
// At each positive clock edge, the edge_detect block will compare
// the d_plus with the value of d_plus during the previous clock
// cycle, and output a 1 when the bit on the d_plus line does not
// match the sotred bit, and a 0 when the value on the line matches
// the stored bit.

module edge_detect
  (
   input wire clk,
   input wire n_rst,
   input wire d_plus,
   output reg d_edge
   );

   logic      prev, next;
 	       
   always_ff @ (posedge clk, negedge n_rst) begin
      if(1'b0 == n_rst) begin
	 prev <= 0;
	 d_edge <= 0;
      end else begin
	 prev <= d_plus;
	 d_edge <= next;
      end
   end

   always_comb begin
      next = (prev ^ d_plus);
   end
   
endmodule // edge_detect
