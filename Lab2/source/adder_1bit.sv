// $Id: $
// File name:   adder_1bit.sv
// Created:     1/21/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: 1-bit Full Adder Design


module adder_1bit
(
	input wire a,
	input wire b,
	input wire carry_in,
	output wire sum,
	output wire carry_out
);

always @ (a, b, carry_in)
begin
	assert(((a == 1'b1) || (a == 1'b0)) && ((b == 1'b1) || (b == 1'b0)) && ((carry_in == 1'b1) || (carry_in == 1'b0)))
	else $error("Input 'a' of component is not a digital logic value");
end

assign sum = carry_in ^^ (a ^^ b);
assign carry_out = ((~carry_in) && b && a) || (carry_in && (b || a));

endmodule