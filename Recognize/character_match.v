/**********************************
ASCII
**********************************/
`timescale 1ns / 1ps

module character_match(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input                               i_vsync                    ,
    input              [   2:0]         i_frame_cnt                ,//1230
    input              [  39:0]         i_char1                    ,
    input              [  39:0]         i_char2                    ,
    input              [  39:0]         i_char3                    ,
    input              [  39:0]         i_char4                    ,
    input              [  39:0]         i_char5                    ,
    input              [  39:0]         i_char6                    ,
    input              [  39:0]         i_char7                    ,
    input              [  39:0]         i_char8                    ,
    output             [   7:0]         o_char_result1             ,
    output             [   7:0]         o_char_result2             ,
    output             [   7:0]         o_char_result3             ,
    output             [   7:0]         o_char_result4             ,
    output             [   7:0]         o_char_result5             ,
    output             [   7:0]         o_char_result6             ,
    output             [   7:0]         o_char_result7             ,
    output             [   7:0]         o_char_result8              
       );
reg                                     i_vsync_r                  ;
wire                                    i_vsync_pos                ;

always @(posedge pixelclk)begin
  i_vsync_r <= i_vsync;
end

assign i_vsync_pos = (!i_vsync &(i_vsync_r));

//fruit1
char_all_compare char1_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char1                     ),
    .o_char_result1                    (char_result1              ) 
);

//fruit2
char_all_compare char2_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char2                     ),
    .o_char_result1                    (char_result2              ) 
);

//fruit3
char_all_compare char3_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char3                     ),
    .o_char_result1                    (char_result3              ) 
);

//fruit4
char_all_compare char4_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char4                     ),
    .o_char_result1                    (char_result4              ) 
);

//fruit5
char_all_compare char5_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char5                     ),
    .o_char_result1                    (char_result5              ) 
);

//fruit6
char_all_compare char6_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char6                     ),
    .o_char_result1                    (char_result6              ) 
);

//fruit7
char_all_compare char7_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char7                     ),
    .o_char_result1                    (char_result7              ) 
);

//fruit8
char_all_compare char8_compare(
    .pixelclk                          (pixelclk                  ),
    .reset_n                           (reset_n                   ),
    .i_frame_cnt                       (i_frame_cnt               ),
    .i_vsync_pos                       (i_vsync_pos               ),
    
    .i_char1                           (char8                     ),
    .o_char_result1                    (char_result8              ) 
);

endmodule
