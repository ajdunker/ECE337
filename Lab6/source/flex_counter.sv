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
    parameter NUM_CNT_BITS = 4
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

   reg [(NUM_CNT_BITS-1):0] 	     tmpCount;
   reg [(NUM_CNT_BITS-1):0] 	     tmpNext;
   reg 				     flagNext;
   reg 				     tmpFlag;

   always_ff @ (posedge clk, negedge n_rst)
     begin
	if(n_rst == 0) begin
	   tmpCount <= 0;
	   tmpFlag <= 1'b0;
	end else begin
	   tmpCount <= tmpNext;
	   tmpFlag <= flagNext;
	end
     end
   
   always_comb begin
      if(clear == 1) begin
	 tmpNext = 0;
	 flagNext = 1'b0;
      end else begin
	 if(count_enable == 1) begin
	    tmpNext = tmpCount + 1;
	    flagNext = 1'b0;
	    if(tmpNext == (rollover_val + 1)) begin
	       tmpNext = 1;
	    end
	    if(tmpNext == rollover_val) begin
	       flagNext = 1'b1;
	    end
	 end else begin
	    flagNext = tmpFlag;
	    tmpNext = tmpCount;
	 end // else: !if(count_enable == 1)
      end // else: !if(clear == 1)
   end
   
   assign rollover_flag = tmpFlag;
   assign count_out = tmpCount;
      
endmodule