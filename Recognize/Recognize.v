`timescale 1ns / 1ps
`define  DATA_WIDTH  8
`define   PICTURE_LENGTH 1024                                       //1024*768
module Recognize(
    input                               pixelclk                   ,
    input                               reset_n                    ,
        
    input              [  23:0]         i_rgb                      ,
    input                               i_hsync                    ,
    input                               i_vsync                    ,
    input                               i_de                       ,
    input                               i_blank                    ,
    output             [  23:0]         o_rgb                      ,
    output reg         [  63:0]         send_data                  ,
    output                              o_hsync                    ,
    output                              o_vsync                    ,
    output                              o_de                       ,
    output                              Rs232_Tx                    
        );

//rgb to ycbcr
wire                   [`DATA_WIDTH*3-1:0]y_rgb                      ;
wire                   [`DATA_WIDTH*3-1:0]y_ycbcr                    ;
wire                   [`DATA_WIDTH*3-1:0]y_gray                     ;
wire                                    y_o_hsync                  ;
wire                                    y_o_vsync                  ;
wire                                    y_o_de                     ;

//reg [2:0] frame_cnt_delay;
reg                    [   2:0]         vpframe_cnt_delay          ;
reg                                     blank_r0,blank_r1,blank_r2,blank_r3,blank_r4;
wire                   [   2:0]         vpframe_cnt                ;
always@(posedge pixelclk) begin
  blank_r0 <= i_blank;
  blank_r1 <= blank_r0;
  blank_r2 <= blank_r1;
  blank_r3 <= blank_r2;
  blank_r4 <= blank_r3;
 // frame_cnt_delay<=frame_cnt;      
  vpframe_cnt_delay<=vpframe_cnt;

end


assign o_blank = blank_r4;

rgb2ycbcr U_rgb2ycbcr(
    .pixelclk                          (pixelclk                  ),
        
    .i_rgb                             (i_rgb                     ),
    .i_hsync                           (i_hsync                   ),
    .i_vsync                           (i_vsync                   ),
    .i_de                              (i_de                      ),
		
    .o_rgb                             (y_rgb                     ),
    .o_ycbcr                           (y_ycbcr                   ),
    .o_gray                            (y_gray                    ),
    .o_hsync                           (y_o_hsync                 ),
    .o_vsync                           (y_o_vsync                 ),
    .o_de                              (y_o_de                    ) 
        );

		


wire                   [   7:0]         th_binary                  ;
wire                                    th_hsync                   ;
wire                                    th_vsync                   ;
wire                                    th_de                      ;
		
threshold_binary#(
    .DW                                (`DATA_WIDTH               ),
    .Th_mode                           (0                         ) //0--global threshold 1--Contour threshold
        )U_threshold_binary(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_gray                            (y_gray[23:16]             ),
    .i_hsync                           (y_o_hsync                 ),
    .i_vsync                           (y_o_vsync                 ),
    .i_de                              (y_o_de                    ),
        
    .o_binary                          (th_binary                 ),
    .o_hsync                           (th_hsync                  ),
    .o_vsync                           (th_vsync                  ),
    .o_de                              (th_de                     ) 
        );

	   
wire                   [  11:0]         hcount                     ;
wire                   [  11:0]         vcount                     ;

wire                                    HV_o_hsync                 ;
wire                                    HV_o_vsync                 ;
wire                                    HV_o_de                    ;
wire                   [`DATA_WIDTH*3-1:0]HV_dout                    ;


wire                   [   7:0]         sobel_rgb                  ;
wire                                    sobel_hsync                ;
wire                                    sobel_vsync                ;
wire                                    sobel_de                   ;

sobel_test #(
    .threshold                         (100 )                     ) 
 U_sobel_test
 (
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_vsync                           (th_vsync                  ),
    .i_hsync                           (th_hsync                  ),
    .i_de                              (th_de                     ),
    .i_rgb                             (th_binary                 ),

    .o_rgb                             (sobel_rgb                 ),
    .o_vsync                           (sobel_vsync               ),
    .o_hsync                           (sobel_hsync               ),
    .o_de                              (sobel_de                  ) 
);
		
HVcount#(
    .DW                                (`DATA_WIDTH*3             ),
    .IW                                (`PICTURE_LENGTH           ) 
      )
U1_HVcount
(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_data                            ({sobel_rgb,sobel_rgb,sobel_rgb}),
    .i_hsync                           (sobel_hsync               ),
    .i_vsync                           (sobel_vsync               ),
    .i_de                              (sobel_de                  ),
    
    .hcount                            (hcount                    ),
    .vcount                            (vcount                    ),
    .o_data                            (HV_dout                   ),
    .o_hsync                           (HV_o_hsync                ),
    .o_vsync                           (HV_o_vsync                ),
    .o_de                              (HV_o_de                   ) 
    );


wire                   [  11:0]         hcount_l                   ;
wire                   [  11:0]         hcount_r                   ;

wire                   [  11:0]         vcount_l                   ;
wire                   [  11:0]         vcount_r                   ;
		
Projection#(
    .IMG_WIDTH_LINE                    (`PICTURE_LENGTH           ),
    .IMG_WIDTH_DATA                    (`DATA_WIDTH*3             ) 
       )
U_Projection
(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_binary                          (HV_dout                   ),
    .i_hs                              (HV_o_hsync                ),
    .i_vs                              (HV_o_vsync                ),
    .i_de                              (HV_o_de                   ),
      
    .i_hcount                          (hcount                    ),
    .i_vcount                          (vcount                    ),
	   
    .hcount_l                          (hcount_l                  ),
    .hcount_r                          (hcount_r                  ),
    .vcount_l                          (vcount_l                  ),
    .vcount_r                          (vcount_r                  ) 
       );
	   
wire                                    di_o_hsync                 ;
wire                                    di_o_vsync                 ;
wire                                    di_o_de                    ;
wire                   [`DATA_WIDTH*3-1:0]di_dout                    ;

	
wire                                    c_o_hsync                  ;
wire                                    c_o_vsync                  ;
wire                                    c_o_de                     ;
wire                   [`DATA_WIDTH*3-1:0]c_dout                     ;


//assign o_rgb   = (c_o_de)?~c_dout:24'd0;
//assign o_hsync = c_o_hsync;
//assign o_vsync = c_o_vsync;                                                                                                  
//assign o_de   	= c_o_de;	
//capture lpr
Capture U_capture(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
      
    .hcount                            (hcount                    ),
    .vcount                            (vcount                    ),
    .i_rgb                             (HV_dout                   ),
    .i_hsync                           (HV_o_hsync                ),
    .i_vsync                           (HV_o_vsync                ),
    .i_de                              (HV_o_de                   ),
	   
    .hcount_l                          (hcount_l                  ),
    .hcount_r                          (hcount_r                  ),
    .vcount_l                          (vcount_l                  ),
    .vcount_r                          (vcount_r                  ),
	  
    .o_rgb                             (c_dout                    ),
    .o_hsync                           (c_o_hsync                 ),
    .o_vsync                           (c_o_vsync                 ),
    .o_de                              (c_o_de                    ) 
       );

reg                    [  11:0]         v_u                        ;

reg                    [  11:0]         v_d                        ;


always@(posedge pixelclk or negedge reset_n)begin
    if(!reset_n)begin
        v_u<=0;
        v_d<=0;
    end
    else begin
        v_u<=vcount_l;
        v_d<=vcount_r-1'b1;
    end
end

wire                   [  11:0]         hcount1                    ;
wire                   [  11:0]         vcount1                    ;

wire                                    HV1_o_hsync                ;
wire                                    HV1_o_vsync                ;
wire                                    HV1_o_de                   ;
wire                   [`DATA_WIDTH*3-1:0]HV1_dout                   ;

	   
HVcount#(
    .DW                                (`DATA_WIDTH*3             ),
    .IW                                (`PICTURE_LENGTH           ) 
      )
U2_HVcount
      (
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_data                            (~c_dout                   ),
    .i_hsync                           (c_o_hsync                 ),
    .i_vsync                           (c_o_vsync                 ),
    .i_de                              (c_o_de                    ),
    
    .hcount                            (hcount1                   ),
    .vcount                            (vcount1                   ),
	
    .o_data                            (HV1_dout                  ),
    .o_hsync                           (HV1_o_hsync               ),
    .o_vsync                           (HV1_o_vsync               ),
    .o_de                              (HV1_o_de                  ) 
    );

 

wire                   [  11:0]         hcount_l1                  ;
wire                   [  11:0]         hcount_r1                  ;
wire                   [  11:0]         hcount_l2                  ;
wire                   [  11:0]         hcount_r2                  ;
wire                   [  11:0]         hcount_l3                  ;
wire                   [  11:0]         hcount_r3                  ;
wire                   [  11:0]         hcount_l4                  ;
wire                   [  11:0]         hcount_r4                  ;
wire                   [  11:0]         hcount_l5                  ;
wire                   [  11:0]         hcount_r5                  ;
wire                   [  11:0]         hcount_l6                  ;
wire                   [  11:0]         hcount_r6                  ;
wire                   [  11:0]         hcount_l7                  ;
wire                   [  11:0]         hcount_r7                  ;
wire                   [  11:0]         hcount_l8                  ;
wire                   [  11:0]         hcount_r8                  ;
wire                   [  11:0]         vcount_l1                  ;
wire                   [  11:0]         vcount_r1                  ;
	   
Projection8#(
    .IMG_WIDTH_LINE                    (`PICTURE_LENGTH           ),
    .IMG_WIDTH_DATA                    (`DATA_WIDTH*3             ) 
       )
U_Projection8
(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_binary                          (HV1_dout                  ),
    .i_hs                              (HV1_o_hsync               ),
    .i_vs                              (HV1_o_vsync               ),
    .i_de                              (HV1_o_de                  ),
    .v_u                               (v_u                       ),
    .v_d                               (v_d                       ),
    .i_hcount                          (hcount1                   ),
    .i_vcount                          (vcount1                   ),
    .frame_cnt                         (vpframe_cnt               ),
    .hcount_l1                         (hcount_l1                 ),
    .hcount_r1                         (hcount_r1                 ),
    .hcount_l2                         (hcount_l2                 ),
    .hcount_r2                         (hcount_r2                 ),
    .hcount_l3                         (hcount_l3                 ),
    .hcount_r3                         (hcount_r3                 ),
    .hcount_l4                         (hcount_l4                 ),
    .hcount_r4                         (hcount_r4                 ),
    .hcount_l5                         (hcount_l5                 ),
    .hcount_r5                         (hcount_r5                 ),
    .hcount_l6                         (hcount_l6                 ),
    .hcount_r6                         (hcount_r6                 ),
    .hcount_l7                         (hcount_l7                 ),
    .hcount_r7                         (hcount_r7                 ),
    .hcount_l8                         (hcount_l8                 ),
    .hcount_r8                         (hcount_r8                 ),
    .vcount_l                          (vcount_l1                 ),
    .vcount_r                          (vcount_r1                 ) 
        );
		

	
wire                   [  39:0]         char1                      ;
wire                   [  39:0]         char2                      ;
wire                   [  39:0]         char3                      ;
wire                   [  39:0]         char4                      ;
wire                   [  39:0]         char5                      ;
wire                   [  39:0]         char6                      ;
wire                   [  39:0]         char7                      ;
wire                   [  39:0]         char8                      ;


wire                   [   7:0]         char_result1               ;
wire                   [   7:0]         char_result2               ;
wire                   [   7:0]         char_result4               ;
wire                   [   7:0]         char_result5               ;
wire                   [   7:0]         char_result6               ;
wire                   [   7:0]         char_result7               ;
wire                   [   7:0]         char_result8               ;

		
Shape_Recognition U_Shape_Recognition(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_binary                          (HV1_dout                  ),
    .i_hs                              (HV1_o_hsync               ),
    .i_vs                              (HV1_o_vsync               ),
    .i_de                              (HV1_o_de                  ),
	   
    .i_hcount                          (hcount1                   ),
    .i_vcount                          (vcount1                   ),
	   
    .frame_cnt                         (frame_cnt                 ),
    .vpframe_cnt                       (vpframe_cnt_delay         ),//0123
	   
	   
    .i_hcount_l1                       (hcount_l1                 ),
    .i_hcount_r1                       (hcount_r1                 ),
    .i_hcount_l2                       (hcount_l2                 ),
    .i_hcount_r2                       (hcount_r2                 ),
    .i_hcount_l3                       (hcount_l3                 ),
    .i_hcount_r3                       (hcount_r3                 ),
    .i_hcount_l4                       (hcount_l4                 ),
    .i_hcount_r4                       (hcount_r4                 ),
    .i_hcount_l5                       (hcount_l5                 ),
    .i_hcount_r5                       (hcount_r5                 ),
    .i_hcount_l6                       (hcount_l6                 ),
    .i_hcount_r6                       (hcount_r6                 ),
    .i_hcount_l7                       (hcount_l7                 ),
    .i_hcount_r7                       (hcount_r7                 ),
    .i_hcount_l8                       (hcount_l8                 ),
    .i_hcount_r8                       (hcount_r8                 ),
    .i_vcount_l                        (vcount_l1                 ),
    .i_vcount_r                        (vcount_r1                 ),
	   
    .o_char1                           (char1                     ),
    .o_char2                           (char2                     ),
    .o_char3                           (char3                     ),
    .o_char4                           (char4                     ),
    .o_char5                           (char5                     ),
    .o_char6                           (char6                     ),
    .o_char7                           (char7                     ),
    .o_char8                           (char8                     ) 
       );
	   

character_match U_character_match(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_vsync                           (ds_o_vsync                ),
    .i_frame_cnt                       (vpframe_cnt               ),//1230
    .i_char1                           (char1                     ),
    .i_char2                           (char2                     ),
    .i_char3                           (char3                     ),
    .i_char4                           (char4                     ),
    .i_char5                           (char5                     ),
    .i_char6                           (char6                     ),
    .i_char7                           (char7                     ),
    .i_char8                           (char8                     ),

    .o_char_result1                    (char_result1              ),
    .o_char_result2                    (char_result2              ),
    .o_char_result3                    (char_result3              ),
    .o_char_result4                    (char_result4              ),
    .o_char_result5                    (char_result5              ),
    .o_char_result6                    (char_result6              ),
    .o_char_result7                    (char_result7              ),
    .o_char_result8                    (char_result8              ) 
);


wire                   [  23:0]         th_binary_color            ;
wire                                    th_hsync_color             ;
wire                                    th_vsync_color             ;
wire                                    th_de_color                ;

threshold_binary_color U_threshold_binary_color(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_ycbcr                           (y_ycbcr                   ),
    .i_hsync                           (y_o_hsync                 ),
    .i_vsync                           (y_o_vsync                 ),
    .i_de                              (y_o_de                    ),

    .o_binary                          (th_binary_color           ),
    .o_hsync                           (th_hsync_color            ),
    .o_vsync                           (th_vsync_color            ),
    .o_de                              (th_de_color               ) 
);


wire                   [  11:0]         hcount_color               ;
wire                   [  11:0]         vcount_color               ;

wire                                    HV_o_hsync_color           ;
wire                                    HV_o_vsync_color           ;
wire                                    HV_o_de_color              ;
wire                   [`DATA_WIDTH*3-1:0]HV_dout_color              ;

HVcount#(
    .DW                                (`DATA_WIDTH*3             ),
    .IW                                (`PICTURE_LENGTH           ) 
    )
U3_HVcount
(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_data                            (th_binary_color           ),
    .i_hsync                           (th_hsync_color            ),
    .i_vsync                           (th_vsync_color            ),
    .i_de                              (th_de_color               ),
    
    .hcount                            (hcount_color              ),
    .vcount                            (vcount_color              ),
    .o_data                            (HV_dout_color             ),
    .o_hsync                           (HV_o_hsync_color          ),
    .o_vsync                           (HV_o_vsync_color          ),
    .o_de                              (HV_o_de_color             ) 
    );

wire                   [   7:0]         o_color_result_1           ;
wire                   [   7:0]         o_color_result_2           ;
wire                   [   7:0]         o_color_result_3           ;
wire                   [   7:0]         o_color_result_4           ;
wire                   [   7:0]         o_color_result_5           ;
wire                   [   7:0]         o_color_result_6           ;
wire                   [   7:0]         o_color_result_7           ;
wire                   [   7:0]         o_color_result_8           ;

Color_recognize  U_Color_recognize (
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_binary                          (HV_dout_color             ),
    .i_hs                              (HV_o_hsync_color          ),
    .i_vs                              (HV_o_vsync_color          ),
    .i_de                              (HV_o_de_color             ),

    .i_hcount                          (hcount1                   ),
    .i_vcount                          (vcount1                   ),

    .frame_cnt                         (frame_cnt                 ),
    .vpframe_cnt                       (vpframe_cnt_delay         ),

    .i_hcount_l1                       (hcount_l1                 ),
    .i_hcount_r1                       (hcount_r1                 ),
    .i_hcount_l2                       (hcount_l2                 ),
    .i_hcount_r2                       (hcount_r2                 ),
    .i_hcount_l3                       (hcount_l3                 ),
    .i_hcount_r3                       (hcount_r3                 ),
    .i_hcount_l4                       (hcount_l4                 ),
    .i_hcount_r4                       (hcount_r4                 ),
    .i_hcount_l5                       (hcount_l5                 ),
    .i_hcount_r5                       (hcount_r5                 ),
    .i_hcount_l6                       (hcount_l6                 ),
    .i_hcount_r6                       (hcount_r6                 ),
    .i_hcount_l7                       (hcount_l7                 ),
    .i_hcount_r7                       (hcount_r7                 ),
    .i_hcount_l8                       (hcount_l8                 ),
    .i_hcount_r8                       (hcount_r8                 ),
    .i_vcount_l                        (vcount_l                  ),
    .i_vcount_r                        (vcount_r                  ),

    .o_color_result_1                  (o_color_result_1          ),
    .o_color_result_2                  (o_color_result_2          ),
    .o_color_result_3                  (o_color_result_3          ),
    .o_color_result_4                  (o_color_result_4          ),
    .o_color_result_5                  (o_color_result_5          ),
    .o_color_result_6                  (o_color_result_6          ),
    .o_color_result_7                  (o_color_result_7          ),
    .o_color_result_8                  (o_color_result_8          ) 
);

wire                   [   7:0]         char_result_number         ;
Number_counter  U_Number_counter (
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),

    .hcount_l1                         (hcount_l1                 ),
    .hcount_r1                         (hcount_r1                 ),
    .hcount_l2                         (hcount_l2                 ),
    .hcount_r2                         (hcount_r2                 ),
    .hcount_l3                         (hcount_l3                 ),
    .hcount_r3                         (hcount_r3                 ),
    .hcount_l4                         (hcount_l4                 ),
    .hcount_r4                         (hcount_r4                 ),
    .hcount_l5                         (hcount_l5                 ),
    .hcount_r5                         (hcount_r5                 ),
    .hcount_l6                         (hcount_l6                 ),
    .hcount_r6                         (hcount_r6                 ),
    .hcount_l7                         (hcount_l7                 ),
    .hcount_r7                         (hcount_r7                 ),
    .hcount_l8                         (hcount_l8                 ),
    .hcount_r8                         (hcount_r8                 ),

    .char_result_number                (char_result_number        ) 
);

send_char  U_send_char (
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .vpframe_cnt                       (vpframe_cnt               ),
    .i_vsync                           (i_vsync                   ),
    .char_result_fruit1                (char_result1              ),
    .char_result_fruit2                (char_result2              ),
    .char_result_fruit3                (char_result3              ),
    .char_result_fruit4                (char_result4              ),
    .char_result_fruit5                (char_result5              ),
    .char_result_fruit6                (char_result6              ),
    .char_result_fruit7                (char_result7              ),
    .char_result_fruit8                (char_result8              ),
    .char_result_colour1               (o_color_result_1          ),
    .char_result_colour2               (o_color_result_2          ),
    .char_result_colour3               (o_color_result_3          ),
    .char_result_colour4               (o_color_result_4          ),
    .char_result_colour5               (o_color_result_5          ),
    .char_result_colour6               (o_color_result_6          ),
    .char_result_colour7               (o_color_result_7          ),
    .char_result_colour8               (o_color_result_8          ),
    
    .char_result_number                (char_result_number        ),

    .Rs232_Tx                          (Rs232_Tx                  ) 
);


endmodule