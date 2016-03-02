// $Id: $
// File name:   shift_register.sv
// Created:     3/1/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Shift register Block

module shift_register
  (
   input wire 	     clk,
   input wire 	     n_rst,
   input wire 	     shift_enable,
   input wire 	     d_orig,
   output wire [7:0] rcv_data
   );

   flex_st_sr #(.NUM_BITS(8), .SHIFT_MSB(1)) fss (.clk(clk), .n_rst(n_rst), .shift_enable(shift_enable), .parallel_out(rcv_data));
   
endmodule // shift_register
