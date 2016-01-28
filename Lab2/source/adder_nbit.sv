// $Id: $
// File name:   adder_nbit.sv
// Created:     1/27/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Parameterized ripple carry adder design

`timescale 1ns / 100ps

module adder_nbit
#(
	parameter NUM_BITS = 4
)
(
	input wire [(NUM_BITS - 1):0] a,
	input wire [(NUM_BITS - 1):0] b,
	input wire carry_in,
	output wire [(NUM_BITS - 1):0] sum,
	output wire overflow

);


wire [NUM_BITS:0] carrys;
genvar i;

assign carrys[0] = carry_in;
generate
	for(i = 0; i <=(NUM_BITS - 1); i = i + 1)
	begin
		adder_1bit IX (.a(a[i]), .b(b[i]), .carry_in(carrys[i]), .sum(sum[i]), .carry_out(carrys[i+1]));
		always @ (a[i], b[i], carrys[i])
		begin
			#(2) assert(((a[i] + b[i] + carrys[i]) % 2) == sum[i]) 
			else $error("Output 's' of first 1 bit adder is not correct");
		end
	end
endgenerate
assign overflow = carrys[NUM_BITS];

endmodule