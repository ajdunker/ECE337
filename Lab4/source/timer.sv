// $Id: $
// File name:   timer.sv
// Created:     2/11/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Timing controller.

module timer
(
	input wire clk,
	input wire n_rst,
	input wire enable_timer,
	output wire shift_strobe
	output wire packet_done
);

