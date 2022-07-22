`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 07/21/2022 03:18:07 PM
// Design Name: 
// Module Name: Top_design
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

`define N_WIDTH 4
`define SEG_WIDTH 8
`define COUNT_WIDTH 3
`define SEG_WID 2
`define COUNT_WID_REFRESH 17
module Top_design(
input i_clk , 
input i_rst, 
input incr , 
input decr ,
output [`SEG_WID-1:0] o_seg_en ,
output  an_seg ,   
output [`SEG_WIDTH-1:0] Sseg_out);

assign an_seg  = 1'b1;   
wire [3:0] seg_out ;
reg p_state ;
reg [`N_WIDTH-1:0] digit0 , digit1 ;
//reg [`COUNT_WIDTH-1:0] cnt_clr ;
reg [`COUNT_WID_REFRESH-1:0] refresh_cnt = 0 ; 
 
seven_seg_display SS( .i_hex_en(seg_out) , .o_out(Sseg_out) ); 
 
    wire clk_out ;
    
  clk_div DIV_CLK(.i_clk(i_clk) , .clk_o(clk_out));
 
 always @(posedge i_clk)
          begin
              refresh_cnt <= refresh_cnt + 1'b1 ; 
                end
                
 Multiplexer_circuit MUX(
.i_clk(refresh_cnt[16]) ,  
.o_seg1(digit0) ,
.o_seg2(digit1) ,
.o_en(o_seg_en)  , 
.o_seg(seg_out)
 );  
    
always @(posedge clk_out)
   begin
            case (p_state)
   0:           begin
                 digit0 <= 4'b0000;
                digit1 <= 4'b0000;
                p_state <= 1'b1 ;
                end
                
   1:       begin
                if (i_rst==1'b1)
                            begin
                                  p_state <= 1'b0 ;
                                      end    
              else if ( incr == 1'b1 && decr == 1'b0)
                                begin
                                   if (digit0 < 4'b1001)
                                                begin
                                                         digit0 <= digit0 + 1'b1 ;
                                                              end 
                                                                   else if (digit1 <4'b1001)
                                                                          begin
                                                                 digit1 <= digit1 + 1'b1 ; 
                                                         digit0 <= 4'b0000;
                                                   end
                                           end
              else if ( incr ==1'b0 && decr == 1'b1)
                                   begin
                                       if (digit0 >4'b0000) 
                                               begin
                                                       digit0 <= digit0 - 1'b1 ;
                                                     end
                                                  else if (digit1 >4'b0000)
                                                begin
                                             digit1 <= digit1 - 1'b1 ;
                                         digit0 <= 4'b1001;
                                     end 
                                end
             else if (incr == 1'b1 && decr == 1'b1)
                       begin 
                          
                          p_state <= 0;
                          end
                      end    
             default : begin
                           p_state <= 0;
                           end              
                    endcase
        end                                                                                                
endmodule
