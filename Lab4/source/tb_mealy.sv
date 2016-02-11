// $Id: $
// File name:   tb_mealy.sv
// Created:     2/11/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for Mealy Machine '1101' detector.
`timescale 1ns / 10ps

module tb_mealy();

localparam	CLK_PERIOD	= 2.5;
localparam	CHECK_DELAY	= 1;

reg tb_clk;
reg tb_n_rst;
reg tb_i;
reg tb_o;

mealy DUT
(
	.clk(tb_clk),
	.n_rst(tb_n_rst),
	.i(tb_i),
	.o(tb_o)
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
	tb_n_rst = 0;
	#1;
	tb_n_rst = 1;
	@(posedge tb_clk); 
	

	//BEGIN TEST CASE 1 - 1101 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b0;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        #1;
	assert( tb_o == 1 ) begin
            $info("Test case 1: Passed");
        end else begin
            $error("Test case 1: Failed");
	end
	//BEGIN TEST CASE 2 - 1101 followed by 101
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b0;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        #1;
	assert( tb_o == 1 ) begin
            $info("Test case 2: Passed");
        end else begin
            $error("Test case 2: Failed");
	end
	//BEGIN TEST CASE 3 - RESET
	tb_n_rst = 0;
	@(posedge tb_clk); 
	tb_n_rst = 1;
	#1;
	assert( tb_o == 0 ) begin
            $info("Test case 3: Passed");
        end else begin
            $error("Test case 3: Failed");
	end
	//BEGIN TEST CASE 4
	tb_i = 1'b0;
	#1;
	assert( tb_o == 0 ) begin
            $info("Test case 4: Passed");
        end else begin
            $error("Test case 4: Failed");
	end
	//BEGIN TEST CASE 5
	tb_i = 1'b1;
	@(posedge tb_clk);
	tb_i = 1'b0;
	#1;
	assert( tb_o == 0 ) begin
            $info("Test case 5: Passed");
        end else begin
            $error("Test case 5: Failed");
	end
	//BEGIN TEST CASE 6 - RESET then 1010
	tb_n_rst = 0;
	@(posedge tb_clk); 
	tb_n_rst = 1;
	@(posedge tb_clk);
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b0;
        @(posedge tb_clk); 
	tb_i = 1'b0;
        #1;
	assert( tb_o == 0 ) begin
            $info("Test case 6: Passed");
        end else begin
            $error("Test case 6: Failed");
	end
	//BEGIN TEST CASE 7 - 1111 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        #1;
	assert( tb_o == 0 ) begin
            $info("Test case 7: Passed");
        end else begin
            $error("Test case 7: Failed");
	end
	//BEGIN TEST CASE 8 - 1110 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b1;
        @(posedge tb_clk); 
	tb_i = 1'b0;
        #1;
	assert( tb_o == 0 ) begin
            $info("Test case 8: Passed");
        end else begin
            $error("Test case 8: Failed");
	end
end

endmodule