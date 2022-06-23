/*************************************************
capture a target
**************************************************/

`timescale 1ns / 1ps
module capture_single(
    input                               pixelclk                   ,
    input                               reset_n                    ,

    input              [  23:0]         i_rgb                      ,
    input                               i_hsync                    ,
    input                               i_vsync                    ,
    input                               i_de                       ,
	   
    input              [  11:0]         i_hcount                   ,
    input              [  11:0]         i_vcount                   ,
	   
    input              [  11:0]         i_hcount_l                 ,
    input              [  11:0]         i_hcount_r                 ,
    input              [  11:0]         i_vcount_l                 ,
    input              [  11:0]         i_vcount_r                 ,
	   
    output             [  23:0]         o_rgb                      ,
    output                              o_hsync                    ,
    output                              o_vsync                    ,
    output                              o_de                        
       );

reg                    [  23:0]         rgb_r                      ;
reg                                     hsync_r                    ;
reg                                     vsync_r                    ;
reg                                     de_r                       ;
       
always @(posedge pixelclk) begin
  hsync_r <= i_hsync;
  vsync_r <= i_vsync;
  de_r    <= i_de;
end

assign o_hsync = hsync_r;
assign o_vsync = vsync_r;
assign o_de    = de_r;
assign o_rgb   = rgb_r;
//-------------------------------------------------------------
// Display
//-------------------------------------------------------------
always @(posedge pixelclk or negedge reset_n) begin
  if(!reset_n)
    rgb_r <= 24'h00000;
  else if ((i_vcount >= i_vcount_l && i_vcount <= i_vcount_r) && (i_hcount >= i_hcount_l && i_hcount <= i_hcount_r))
    rgb_r <= i_rgb;
  else
    rgb_r <= 24'hffffff;
end

endmodule