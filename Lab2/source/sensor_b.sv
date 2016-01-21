// $Id: $
// File name:   sensor_b.sv
// Created:     1/21/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Behaviral style sensor

module sensor_b
(

	input wire [3:0] sensors,
	output reg error
	
);

	always @(sensors) begin: COM
		error = sensors[0] | sensors[1] & sensors[2] | sensors[1] & sensors[3];	
	end


endmodule