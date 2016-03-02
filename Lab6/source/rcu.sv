// $Id: $
// File name:   rcu.sv
// Created:     3/1/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: RCU Block.

module rcu
  (
   input wire 	    clk,
   input wire 	    n_rst,
   input wire 	    d_edge,
   input wire 	    eop,
   input wire 	    shift_enable,
   input wire [7:0] rcv_data,
   input wire 	    byte_received,
   output logic     rcving,
   output logic     w_enable,
   output logic     r_error 	    
   );

   typedef enum     bit [3:0] {IDLE, RCV, CSYNC, RCV2, WBYTE, ESYNC, EWAIT, CONT, DONE, EIDLE} states;
   states state, nstate;

   always_ff @ (posedge clk, negedge n_rst)
     begin
	if(n_rst == 0) begin
	   state <= IDLE;
	end else begin
	   state <= nstate;
	end
     end

   always_comb
     begin
	nstate = state;

	rcving = 0;
	r_error = 0;
	w_enable = 0;
	
	case (state)
	  IDLE:
	    begin
	       if (d_edge) begin
		  nstate = RCV;
	       end else begin
		  nstate = IDLE;
	       end
	       rcving = 0;
	       r_error = 0;
	       w_enable = 0;
	    end
	  RCV:
	    begin
	       if (byte_received) begin
		  nstate = CSYNC;
	       end else begin
		  nstate = RCV;
	       end
	       rcving = 1;
	       r_error = 0;
	       w_enable = 0;
	    end
	  CSYNC:
	    begin
	       if (rcv_data == 8'b10000000) begin
		  nstate = RCV2;
	       end else begin
		  nstate = ESYNC;
	       end
	       rcving = 1;
	       r_error = 0;
	       w_enable = 0;
	    end
	  RCV2:
	    begin
	       if (byte_received) begin
		  nstate = WBYTE;
	       end else begin
		  nstate = RCV2;
	       end
	       if (shift_enable & eop) begin
		  nstate = EWAIT;
	       end
	       rcving = 1;
	       r_error = 0;
	       w_enable = 0;
	    end
	  WBYTE:
	    begin
	       nstate = CONT;
	       rcving = 0;
	       r_error = 0;
	       w_enable = 1;
	    end
	  ESYNC:
	    begin
	       if(shift_enable & eop) begin
		  nstate = EWAIT;
	       end else begin
		  nstate = ESYNC;
	       end
	       r_error = 1;
	       rcving = 1;
	       w_enable = 0;
	    end
	  EWAIT:
	    begin
	       if (d_edge) begin
		  nstate = EIDLE;
	       end else begin
		  nstate = EWAIT;
	       end
	       r_error = 1;
	       rcving = 0;
	       w_enable = 0;
	    end
	  CONT:
	    begin
	       if (shift_enable) begin
		  if (eop) begin
		     nstate = DONE;
		  end else begin
		     nstate = RCV2;
		  end
	       end else begin
		  nstate = CONT;
	       end
	       rcving = 0;
	       w_enable = 0;
	       r_error = 0;
	    end
	  DONE:
	    begin
	       if (d_edge) begin
		  nstate = IDLE;
	       end else begin
		  nstate = DONE;
	       end
	       rcving = 0;
	       w_enable = 0;
	       r_error = 0;
	    end
	  EIDLE:
	    begin
	       if (d_edge) begin
		  nstate = RCV;
	       end else begin
		  nstate = EIDLE;
	       end
	    end
	endcase // case (state)
     end
   
endmodule // rcu
