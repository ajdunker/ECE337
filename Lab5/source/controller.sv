// $Id: $
// File name:   controller.sv
// Created:     2/17/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: Control Unit.

module controller
  (
   input wire 	    clk,
   input wire 	    n_reset,
   input wire 	    dr,
   input wire 	    lc,
   input wire 	    overflow,
   output reg 	    cnt_up,
   output reg 	    clear,
   output wire 	    modwait,
   output reg [2:0] op,
   output reg [3:0] src1,
   output reg [3:0] src2,
   output reg [3:0] dest,
   output reg 	    err
   );

   typedef enum     bit [4:0] {IDLE, LCF1, WAIT1, LCF2, WAIT2, LCF3, WAIT3, LCF4, WAIT4, STORE, ZERO, SORT1, SORT2, SORT3, SORT4, MUL1, ADD1, MUL2, SUB1, MUL3, ADD2, MUL4, SUB2, EIDLE} currs;
   currs curr, next;

   reg 		    tmpMW;
   reg 		    nxtMW;

   always_ff @ (posedge clk, negedge n_reset)
     begin
	if(n_reset == 0) begin
	   curr <= IDLE;
	   tmpMW <= 0;
	end else begin
	   curr <= next;
	   tmpMW <= nxtMW;	   
	end
     end

   assign modwait = tmpMW;
   
   always_comb
     begin
	cnt_up=0;
	clear=0;
	op=0;
	src1=4'd0;
	src2=4'd0;
	dest=4'd0;
	err=0;
	next = curr;
	nxtMW = tmpMW;
	case (curr)
	  IDLE:
	    begin 
	       if (lc) begin
		  nxtMW=1;
		  next = LCF1;
	       end else if (dr) begin
		  nxtMW=1;
		  next = STORE;
	       end else begin
		  nxtMW=0;
		  next = IDLE;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b000;
	       err=0;
	    end 
	  LCF1:
	    begin
	       next = WAIT1;
	       cnt_up=0;
	       clear=1;
	       nxtMW=0;
	       op=3'b011;
	       dest=4'd6;
	       err=0;
	    end
	  WAIT1:
	    begin
	       if (lc) begin
		  next = LCF2;
		  nxtMW = 1;
	       end else begin
		  next = WAIT1;
		  nxtMW = 0;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b000;
	       err=0;
	    end
	  LCF2:
	    begin
	       next = WAIT2;
	       cnt_up=0;
	       clear=0;
	       nxtMW=0;
	       op=3'b011;
	       dest=4'd7;
	       err=0;
	    end
	  WAIT2:
	    begin
	       if (lc) begin
		  next = LCF3;
		  nxtMW = 1;
	       end else begin
		  next = WAIT2;
		  nxtMW = 0;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b000;
	       err=0;
	    end
	  LCF3:
	    begin
	       next = WAIT3;
	       cnt_up=0;
	       clear=0;
	       nxtMW=0;
	       op=3'b011;
	       dest=4'd8;
	       err=0;
	    end
	  WAIT3:
	    begin
	       if (lc) begin
		  next = LCF4;
		  nxtMW = 1;
	       end else begin
		  next = WAIT3;
		  nxtMW = 0;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b000;
	       err=0;
	    end
	  LCF4:
	    begin
	       next = IDLE;
	       cnt_up=0;
	       clear=0;
	       nxtMW=0;
	       op=3'b011;
	       dest=4'd9;
	       err=0;
	    end
	  STORE:
	    begin
	       if (dr) begin
		  nxtMW=1;
		  next = ZERO;
	       end else begin
		  nxtMW=0;
		  next = EIDLE;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b010;
	       dest=4'd5;
	       err=0;
	    end
	  ZERO:
	    begin
	       next = SORT1;
	       cnt_up=1;
	       clear=0;
	       nxtMW=1;
	       op=3'b101;
	       dest=4'd0;
	       src1=4'd0;
	       src2=4'd0;
	       err=0;
	    end
	  SORT1:
	    begin
	       next = SORT2;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b001;
	       dest=4'd1;
	       src1=4'd2;
	       err=0;
	    end
	  SORT2:
	    begin
	       next = SORT3;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b001;
	       dest=4'd2;
	       src1=4'd3;
	       err=0;
	    end
	  SORT3:
	    begin
	       next = SORT4;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b001;
	       dest=4'd3;
	       src1=4'd4;
	       err=0;
	    end
	  SORT4:
	    begin
	       next = MUL1;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b001;
	       dest=4'd4;
	       src1=4'd5;
	       err=0;
	    end
	  MUL1:
	    begin
	       next = ADD1;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b110;
	       dest=4'd10;
	       src1=4'd1;
	       src2=4'd6;
	       err=0;
	    end
	  ADD1:
	    begin
	       if (overflow) begin
		  nxtMW=0;
		  next = EIDLE;
	       end else begin
		  nxtMW=1;
		  next = MUL2;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b100;
	       dest=4'd0;
	       src1=4'd0;
	       src2=4'd10;
	       err=0;
	    end
	  MUL2:
	    begin
	       next = SUB1;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b110;
	       dest=4'd10;
	       src1=4'd2;
	       src2=4'd7;
	       err=0;
	    end
	  SUB1:
	    begin
	       if (overflow) begin
		  nxtMW=0;
		  next = EIDLE;
	       end else begin
		  nxtMW=1;
		  next = MUL3;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b101;
	       dest=4'd0;
	       src1=4'd0;
	       src2=4'd10;
	       err=0;
	    end
	  MUL3:
	    begin
	       next = ADD2;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b110;
	       dest=4'd10;
	       src1=4'd3;
	       src2=4'd8;
	       err=0;
	    end
	  ADD2:
	    begin
	       if (overflow) begin
		  nxtMW=0;
		  next = EIDLE;
	       end else begin
		  nxtMW=1;
		  next = MUL4;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b100;
	       dest=4'd0;
	       src1=4'd0;
	       src2=4'd10;
	       err=0;
	    end
	  MUL4:
	    begin
	       next = SUB2;
	       cnt_up=0;
	       clear=0;
	       nxtMW=1;
	       op=3'b110;
	       dest=4'd10;
	       src1=4'd4;
	       src2=4'd9;
	       err=0;
	    end
	  SUB2:
	    begin
	       if (overflow) begin
		  nxtMW=0;
		  next = EIDLE;
	       end else begin
		  nxtMW=0;
		  next = IDLE;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b101;
	       dest=4'd0;
	       src1=4'd0;
	       src2=4'd10;
	       err=0;
	    end
	  EIDLE:
	    begin
	       if (dr) begin
		  nxtMW=1;
		  next = STORE;
	       end else begin
		  nxtMW=0;
		  next = EIDLE;
	       end
	       cnt_up=0;
	       clear=0;
	       op=3'b000;
	       err=1;
	    end
	endcase
     end

endmodule
