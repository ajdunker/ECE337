// 337 TA Provided Lab 2 Testbench
// This code serves as a test bench for the 1 bit adder design 

`timescale 1ns / 100ps

module tb_adder_16bit
();
	// Define local parameters used by the test bench
	localparam NUM_INPUT_BITS			= 16;
	localparam NUM_OUTPUT_BITS		= NUM_INPUT_BITS + 1;
	localparam MAX_OUTPUT_BIT			= NUM_OUTPUT_BITS - 1;
	localparam NUM_TEST_BITS 			= (NUM_INPUT_BITS * 2) + 1;
	localparam MAX_TEST_BIT				= NUM_TEST_BITS - 1;
	localparam NUM_TEST_CASES 		= 2 ** NUM_TEST_BITS;
	localparam MAX_TEST_VALUE 		= NUM_TEST_CASES - 1;
	localparam TEST_A_BIT					= 0;
	localparam TEST_B_BIT					= NUM_INPUT_BITS;
	localparam TEST_CARRY_IN_BIT	= MAX_TEST_BIT;
	localparam TEST_SUM_BIT				= 0;
	localparam TEST_CARRY_OUT_BIT	= MAX_OUTPUT_BIT;
	localparam TEST_DELAY					= 10;
	
	// Declare Design Under Test (DUT) portmap signals
	wire [15:0] tb_a;
	wire [15:0] tb_b;
	wire	tb_carry_in;
	wire [15:0] tb_sum;
	wire	tb_carry_out;

	reg [(NUM_INPUT_BITS-1):0] tmp_a;
	reg [(NUM_INPUT_BITS-1):0] tmp_b;
	reg tmp_carry_in;
	
	// Declare test bench signals
	reg [MAX_OUTPUT_BIT:0] tb_expected_outputs;
	
	// DUT port map
	adder_16bit DUT(.a(tb_a), .b(tb_b), .carry_in(tb_carry_in), .sum(tb_sum), .overflow(tb_carry_out));
	
	// Connect individual test input bits to a vector for easier testing
	assign tb_a					= tmp_a;
	assign tb_b					= tmp_b;
	assign tb_carry_in	= tmp_carry_in;
	
	// Test bench process
	initial
	begin
		///////			TEST 1
		tmp_a = 16'b0;
		tmp_b = 16'b0;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 1a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 1a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		tmp_a = 16'b0;
		tmp_b = 16'b0;
		tmp_carry_in = 1'b1;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 1b!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 1b!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		///////			TEST 2
		tmp_a = 16'hFFF0;
		tmp_b = 16'h000F;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 2a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 2a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		tmp_a = 16'hFFF0;
		tmp_b = 16'h0002;
		tmp_carry_in = 1'b1;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 2a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 2a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		///////			TEST 3
		tmp_a = 16'h000A;
		tmp_b = 16'hFCB1;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 3a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 3a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		tmp_a = 16'h000A;
		tmp_b = 16'hFCB1;
		tmp_carry_in = 1'b1;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 3b!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 3b!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		///////			TEST 4
		tmp_a = 16'h0AB1;
		tmp_b = 16'h0C9A;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 4a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 4a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		tmp_a = 16'h0AB1;
		tmp_b = 16'h0C9A;
		tmp_carry_in = 1'b1;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 4b!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 4b!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		///////			TEST 5
		tmp_a = 16'h0008;
		tmp_b = 16'h0003;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 5a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 5a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		tmp_a = 16'h0008;
		tmp_b = 16'h0003;
		tmp_carry_in = 1'b1;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 5b!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 5b!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		///////			TEST 6
		tmp_a = 16'hFFFE;
		tmp_b = 16'h0000;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 6a!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 6a!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
		tmp_b = 16'hFFFE;
		tmp_a = 16'h0000;
		tmp_carry_in = 16'b0;
		#1;
		tb_expected_outputs = tmp_a + tmp_b + tmp_carry_in;
		if(tb_expected_outputs == tb_sum) begin
			$info("Correct Sum value for test case 6b!");
		//end else begin
		//	$error("Incorrect Sum value for test case %d!", tb_test_case);
		end
		if(tb_expected_outputs[TEST_CARRY_OUT_BIT] == tb_carry_out) begin
			$info("Correct Carry Out value for test case 6b!");
		//end else begin
		//	$error("Incorrect Carry Out value for test case %d!", tb_test_case);
		end
	end
	
endmodule
