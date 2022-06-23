/*

*/

`timescale 1ns/1ps
module    threshold_binary#(
    parameter                           DW = 8                     ,
    parameter                           Th_mode = 0                 //0--global threshold 1--Contour threshold
        )(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input              [DW-1:0]         i_gray                     ,
    input                               i_hsync                    ,
    input                               i_vsync                    ,
    input                               i_de                       ,
        
    output             [DW-1:0]         o_binary                   ,
    output                              o_hsync                    ,
    output                              o_vsync                    ,
    output                              o_de                        
        );
		
reg                    [DW-1:0]         binary_r                   ;
reg                                     h_sync_r                   ;
reg                                     v_sync_r                   ;
reg                                     de_r                       ;

//synchronization
always@(posedge pixelclk)begin
  h_sync_r<= i_hsync;
  v_sync_r<= i_vsync;
  de_r    <= i_de;
end

always@(posedge pixelclk or negedge reset_n) begin
  if(!reset_n)
        binary_r <= 8'h00;
  else if(i_gray > 8'd90 )
      binary_r <= 8'hFF;
  else
      binary_r <= 8'h00;
end

assign o_binary = binary_r;

assign o_hsync = h_sync_r;
assign o_vsync = v_sync_r;
assign o_de     = de_r;
						
endmodule