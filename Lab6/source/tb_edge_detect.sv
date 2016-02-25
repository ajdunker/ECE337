// $Id: $
// File name:   tb_edge_detect.sv
// Created:     2/24/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for edge detect

`timescale 1ns / 10ps

module tb_edge_detect
  ();

   localparam CLK_PERIOD = 2.5;
   localparam CHECK_DELAY = 1;

   reg tb_clk;
   reg tb_n_rst;
   reg tb_dp;
   reg tb_ed;

   edge_detect DUT (
		    .clk(tb_clk),
		    .n_rst(tb_n_rst),
		    .d_plus(tb_dp),
		    .d_edge(tb_ed)
		    );
   
   always
     begin
	tb_clk = 1'b0;
	#(CLK_PERIOD/2.0);
	tb_clk = 1'b1;
	#(CLK_PERIOD/2.0);
     end

   initial
     begin
	tb_dp = 1'b1;
	tb_n_rst = 1;
	@(posedge tb_clk);
	tb_n_rst = 0;
	@(posedge tb_clk);
	tb_n_rst = 1;
	@(posedge tb_clk);
	@(negedge tb_clk);
	@(posedge tb_clk);
			
	//BEGIN TEST CASE 1
	
	tb_dp = 1'b1;
	@(negedge tb_clk);
	assert(tb_ed == 0) begin
	   $info("PASS 1");
	end else begin
	   $info("FAIL 1");
	end
	@(posedge tb_clk);
	tb_dp = 1'b0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_ed == 1) begin
	   $info("PASS 2");
	end else begin
	   $info("FAIL 2");
	end
	@(posedge tb_clk);
	tb_dp = 1'b0;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_ed == 0) begin
	   $info("PASS 3");
	end else begin
	   $info("FAIL 3");
	end
	@(posedge tb_clk);
	tb_dp = 1'b1;
	@(posedge tb_clk);
	@(negedge tb_clk);
	assert(tb_ed == 1) begin
	   $info("PASS 4");
	end else begin
	   $info("FAIL 4");
	end
	tb_dp = 1'b1;
	@(negedge tb_clk);
	assert(tb_ed == 0) begin
	   $info("PASS 5");
	end else begin
	   $info("FAIL 5");
	end
	tb_dp = 1'b1;
	@(negedge tb_clk);
	assert(tb_ed == 0) begin
	   $info("PASS 6");
	end else begin
	   $info("FAIL 6");
	end
	tb_dp = 1'b0;
	@(negedge tb_clk);
	assert(tb_ed == 1) begin
	   $info("PASS 7");
	end else begin
	   $info("FAIL 7");
	end
	tb_dp = 1'b0;
	@(negedge tb_clk);
	assert(tb_ed == 0) begin
	   $info("PASS 8");
	end else begin
	   $info("FAIL 8");
	end
	tb_dp = 1'b1;
	@(negedge tb_clk);
	assert(tb_ed == 1) begin
	   $info("PASS 9");
	end else begin
	   $info("FAIL 9");
	end
	tb_dp = 1'b0;
	@(negedge tb_clk);
	assert(tb_ed == 1) begin
	   $info("PASS 10");
	end else begin
	   $info("FAIL 10");
	end
	tb_dp = 1'b1;
	@(negedge tb_clk);
	assert(tb_ed == 1) begin
	   $info("PASS 11");
	end else begin
	   $info("FAIL 11");
	end
	tb_dp = 1'b1;
	@(negedge tb_clk);
	assert(tb_ed == 0) begin
	   $info("PASS 12");
	end else begin
	   $info("FAIL 12");
	end
     end
   
endmodule // tb_edge_detect
