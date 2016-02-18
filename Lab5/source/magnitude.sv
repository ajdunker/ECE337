// $Id: $
// File name:   magnitude.sv
// Created:     2/17/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Magnitude.

module magnitude
(
	input 	wire [16:0] in,
	output 	wire [15:0] out	
);
	assign out = (in[16] ? (~in[15:0] + 1) : in[15:0]);
endmodule