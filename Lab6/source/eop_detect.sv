// $Id: $
// File name:   eop_detect.sv
// Created:     2/23/2016
// Author:      Alexander Dunker
// Lab Section: 337-04
// Version:     1.0  Initial Design Entry
// Description: EOP Detector Block
// 
// This block detects the USB End-OF-Packet signal
// This occurs when both the d_plus and d_minus are logic low.

module eop_detect
  (
   input wire  d_plus,
   input wire  d_minus,
   output wire eop
   );

   assign eop = ~(d_plus | d_minus);
   
endmodule
