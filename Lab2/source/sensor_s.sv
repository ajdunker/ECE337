// $Id: $
// File name:   sensor_s.sv
// Created:     1/21/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Sensor source file


module sensor_s
(

	input wire [3:0] sensors,
	output wire error
	
);

reg int_and1;
reg int_and2;

and A1 (int_and1, sensors[1], sensors[3]);
and A2 (int_and2, sensors[1], sensors[2]);
or A3 (error, sensors[0], int_and1, int_and2);


endmodule