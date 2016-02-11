// $Id: $
// File name:   moore.sv
// Created:     2/10/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Moore Machine '1101' Detector Design.

module mealy
(
	input wire clk,
	input wire n_rst,
	input wire i,
	output reg o

);

	reg [2:0] curr;
	reg [2:0] next;

	parameter [2:0] start = 3'b000;
	parameter [2:0] step1 = 3'b001;
	parameter [2:0] step2 = 3'b010;
	parameter [2:0] stepF = 3'b011;

	always_ff @ (posedge clk, negedge n_rst) begin
		if(n_rst == 0) begin
			curr <= start;
		end else begin
			curr <= next;
		end
	end

	always_comb begin
		o = 0;
		next = curr;
		case(curr)
			start : begin
				if(i == 1) begin
					next = step1;
				end else begin
					next = start;
				end
			end

			step1 : begin
				if(i == 1) begin
					next = step2;
				end else begin
					next = start;
				end
			end
			
			step2 : begin
				if(i == 0) begin
					next = stepF;
				end else begin
					next = step2;
				end
			end

			stepF : begin
				if(i == 1) begin
					o = 1;
					next = step2;
				end else begin
					next = start;
				end
			end

		endcase

	end

endmodule