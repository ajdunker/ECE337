// $Id: $
// File name:   tb_moore_.sv
// Created:     2/10/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Test bench for moore machine '1101' detector.
`timescale 1ns / 1ns

module tb_moore();

localparam	CLK_PERIOD	= 2.5;
localparam	CHECK_DELAY	= 1;

reg tb_clk;
reg tb_n_rst;
reg tb_i;
reg tb_o;

moore DUT
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
	//BEGIN TEST CASE 1 - Assert a 1101 Expect 1 out
	tb_n_rst = 1'b0;
	#(CHECK_DELAY);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
	tb_i = 1'b1;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 1a: Passed");
        end else begin
            $error("Test case 1a: Failed");
	end
	tb_i = 1'b1;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 1b: Passed");
        end else begin
            $error("Test case 1b: Failed");
	end
	tb_i = 1'b0;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 1c: Passed");
        end else begin
            $error("Test case 1c: Failed");
	end
	tb_i = 1'b1;
        @(posedge tb_clk); 
	@(posedge tb_clk); 
        assert( tb_o == 1 ) begin
            $info("Test case 1d: Passed");
        end else begin
            $error("Test case 1d: Failed");
	end
	@(posedge tb_clk); 
	@(posedge tb_clk); 
	//BEGIN TEST CASE 2 - Assert a 101 after a 1101 Expect 1 out
	tb_i = 1'b1;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 2a: Passed");
        end else begin
            $error("Test case 2a: Failed");
	end
	tb_i = 1'b0;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 2b: Passed");
        end else begin
            $error("Test case 2b: Failed");
	end
	tb_i = 1'b1;
        @(posedge tb_clk); 
	@(posedge tb_clk); 
        assert( tb_o == 1 ) begin
            $info("Test case 2c: Passed");
        end else begin
            $error("Test case 2c: Failed");
	end
	//BEGIN TEST CASE 3 - Assert a 0 experct 0 out
	tb_i = 1'b0;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 3a: Passed");
        end else begin
            $error("Test case 3a: Failed");
	end
	//BEGIN TEST CASE 4 - Assert a 0 experct 0 out
	tb_n_rst = 1'b0;
	#(CHECK_DELAY);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
	tb_i = 1'b0;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 4a: Passed");
        end else begin
            $error("Test case 4a: Failed");
	end
	//BEGIN TEST CASE 5
	tb_n_rst = 1'b0;
	#(CHECK_DELAY);
        tb_n_rst = 1'b1;
        @(posedge tb_clk);
	tb_i = 1'b1;
        @(posedge tb_clk); 
        assert( tb_o == 0 ) begin
            $info("Test case 1a: Passed");
        end else begin
            $error("Test case 1a: Failed");
	end
	@(posedge tb_clk);
end

endmodule