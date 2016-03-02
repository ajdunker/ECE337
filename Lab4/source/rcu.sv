// $Id: $
// File name:   rcu.sv
// Created:     2/11/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Receiver control unit. Dictates the current mode of operation for the receiver block.

module rcu
  (
   input wire  clk,
   input wire  n_rst,
   input wire  start_bit_detected,
   input wire  packet_done,
   input wire  framing_error,
   output wire sbc_clear,
   output wire sbc_enable,
   output wire load_buffer,
   output wire enable_timer
   );

   typedef enum logic [2:0] {START, START_READ, BIT_READ, SBC_EN, FRAME_CHECK, BUFF_LOAD} states;
   states curr, next;

   always_ff @ (posedge clk, negedge n_rst)
     begin
	if(n_rst == 0) begin
	   curr <= START;
	end else begin
	   curr <= next;
	end
     end
   
   always @ (curr, start_bit_detected, packet_done, framing_error)
   begin
      next = curr;
      case(curr)
	START : begin
	   if (start_bit_detected) begin
	      next = START_READ;
	   end else begin
	      next = START;
	   end
	end
	START_READ : next = BIT_READ;
        BIT_READ: begin
	   if(packet_done) begin
	      next = SBC_EN;
	   end else begin
	      next = BIT_READ;
	   end
	end
	SBC_EN: next = FRAME_CHECK;
	FRAME_CHECK : begin
	   if(framing_error) begin
	      next = START;
	   end else begin
	      next = BUFF_LOAD;
	   end
	end
	BUFF_LOAD : next = START;
      endcase // case (curr)    
   end
   
   assign sbc_clear = (curr == START_READ);
   assign sbc_enable = (curr == SBC_EN);
   assign enable_timer = (curr == BIT_READ);
   assign load_buffer = (curr == BUFF_LOAD);

endmodule
