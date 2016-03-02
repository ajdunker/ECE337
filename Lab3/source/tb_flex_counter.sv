// $Id: $
// File name:   tb_flex_counter.sv
// Created:     2/5/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Flex Counter Grading.

`timescale 1ns / 1ns

module tb_flex_counter
  ();

   localparam CLK_PERIOD = 2.5;
   localparam NUM_INPUT_BITS = 4;
   localparam NUM_BITS = NUM_INPUT_BITS - 1;

   reg tb_clk;
   reg tb_reset;
   reg tb_count_enable;
   reg tb_clear;
   reg [NUM_BITS:0] tb_roll_val;
   reg [NUM_BITS:0] tb_count_out;
   reg 		    tb_flag;

   always
     begin: CLK_G
	tb_clk = 1'b0;
	#(CLK_PERIOD/2);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2);
     end
   
   flex_counter DUT(.clk(tb_clk), .n_rst(tb_reset), .count_enable(tb_count_enable), .clear(tb_clear), .rollover_val(tb_roll_val), .count_out(tb_count_out), .rollover_flag(tb_flag));

   initial begin
      tb_clk = 0;
      tb_reset = 1;
      tb_clear = 1;
      tb_count_enable = 1;
      tb_roll_val = 2;

      #(CLK_PERIOD / 2);
      tb_reset = 0;
      tb_clear = 0;
      tb_count_enable = 0;

      #(CLK_PERIOD * 3 / 2);
      tb_reset = 1;

      #(CLK_PERIOD);
      tb_count_enable = 1;

      #(CLK_PERIOD);
      tb_clear = 1;

      #(CLK_PERIOD);
      tb_clear = 0;

      #(CLK_PERIOD * 4);
      tb_count_enable = 0;

      #(CLK_PERIOD);
      tb_clear = 1;

      //Second Period
      tb_roll_val = 4;

      #(CLK_PERIOD);
      tb_reset = 0;
      tb_clear = 0;
      tb_count_enable = 0;

      #(CLK_PERIOD * 3);
      tb_reset = 1;

      #(CLK_PERIOD * 2);
      tb_count_enable = 1;

      #(CLK_PERIOD * 2);
      tb_clear = 1;

      #(CLK_PERIOD * 2);
      tb_clear = 0;

      #(CLK_PERIOD * 8);
      tb_count_enable = 0;

      #(CLK_PERIOD * 2);
      tb_clear = 1;

      //Third Period

      tb_roll_val = 8;

      #(CLK_PERIOD * 2);
      tb_reset = 0;
      tb_clear = 0;
      tb_count_enable = 0;

      #(CLK_PERIOD * 6);
      tb_reset = 1;

      #(CLK_PERIOD * 4);
      tb_count_enable = 1;

      #(CLK_PERIOD * 4);
      tb_clear = 1;

      #(CLK_PERIOD * 4);
      tb_clear = 0;

      #(CLK_PERIOD * 16);
      tb_count_enable = 0;

      #(CLK_PERIOD * 4);
      tb_clear = 1;      
   end
endmodule