// $Id: $
// File name:   timer.sv
// Created:     2/11/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Timing controller.

module timer
  (
   input wire  clk,
   input wire  n_rst,
   input wire  enable_timer,
   output wire shift_strobe,
   output wire packet_done
   );

   reg [3:0]   tCount1;
   reg [3:0]   tCount2;

   flex_counter #(4) count10
     (
      .clk(clk),
      .n_rst(n_rst),
      .clear(packet_done),
      .count_enable(delayed_enable_timer),
      .rollover_val(4'd10),
      .count_out(tCount1),
      .rollover_flag(shift_strobe)
      );

   flex_counter #(4) count9
     (
      .clk(clk),
      .n_rst(n_rst),
      .clear(packet_done),
      .count_enable(shift_strobe),
      .rollover_val(4'd9),
      .count_out(tCount2),
      .rollover_flag(packet_done)
      );

endmodule
