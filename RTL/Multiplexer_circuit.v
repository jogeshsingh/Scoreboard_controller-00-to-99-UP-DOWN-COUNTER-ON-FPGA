`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2022 04:01:12 PM
// Design Name: 
// Module Name: Multiplexer_circuit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////



`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/08/2022 01:14:32 PM
// Design Name: 
// Module Name: Mux_seven_seg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

///Multiplexer used to select two  seven seg display //
`define WIDTH_SEG 4
`define WIDTH_EN 2
module Multiplexer_circuit(
input i_clk ,  
input [`WIDTH_SEG-1:0]o_seg1 ,
input [`WIDTH_SEG-1:0]o_seg2 , 
output reg [`WIDTH_EN-1:0] o_en  , 
output reg [`WIDTH_SEG-1:0] o_seg
 );
 wire o_cnt;
 
 counter COUNTER(.i_clk(i_clk), .count_out(o_cnt));
    
 always @(*)
    begin
          case (o_cnt)
          1'b0: begin
                    o_seg = o_seg1 ;
                    o_en = 2'b10;
                     end 
         1'b1: begin
                    o_seg = o_seg2 ;
                    o_en = 2'b01;
                     end                  
        endcase
          end                              
endmodule
