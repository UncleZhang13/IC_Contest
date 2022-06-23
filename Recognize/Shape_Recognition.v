
`timescale 1ns / 1ps

module Shape_Recognition(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input              [  23:0]         i_binary                   ,
    input                               i_hs                       ,
    input                               i_vs                       ,
    input                               i_de                       ,

    input              [  11:0]         i_hcount                   ,
    input              [  11:0]         i_vcount                   ,
	   
    input              [  11:0]         frame_cnt                  ,
    input              [   2:0]         vpframe_cnt                ,//0123
	   
    input              [  11:0]         i_hcount_l1                ,
    input              [  11:0]         i_hcount_r1                ,
    input              [  11:0]         i_hcount_l2                ,
    input              [  11:0]         i_hcount_r2                ,
    input              [  11:0]         i_hcount_l3                ,
    input              [  11:0]         i_hcount_r3                ,
    input              [  11:0]         i_hcount_l4                ,
    input              [  11:0]         i_hcount_r4                ,
    input              [  11:0]         i_hcount_l5                ,
    input              [  11:0]         i_hcount_r5                ,
    input              [  11:0]         i_hcount_l6                ,
    input              [  11:0]         i_hcount_r6                ,
    input              [  11:0]         i_hcount_l7                ,
    input              [  11:0]         i_hcount_r7                ,
    input              [  11:0]         i_hcount_l8                ,
    input              [  11:0]         i_hcount_r8                ,
    input              [  11:0]         i_vcount_l                 ,
    input              [  11:0]         i_vcount_r                 ,
	   
    output             [  39:0]         o_char1                    ,
    output             [  39:0]         o_char2                    ,
    output             [  39:0]         o_char3                    ,
    output             [  39:0]         o_char4                    ,
    output             [  39:0]         o_char5                    ,
    output             [  39:0]         o_char6                    ,
    output             [  39:0]         o_char7                    ,
    output             [  39:0]         o_char8                     
	   
       );
	   

	   
wire                                    ds1_o_hsync                ;
wire                                    ds1_o_vsync                ;
wire                                    ds1_o_de                   ;
wire                   [  23:0]         ds1_dout                   ;


capture_single U_capture_single1(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l1               ),
    .i_hcount_r                        (i_hcount_r1               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds1_dout                  ),
    .o_hsync                           (ds1_o_hsync               ),
    .o_vsync                           (ds1_o_vsync               ),
    .o_de                              (ds1_o_de                  ) 
       );

character_recognition U_character_recognition1(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds1_dout                  ),
    .i_hsync                           (ds1_o_hsync               ),
    .i_vsync                           (ds1_o_vsync               ),
    .i_de                              (ds1_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l1               ),
    .i_hcount_r                        (i_hcount_r1               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char1                   ) 
       );
	   
	   
wire                                    ds2_o_hsync                ;
wire                                    ds2_o_vsync                ;
wire                                    ds2_o_de                   ;
wire                   [  23:0]         ds2_dout                   ;

capture_single U_capture_single2(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l2               ),
    .i_hcount_r                        (i_hcount_r2               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds2_dout                  ),
    .o_hsync                           (ds2_o_hsync               ),
    .o_vsync                           (ds2_o_vsync               ),
    .o_de                              (ds2_o_de                  ) 
       );
 
character_recognition U_character_recognition2(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds2_dout                  ),
    .i_hsync                           (ds2_o_hsync               ),
    .i_vsync                           (ds2_o_vsync               ),
    .i_de                              (ds2_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l2               ),
    .i_hcount_r                        (i_hcount_r2               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char2                   ) 
       );
	   
wire                                    ds3_o_hsync                ;
wire                                    ds3_o_vsync                ;
wire                                    ds3_o_de                   ;
wire                   [  23:0]         ds3_dout                   ;
	   
capture_single U_capture_single3(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l3               ),
    .i_hcount_r                        (i_hcount_r3               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds3_dout                  ),
    .o_hsync                           (ds3_o_hsync               ),
    .o_vsync                           (ds3_o_vsync               ),
    .o_de                              (ds3_o_de                  ) 
       );

character_recognition U_character_recognition3(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds3_dout                  ),
    .i_hsync                           (ds3_o_hsync               ),
    .i_vsync                           (ds3_o_vsync               ),
    .i_de                              (ds3_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l3               ),
    .i_hcount_r                        (i_hcount_r3               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char3                   ) 
       );
	   
	  
wire                                    ds4_o_hsync                ;
wire                                    ds4_o_vsync                ;
wire                                    ds4_o_de                   ;
wire                   [  23:0]         ds4_dout                   ;

capture_single U_capture_single4(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l4               ),
    .i_hcount_r                        (i_hcount_r4               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds4_dout                  ),
    .o_hsync                           (ds4_o_hsync               ),
    .o_vsync                           (ds4_o_vsync               ),
    .o_de                              (ds4_o_de                  ) 
       );

character_recognition U_character_recognition4(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds4_dout                  ),
    .i_hsync                           (ds4_o_hsync               ),
    .i_vsync                           (ds4_o_vsync               ),
    .i_de                              (ds4_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l4               ),
    .i_hcount_r                        (i_hcount_r4               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char4                   ) 
       );
	
wire                                    ds5_o_hsync                ;
wire                                    ds5_o_vsync                ;
wire                                    ds5_o_de                   ;
wire                   [  23:0]         ds5_dout                   ;
	   
capture_single U_capture_single5(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l5               ),
    .i_hcount_r                        (i_hcount_r5               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds5_dout                  ),
    .o_hsync                           (ds5_o_hsync               ),
    .o_vsync                           (ds5_o_vsync               ),
    .o_de                              (ds5_o_de                  ) 
       );

character_recognition U_character_recognition5(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds5_dout                  ),
    .i_hsync                           (ds5_o_hsync               ),
    .i_vsync                           (ds5_o_vsync               ),
    .i_de                              (ds5_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l5               ),
    .i_hcount_r                        (i_hcount_r5               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char5                   ) 
       );
	   
wire                                    ds6_o_hsync                ;
wire                                    ds6_o_vsync                ;
wire                                    ds6_o_de                   ;
wire                   [  23:0]         ds6_dout                   ;
	   
capture_single U_capture_single6(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l6               ),
    .i_hcount_r                        (i_hcount_r6               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds6_dout                  ),
    .o_hsync                           (ds6_o_hsync               ),
    .o_vsync                           (ds6_o_vsync               ),
    .o_de                              (ds6_o_de                  ) 
       );

character_recognition U_character_recognition6(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds6_dout                  ),
    .i_hsync                           (ds6_o_hsync               ),
    .i_vsync                           (ds6_o_vsync               ),
    .i_de                              (ds6_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l6               ),
    .i_hcount_r                        (i_hcount_r6               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char6                   ) 
       );
	 
wire                                    ds7_o_hsync                ;
wire                                    ds7_o_vsync                ;
wire                                    ds7_o_de                   ;
wire                   [  23:0]         ds7_dout                   ;
	   
capture_single U_capture_single7(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l7               ),
    .i_hcount_r                        (i_hcount_r7               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds7_dout                  ),
    .o_hsync                           (ds7_o_hsync               ),
    .o_vsync                           (ds7_o_vsync               ),
    .o_de                              (ds7_o_de                  ) 
       );

character_recognition U_character_recognition7(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds7_dout                  ),
    .i_hsync                           (ds7_o_hsync               ),
    .i_vsync                           (ds7_o_vsync               ),
    .i_de                              (ds7_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l7               ),
    .i_hcount_r                        (i_hcount_r7               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char7                   ) 
       );

 
wire                                    ds8_o_hsync                ;
wire                                    ds8_o_vsync                ;
wire                                    ds8_o_de                   ;
wire                   [  23:0]         ds8_dout                   ;
	   
capture_single U_capture_single8(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
       
    .i_rgb                             (i_binary                  ),
    .i_hsync                           (i_hs                      ),
    .i_vsync                           (i_vs                      ),
    .i_de                              (i_de                      ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l8               ),
    .i_hcount_r                        (i_hcount_r8               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
	   
    .o_rgb                             (ds8_dout                  ),
    .o_hsync                           (ds8_o_hsync               ),
    .o_vsync                           (ds8_o_vsync               ),
    .o_de                              (ds8_o_de                  ) 
       );

character_recognition U_character_recognition8(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .frame_cnt                         (vpframe_cnt               ),

    .i_rgb                             (ds8_dout                  ),
    .i_hsync                           (ds8_o_hsync               ),
    .i_vsync                           (ds8_o_vsync               ),
    .i_de                              (ds8_o_de                  ),
	   
    .i_hcount                          (i_hcount                  ),
    .i_vcount                          (i_vcount                  ),
	   
    .i_hcount_l                        (i_hcount_l8               ),
    .i_hcount_r                        (i_hcount_r8               ),
    .i_vcount_l                        (i_vcount_l                ),
    .i_vcount_r                        (i_vcount_r                ),
    .o_char                            (o_char8                   ) 
       );

endmodule