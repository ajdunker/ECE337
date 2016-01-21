// $Id: $
// File name:   sensor_d.sv
// Created:     1/21/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: data flow style sensor.
// 

module sensor_d
(

	input wire [3:0] sensors,
	output wire error
	
);

	wire and1;
	wire and2;

	assign error = (sensors[0] == 1 || (sensors[1] & sensors[3] == 1) || (sensors[1] & sensors[2] == 1)) ? {1}:0; 

endmodule