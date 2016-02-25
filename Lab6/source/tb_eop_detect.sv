// $Id: $
// File name:   tb_eop_detect.sv
// Created:     2/24/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test Bench for End of Packet

`timescale 1ns / 100ps

module tb_eop_detect
  ();

   reg tb_dp;
   reg tb_dm;
   reg tb_eop;
   
   eop_detect DUT(.d_plus(tb_dp), .d_minus(tb_dm), .eop(tb_eop));
   
   initial
     begin	
	tb_dp = 1;
	tb_dm = 1;
	#(2)
	assert(tb_eop == 0) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
	tb_dp = 0;
	tb_dm = 1;
	#(2)
	assert(tb_eop == 0) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
	tb_dp = 1;
	tb_dm = 0;
	#(2)
	assert(tb_eop == 0) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
	tb_dp = 0;
	tb_dm = 1;
	#(2)
	assert(tb_eop == 0) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
	tb_dp = 0;
	tb_dm = 0;
	#(2)
	assert(tb_eop == 1) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
	tb_dp = 1;
	tb_dm = 1;
	#(2)
	assert(tb_eop == 0) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
	tb_dp = 0;
	tb_dm = 0;
	#(2)
	assert(tb_eop == 1) begin
	   $info("Pass");
	end else begin
	   $info("Fail");
	end
     end
   
endmodule // tb_eop_detect
