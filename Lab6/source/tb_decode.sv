// $Id: $
// File name:   tb_decode.sv
// Created:     2/25/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for decode

`timescale 1ns / 10ps

module tb_decode
  ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_dplus;
   reg tb_se;
   reg tb_eop;
   reg tb_dorig;

   decode DUT (.clk(tb_clk), .n_rst(tb_n_rst), .d_plus(tb_dplus), .shift_enable(tb_se), .eop(tb_eop), .d_orig(tb_dorig));
      
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   initial
     begin
	tb_dplus = 0;
	tb_se = 0;
	tb_eop =0;
		
	tb_n_rst = 1;
	@(posedge tb_clk);
	tb_n_rst = 0;
	@(posedge tb_clk);
	tb_n_rst = 1;
	@(posedge tb_clk);
	@(posedge tb_clk);

	tb_dplus = 1;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 0) begin
	   $info("PASS 1");
	end else begin
	   $info("FAIL 1");
	end

	@(posedge tb_clk);
	tb_se = 1;
	@(posedge tb_clk);
	tb_se = 0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 1) begin
	   $info("PASS 2");
	end else begin
	   $info("FAIL 2");
	end

	@(posedge tb_clk);
	tb_dplus = 0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 0) begin
	   $info("PASS 3");
	end else begin
	   $info("FAIL 3");
	end

	@(posedge tb_clk);
	tb_se = 1;
	tb_eop = 1;
	@(posedge tb_clk);
	tb_se = 0;
	tb_eop = 0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 0) begin
	   $info("PASS 4");
	end else begin
	   $info("FAIL 4");
	end
	@(posedge tb_clk);
	tb_dplus = 1;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 1) begin
	   $info("PASS 5");
	end else begin
	   $info("FAIL 5");
	end
	@(posedge tb_clk);
	tb_dplus = 0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 0) begin
	   $info("PASS 6");
	end else begin
	   $info("FAIL 6");
	end
	@(posedge tb_clk);
	tb_dplus = 1;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 1) begin
	   $info("PASS 7");
	end else begin
	   $info("FAIL 7");
	end
	
	@(posedge tb_clk);
	tb_se = 1;
	@(posedge tb_clk);
	tb_se = 0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_dorig == 1) begin
	   $info("PASS 8");
	end else begin
	   $info("FAIL 8");
	end
	
     end
   
endmodule // tb_decode
