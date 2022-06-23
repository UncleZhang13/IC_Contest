
`timescale 1ns/1ps
module  threshold_binary_color#(
    parameter                           DW        = 24             ,

    parameter                           Y_TH_R      = 150          ,
    parameter                           Y_TL_R      = 40           ,
    parameter                           CB_TH_R     = 155          ,
    parameter                           CB_TL_R     = 100          ,
    parameter                           CR_TH_R     = 240          ,
    parameter                           CR_TL_R     = 160          ,//red

    parameter                           Y_TH_B      = 135          ,
    parameter                           Y_TL_B      = 50           ,
    parameter                           CB_TH_B     = 245          ,
    parameter                           CB_TL_B     = 156          ,
    parameter                           CR_TH_B     = 140          ,
    parameter                           CR_TL_B     = 80           ,//blule

    parameter                           Y_TH_G      = 120          ,
    parameter                           Y_TL_G      = 0            ,
    parameter                           CB_TH_G     = 250          ,
    parameter                           CB_TL_G     = 160          ,
    parameter                           CR_TH_G     = 120          ,
    parameter                           CR_TL_G     = 0            ,//green

    parameter                           Y_TH_P      = 160          ,
    parameter                           Y_TL_P      = 90           ,
    parameter                           CB_TH_P     = 78           ,
    parameter                           CB_TL_P     = 23           ,
    parameter                           CR_TH_P     = 99           ,
    parameter                           CR_TL_P     = 60           ,//purple

    parameter                           Y_TH_O      = 140          ,
    parameter                           Y_TL_O      = 90           ,
    parameter                           CB_TH_O     = 127          ,
    parameter                           CB_TL_O     = 85           ,
    parameter                           CR_TH_O     = 74           ,
    parameter                           CR_TL_O     = 50           ,//orange

    parameter                           Y_TH_Y      = 130          ,
    parameter                           Y_TL_Y      = 70           ,
    parameter                           CB_TH_Y     = 140          ,
    parameter                           CB_TL_Y     = 90           ,
    parameter                           CR_TH_Y     = 90           ,
    parameter                           CR_TL_Y     = 60            //yellow
)
(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input              [DW-1:0]         i_ycbcr                    ,
    input                               i_hsync                    ,
    input                               i_vsync                    ,
    input                               i_de                       ,
   
        
    output             [DW-1:0]         o_binary                   ,
    output             [DW-1:0]         o_rgb                      ,
    output                              o_hsync                    ,
    output                              o_vsync                    ,
    output                              o_de                        
);


reg                    [DW-1:0]         binary_r                   ;
reg                                     h_sync_r                   ;
reg                                     v_sync_r                   ;
reg                                     de_r                       ;
wire                                    en0_r                      ;
wire                                    en1_r                      ;
wire                                    en2_r                      ;
wire                                    en0_b                      ;
wire                                    en1_b                      ;
wire                                    en2_b                      ;
wire                                    en0_g                      ;
wire                                    en1_g                      ;
wire                                    en2_g                      ;
wire                                    en0_p                      ;
wire                                    en1_p                      ;
wire                                    en2_p                      ;
wire                                    en0_o                      ;
wire                                    en1_o                      ;
wire                                    en2_o                      ;
wire                                    en0_y                      ;
wire                                    en1_y                      ;
wire                                    en2_y                      ;


/****************************************输出连线*********************************************/
assign o_binary = binary_r;
assign o_hsync  = h_sync_r;
assign o_vsync  = v_sync_r;
assign o_de     = de_r;

////////////////////// threshold//////////////////////////////////////
assign en0_r      =i_ycbcr[23:16] >=Y_TL_R  && i_ycbcr[23:16] <= Y_TH_R;
assign en1_r      =i_ycbcr[15: 8] >=CB_TL_R && i_ycbcr[15: 8] <= CB_TH_R;
assign en2_r      =i_ycbcr[ 7: 0] >=CR_TL_R && i_ycbcr[ 7: 0] <= CR_TH_R;

assign en0_b      =i_ycbcr[23:16] >=Y_TL_B && i_ycbcr[23:16] <= Y_TH_B  ;
assign en1_b      =i_ycbcr[15: 8] >=CB_TL_B && i_ycbcr[15: 8] <= CB_TH_B;
assign en2_b      =i_ycbcr[ 7: 0] >=CR_TL_B && i_ycbcr[ 7: 0] <= CR_TH_B;

assign en0_g      =i_ycbcr[23:16] >=Y_TL_G && i_ycbcr[23:16]  <= Y_TH_G;
assign en1_g      =i_ycbcr[15: 8] >=CB_TL_G  && i_ycbcr[15: 8] <= CB_TH_G;
assign en2_g      =i_ycbcr[ 7: 0] >=CR_TL_G  && i_ycbcr[ 7: 0] <= CR_TH_G;

assign en0_p      =i_ycbcr[23:16] >=Y_TL_P && i_ycbcr[23:16]  <= Y_TH_P;
assign en1_p      =i_ycbcr[15: 8] >=CB_TL_P  && i_ycbcr[15: 8] <= CB_TH_P;
assign en2_p      =i_ycbcr[ 7: 0] >=CR_TL_P  && i_ycbcr[ 7: 0] <= CR_TH_P;

assign en0_o      =i_ycbcr[23:16] >=Y_TL_O && i_ycbcr[23:16]  <= Y_TH_O;
assign en1_o      =i_ycbcr[15: 8] >=CB_TL_O  && i_ycbcr[15: 8] <= CB_TH_O;
assign en2_o      =i_ycbcr[ 7: 0] >=CR_TL_O  && i_ycbcr[ 7: 0] <= CR_TH_O;

assign en0_y      =i_ycbcr[23:16] >=Y_TL_Y && i_ycbcr[23:16]  <= Y_TH_Y;
assign en1_y      =i_ycbcr[15: 8] >=CB_TL_Y  && i_ycbcr[15: 8] <= CB_TH_Y;
assign en2_y      =i_ycbcr[ 7: 0] >=CR_TL_Y  && i_ycbcr[ 7: 0] <= CR_TH_Y;

/********************************************************************************************/

/***************************************timing***********************************************/

always @(posedge pixelclk)begin
    h_sync_r<= i_hsync;
    v_sync_r<= i_vsync;
    de_r    <= i_de;
end

/********************************************************************************************/

/***************************************Binarization threshold*******************************/


always @(posedge pixelclk or negedge reset_n) begin
    if(!reset_n)begin
        binary_r <= 24'd0;
    end
    else begin
        if(en0_r==1'b1 && en1_r ==1'b1 && en2_r==1'b1) begin
            binary_r <= 24'h333333;
        end
        else if(en0_b==1'b1 && en1_b ==1'b1 && en2_b==1'b1)begin
             binary_r <= 24'h111111;
        end
        else if(en0_g==1'b1 && en1_g ==1'b1 && en2_g==1'b1)begin
             binary_r <= 24'h222222;
        end
        else if(en0_p==1'b1 && en1_p ==1'b1 && en2_p==1'b1)begin
            binary_r <= 24'h444444;
        end
        else if(en0_o==1'b1 && en1_o ==1'b1 && en2_o==1'b1)begin
            binary_r <= 24'h666666;
        end
        else if(en0_y==1'b1 && en1_y ==1'b1 && en2_y==1'b1)begin
            binary_r <= 24'h777777;
       end
        else begin
            binary_r <= 24'hffffff;
        end
    end
end



endmodule