`include "para.v"

module color_recognition(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input              [   2:0]         frame_cnt                  ,//1230

    input              [  23:0]         i_binary                   ,// 接capture_single的输出o_rgb
    input                               i_hsync                    ,
    input                               i_vsync                    ,
    input                               i_de                       ,
    
    input              [  11:0]         i_hcount                   ,// 接行场同步
    input              [  11:0]         i_vcount                   ,
    
    input              [  11:0]         i_hcount_l                 ,// 接projection8的输出
    input              [  11:0]         i_hcount_r                 ,
    input              [  11:0]         i_vcount_l                 ,
    input              [  11:0]         i_vcount_r                 ,
    output             [   7:0]         o_color_result              

);

reg                    [   7:0]         o_color_result_r           ;
reg                    [  11:0]         count_red                  ;
reg                    [  11:0]         count_blue                 ;
reg                    [  11:0]         count_green                ;
reg                    [  11:0]         count_yellow               ;
reg                    [  11:0]         count_purple               ;
reg                    [  11:0]         count_orange               ;

always @(posedge pixelclk or negedge reset_n) begin
    if(!reset_n) begin
        count_red       <= 11'd0;
        count_blue      <= 11'd0;
        count_green     <= 11'd0;
        count_yellow    <= 11'd0;
        count_purple    <= 11'd0;
        count_orange    <= 11'd0;
    end
    else if((i_hcount >= i_hcount_l) && (i_hcount <= i_hcount_r) && (i_vcount >= i_vcount_l) && (i_vcount <= i_vcount_r))begin
        if(i_binary == 24'h333_333)
        count_red <= count_red + 1;
        else if(i_binary == 24'h111_111)begin
            count_blue <= count_blue + 1;
        end
        else if (i_binary == 24'h222_222) begin
            count_green <= count_green + 1;
        end
        else if (i_binary == 24'h777_777) begin
            count_yellow <= count_yellow + 1;
        end
        else if (i_binary == 24'h444_444) begin
            count_purple <= count_purple + 1;
        end
        else if (i_binary == 24'h666_666) begin
            count_orange <= count_orange + 1;
        end
    end
end

/*********************比较得到最大值********************************/
wire                   [  11:0]         compare12                  ;
wire                   [  11:0]         compare34                  ;
wire                   [  11:0]         compare56                  ;
wire                   [  11:0]         compare24                  ;
wire                   [  11:0]         compareout                 ;

assign compare12 = (count_red > count_blue) ? count_red: count_blue ;
assign compare34 = (count_green > count_yellow) ? count_green: count_yellow ;
assign compare56 = (count_purple > count_orange) ? count_purple: count_orange ;
assign compare24 = (compare12 > compare34) ? compare12: compare34 ;
assign compareout = (compare24 > compare56) ? compare24: compare56 ;

assign o_color_result = o_color_result_r;
/************************根据最大值输出**************************************/
always @(posedge pixelclk or negedge reset_n) begin
    if(!reset_n) begin
        o_color_result_r <= 8'd0;
    end
    else begin
        if (frame_cnt == 3'd3) begin
            case (compareout)
                count_red:begin
                    o_color_result_r <= `red;
                end
                count_green:begin
                    o_color_result_r <= `green;
                end
                count_blue:begin
                    o_color_result_r <= `blue;
                end
                count_yellow:begin
                    o_color_result_r <= `yellow;
                end
                count_purple:begin
                    o_color_result_r <= `purple;
                end
                count_orange:begin
                    o_color_result_r <= `orange;
                end
            endcase
        end
        else begin
            o_color_result_r <= o_color_result_r;
        end
    end

end


endmodule