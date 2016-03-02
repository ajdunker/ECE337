// $Id: $
// File name:   timer.sv
// Created:     3/1/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Timer Block

module timer
  (
   input wire  clk,
   input wire  n_rst,
   input wire  d_edge,
   input wire  rcving,
   output wire shift_enable,
   output wire byte_received
   );

   reg [3:0]   count_o;
   
   
   flex_counter #(4) COUNT1
     (
      .clk(clk),
      .n_rst(n_rst),
      .clear(d_edge | ~rcving),
      .count_enable(rcving),
      .rollover_val(4'd8),
      .count_out(count_o)
      );

   assign shift_enable = count_o == 3;
   
   flex_counter #(4) COUNT2
     (
      .clk(clk),
      .n_rst(n_rst),
      .clear(!rcving),
      .count_enable(shift_enable),
      .rollover_val(4'd8),
      .rollover_flag(byte_received)
      );
      
endmodule // timer
