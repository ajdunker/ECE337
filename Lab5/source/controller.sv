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

   typedef enum     bit [4:0] {IDLE, LOAD1, WAIT1, LOAD2, WAIT2, LOAD3, WAIT3, LOAD4, WAIT4, STORE, ZERO, SORT1, SORT2, SORT3, SORT4, MUL1, ADD1, MUL2, SUB1, MUL3, ADD2, MUL4, SUB2, EIDLE} states;
   states curr, next;

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
	next = curr;
	nxtMW = tmpMW;
	
	case(curr)
	  IDLE : begin
	     if (lc) begin
		next = LOAD1;
	     end else if (dr) begin
		next = STORE;
	     end else begin
		next = IDLE;
	     end

	     nxtMW = 0;
	     	     
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     op = 3'b000;
	  end
	  LOAD1 : begin
	     clear = 1;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;
	     
	     op = 3'b011;
	     dest = 4'd2;
	     
	     next = WAIT1;
	  end
	  WAIT1 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 0;
	     op = 3'b000;
	     
	     next = LOAD2;
	  end
	  LOAD2 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;
	     
	     op = 3'b011;
	     dest = 4'd4;	     
	     
	     next = WAIT2;
	  end
	  WAIT2 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 0;
	     op = 0;
	     next = LOAD3;	     
	  end
	  LOAD3 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;
	     
	     op = 3'b011;
	     dest = 4'd6;	     
	     
	     next = WAIT3;	     
	  end
	  WAIT3 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 0;
	     op = 0;
	     next = LOAD4;	     
	  end
	  LOAD4 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;
	     
	     op = 3'b011;
	     dest = 4'd8;	     
	     	     
	     next = WAIT4;	     
	  end
	  WAIT4 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 0;
	     op = 0;
	     
	     next = STORE;
	  end
	  STORE : begin
	     if (dr) begin
		next = ZERO;
		nxtMW = 1;		
	     end else begin
		next = EIDLE;
		nxtMW = 0;
	     end
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     op = 0;
	  end
	  ZERO : begin
	     clear = 0;
	     cnt_up = 1;
	     err= 0;
	     nxtMW = 1;
	     
	     op = 3'b101;
	     dest = 4'd0;
	     src1 = 4'd1;
	     src2 = 4'd1;
	
	     next = SORT1;
	  end
	  SORT1 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b001;
	     dest = 4'd1;
	     src1 = 4'd3;
	     	     
	     next = SORT2;	     
	  end
	  SORT2 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b001;
	     dest = 4'd3;
	     src1 = 4'd5;
	     
	     next = SORT3;	     
	  end
	  SORT3 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b001;
	     dest = 4'd5;
	     src1 = 4'd7;
	     
	     next = SORT4;	     
	  end
	  SORT4 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b001;
	     dest = 4'd5;
	     src1 = 4'd9;
	     
	     next = MUL1;	     
	  end
	  MUL1 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b110;
	     src1 = 4'd1;
	     src2 = 4'd2;
	     dest = 4'd10;
	     	     
	     next = ADD1;	     
	  end
	  ADD1 : begin
	     if (overflow) begin
		next = EIDLE;	
		nxtMW = 0;
	     end else begin
		next = MUL2;
		nxtMW = 1;
	     end

	     clear = 0;
	     cnt_up = 0;
	     err = 0;

	     op = 3'b100;
	     src1 = 4'd0;
	     src2 = 4'd10;
	     dest = 4'd0;	     
	  end
	  MUL2 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b110;
	     src1 = 4'd2;
	     src2 = 4'd3;
	     dest = 4'd10;
	     
	     next = SUB1;	     
	  end
	  SUB1 : begin
	     if (overflow) begin
		next = EIDLE;
		nxtMW = 0;
	     end else begin
		next = MUL3;
		nxtMW = 1;
	     end

	     clear = 0;
	     cnt_up = 0;
	     err = 0;

	     op = 3'b101;
	     src1 = 4'd0;
	     src2 = 4'd10;
	     dest = 4'd10;
	  end
	  MUL3 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b110;
	     src1 = 4'd4;
	     src2 = 4'd5;
	     dest = 4'd10;

	     next = ADD2;
	  end
	  ADD2 : begin
	     if (overflow) begin
		next = EIDLE;
		nxtMW = 0;
	     end else begin
		next = MUL3;
		nxtMW = 1;		
	     end

	     clear = 0;
	     cnt_up = 0;
	     err = 0;

	     op = 3'b100;
	     src1 = 4'd10;
	     src2 = 4'd0;
	     dest = 4'd0;	     
	  end
	  MUL4 : begin
	     clear = 0;
	     cnt_up = 0;
	     err = 0;
	     nxtMW = 1;

	     op = 3'b110;
	     src1 = 4'd6;
	     src2 = 4'd7;
	     dest = 4'd10;

	     next = SUB2;	     
	  end
	  SUB2 : begin
	     if (overflow) begin
		next = EIDLE;
		nxtMW = 0;		
	     end else begin
		cnt_up = 1;
		nxtMW = 1;
		next = IDLE;
	     end

	     clear = 0;
	     cnt_up = 0;
	     err = 0;

	     op = 3'b101;
	     src1 = 4'd0;
	     src2 = 4'd10;
	     dest = 4'd0;
	  end
	  EIDLE : begin
	     if(dr) begin
		next = STORE;
		nxtMW = 1;		
	     end else begin
		next = EIDLE;
		nxtMW = 0;		
	     end
	     
	     clear = 0;
	     cnt_up = 0;
	     err = 1;
	     op = 0;
	  end		
	endcase // case (curr)
     end

endmodule
