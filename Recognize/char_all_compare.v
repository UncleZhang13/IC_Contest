`include "para.v"

module char_all_compare(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input              [   2:0]         i_frame_cnt                ,//1230
    input                               i_vsync_pos                ,
    input              [  39:0]         i_char1                    ,
    output reg         [   7:0]         o_char_result1              
);

wire                   [  39:0]         char_pitahaya_wire         ;
wire                   [  39:0]         char_orgenge_wire          ;
wire                   [  39:0]         char_mango_wire            ;
wire                   [  39:0]         char_apple_wire            ;
wire                   [  39:0]         char_grape_wire            ;
wire                   [  39:0]         char_banana_wire           ;
wire                   [  39:0]         char_pear_wire             ;
wire                   [  39:0]         char_kiwi_wire             ;


reg                    [   5:0]         point_pitahaya             ;
reg                    [   5:0]         point_orgenge              ;
reg                    [   5:0]         point_mango                ;
reg                    [   5:0]         point_apple                ;
reg                    [   5:0]         point_grape                ;
reg                    [   5:0]         point_banana               ;
reg                    [   5:0]         point_pear                 ;
reg                    [   5:0]         point_kiwi                 ;



assign  char_pitahaya_wire  = i_char1 ^ `Temp_pitahaya;
assign  char_orgenge_wire  = i_char1 ^ `Temp_orgenge;
assign  char_mango_wire  = i_char1 ^ `Temp_mango;
assign  char_apple_wire  = i_char1 ^ `Temp_apple;
assign  char_grape_wire = i_char1 ^ `Temp_grape;
assign  char_banana_wire  = i_char1 ^ `Temp_banana;
assign  char_pear_wire  = i_char1 ^ `Temp_pear;
assign  char_kiwi_wire  = i_char1 ^ `Temp_kiwi;


always @(char_pitahaya_wire) begin
    point_pitahaya = char_pitahaya_wire[ 0] + char_pitahaya_wire[ 1] + char_pitahaya_wire[ 2] + char_pitahaya_wire[ 3] + char_pitahaya_wire[ 4] +
              char_pitahaya_wire[ 5] + char_pitahaya_wire[ 6] + char_pitahaya_wire[ 7] + char_pitahaya_wire[ 8] + char_pitahaya_wire[ 9] +
              char_pitahaya_wire[10] + char_pitahaya_wire[11] + char_pitahaya_wire[12] + char_pitahaya_wire[13] + char_pitahaya_wire[14] +
              char_pitahaya_wire[15] + char_pitahaya_wire[16] + char_pitahaya_wire[17] + char_pitahaya_wire[18] + char_pitahaya_wire[19] +
              char_pitahaya_wire[20] + char_pitahaya_wire[21] + char_pitahaya_wire[22] + char_pitahaya_wire[23] + char_pitahaya_wire[24] +
              char_pitahaya_wire[25] + char_pitahaya_wire[26] + char_pitahaya_wire[27] + char_pitahaya_wire[28] + char_pitahaya_wire[29] +
              char_pitahaya_wire[30] + char_pitahaya_wire[31] + char_pitahaya_wire[32] + char_pitahaya_wire[33] + char_pitahaya_wire[34] +
              char_pitahaya_wire[35] + char_pitahaya_wire[36] + char_pitahaya_wire[37] + char_pitahaya_wire[38] + char_pitahaya_wire[39];
end

always @(char_orgenge_wire) begin
    point_orgenge = char_orgenge_wire[ 0] + char_orgenge_wire[ 1] + char_orgenge_wire[ 2] + char_orgenge_wire[ 3] + char_orgenge_wire[ 4] +
              char_orgenge_wire[ 5] + char_orgenge_wire[ 6] + char_orgenge_wire[ 7] + char_orgenge_wire[ 8] + char_orgenge_wire[ 9] +
              char_orgenge_wire[10] + char_orgenge_wire[11] + char_orgenge_wire[12] + char_orgenge_wire[13] + char_orgenge_wire[14] +
              char_orgenge_wire[15] + char_orgenge_wire[16] + char_orgenge_wire[17] + char_orgenge_wire[18] + char_orgenge_wire[19] +
              char_orgenge_wire[20] + char_orgenge_wire[21] + char_orgenge_wire[22] + char_orgenge_wire[23] + char_orgenge_wire[24] +
              char_orgenge_wire[25] + char_orgenge_wire[26] + char_orgenge_wire[27] + char_orgenge_wire[28] + char_orgenge_wire[29] +
              char_orgenge_wire[30] + char_orgenge_wire[31] + char_orgenge_wire[32] + char_orgenge_wire[33] + char_orgenge_wire[34] +
              char_orgenge_wire[35] + char_orgenge_wire[36] + char_orgenge_wire[37] + char_orgenge_wire[38] + char_orgenge_wire[39];
end

always @(char_mango_wire) begin
    point_mango = char_mango_wire[ 0] + char_mango_wire[ 1] + char_mango_wire[ 2] + char_mango_wire[ 3] + char_mango_wire[ 4] +
              char_mango_wire[ 5] + char_mango_wire[ 6] + char_mango_wire[ 7] + char_mango_wire[ 8] + char_mango_wire[ 9] +
              char_mango_wire[10] + char_mango_wire[11] + char_mango_wire[12] + char_mango_wire[13] + char_mango_wire[14] +
              char_mango_wire[15] + char_mango_wire[16] + char_mango_wire[17] + char_mango_wire[18] + char_mango_wire[19] +
              char_mango_wire[20] + char_mango_wire[21] + char_mango_wire[22] + char_mango_wire[23] + char_mango_wire[24] +
              char_mango_wire[25] + char_mango_wire[26] + char_mango_wire[27] + char_mango_wire[28] + char_mango_wire[29] +
              char_mango_wire[30] + char_mango_wire[31] + char_mango_wire[32] + char_mango_wire[33] + char_mango_wire[34] +
              char_mango_wire[35] + char_mango_wire[36] + char_mango_wire[37] + char_mango_wire[38] + char_mango_wire[39];
end

always @(char_apple_wire) begin
    point_apple = char_apple_wire[ 0] + char_apple_wire[ 1] + char_apple_wire[ 2] + char_apple_wire[ 3] + char_apple_wire[ 4] +
              char_apple_wire[ 5] + char_apple_wire[ 6] + char_apple_wire[ 7] + char_apple_wire[ 8] + char_apple_wire[ 9] +
              char_apple_wire[10] + char_apple_wire[11] + char_apple_wire[12] + char_apple_wire[13] + char_apple_wire[14] +
              char_apple_wire[15] + char_apple_wire[16] + char_apple_wire[17] + char_apple_wire[18] + char_apple_wire[19] +
              char_apple_wire[20] + char_apple_wire[21] + char_apple_wire[22] + char_apple_wire[23] + char_apple_wire[24] +
              char_apple_wire[25] + char_apple_wire[26] + char_apple_wire[27] + char_apple_wire[28] + char_apple_wire[29] +
              char_apple_wire[30] + char_apple_wire[31] + char_apple_wire[32] + char_apple_wire[33] + char_apple_wire[34] +
              char_apple_wire[35] + char_apple_wire[36] + char_apple_wire[37] + char_apple_wire[38] + char_apple_wire[39];
end

always @(char_grape_wire) begin
    point_grape = char_grape_wire[ 0] + char_grape_wire[ 1] + char_grape_wire[ 2] + char_grape_wire[ 3] + char_grape_wire[ 4] +
               char_grape_wire[ 5] + char_grape_wire[ 6] + char_grape_wire[ 7] + char_grape_wire[ 8] + char_grape_wire[ 9] +
               char_grape_wire[10] + char_grape_wire[11] + char_grape_wire[12] + char_grape_wire[13] + char_grape_wire[14] +
               char_grape_wire[15] + char_grape_wire[16] + char_grape_wire[17] + char_grape_wire[18] + char_grape_wire[19] +
               char_grape_wire[20] + char_grape_wire[21] + char_grape_wire[22] + char_grape_wire[23] + char_grape_wire[24] +
               char_grape_wire[25] + char_grape_wire[26] + char_grape_wire[27] + char_grape_wire[28] + char_grape_wire[29] +
               char_grape_wire[30] + char_grape_wire[31] + char_grape_wire[32] + char_grape_wire[33] + char_grape_wire[34] +
               char_grape_wire[35] + char_grape_wire[36] + char_grape_wire[37] + char_grape_wire[38] + char_grape_wire[39];
end

always @(char_banana_wire) begin
    point_banana= char_banana_wire[ 0] + char_banana_wire[ 1] + char_banana_wire[ 2] + char_banana_wire[ 3] + char_banana_wire[ 4] +
              char_banana_wire[ 5] + char_banana_wire[ 6] + char_banana_wire[ 7] + char_banana_wire[ 8] + char_banana_wire[ 9] +
              char_banana_wire[10] + char_banana_wire[11] + char_banana_wire[12] + char_banana_wire[13] + char_banana_wire[14] +
              char_banana_wire[15] + char_banana_wire[16] + char_banana_wire[17] + char_banana_wire[18] + char_banana_wire[19] +
              char_banana_wire[20] + char_banana_wire[21] + char_banana_wire[22] + char_banana_wire[23] + char_banana_wire[24] +
              char_banana_wire[25] + char_banana_wire[26] + char_banana_wire[27] + char_banana_wire[28] + char_banana_wire[29] +
              char_banana_wire[30] + char_banana_wire[31] + char_banana_wire[32] + char_banana_wire[33] + char_banana_wire[34] +
              char_banana_wire[35] + char_banana_wire[36] + char_banana_wire[37] + char_banana_wire[38] + char_banana_wire[39];
end

always @(char_pear_wire) begin
    point_pear = char_pear_wire[ 0] + char_pear_wire[ 1] + char_pear_wire[ 2] + char_pear_wire[ 3] + char_pear_wire[ 4] +
              char_pear_wire[ 5] + char_pear_wire[ 6] + char_pear_wire[ 7] + char_pear_wire[ 8] + char_pear_wire[ 9] +
              char_pear_wire[10] + char_pear_wire[11] + char_pear_wire[12] + char_pear_wire[13] + char_pear_wire[14] +
              char_pear_wire[15] + char_pear_wire[16] + char_pear_wire[17] + char_pear_wire[18] + char_pear_wire[19] +
              char_pear_wire[20] + char_pear_wire[21] + char_pear_wire[22] + char_pear_wire[23] + char_pear_wire[24] +
              char_pear_wire[25] + char_pear_wire[26] + char_pear_wire[27] + char_pear_wire[28] + char_pear_wire[29] +
              char_pear_wire[30] + char_pear_wire[31] + char_pear_wire[32] + char_pear_wire[33] + char_pear_wire[34] +
              char_pear_wire[35] + char_pear_wire[36] + char_pear_wire[37] + char_pear_wire[38] + char_pear_wire[39];
end

always @(char_kiwi_wire) begin
    point_kiwi = char_kiwi_wire[ 0] + char_kiwi_wire[ 1] + char_kiwi_wire[ 2] + char_kiwi_wire[ 3] + char_kiwi_wire[ 4] +
              char_kiwi_wire[ 5] + char_kiwi_wire[ 6] + char_kiwi_wire[ 7] + char_kiwi_wire[ 8] + char_kiwi_wire[ 9] +
              char_kiwi_wire[10] + char_kiwi_wire[11] + char_kiwi_wire[12] + char_kiwi_wire[13] + char_kiwi_wire[14] +
              char_kiwi_wire[15] + char_kiwi_wire[16] + char_kiwi_wire[17] + char_kiwi_wire[18] + char_kiwi_wire[19] +
              char_kiwi_wire[20] + char_kiwi_wire[21] + char_kiwi_wire[22] + char_kiwi_wire[23] + char_kiwi_wire[24] +
              char_kiwi_wire[25] + char_kiwi_wire[26] + char_kiwi_wire[27] + char_kiwi_wire[28] + char_kiwi_wire[29] +
              char_kiwi_wire[30] + char_kiwi_wire[31] + char_kiwi_wire[32] + char_kiwi_wire[33] + char_kiwi_wire[34] +
              char_kiwi_wire[35] + char_kiwi_wire[36] + char_kiwi_wire[37] + char_kiwi_wire[38] + char_kiwi_wire[39];
end



wire                   [   5:0]         compare11                  ;
wire                   [   5:0]         compare12                  ;
wire                   [   5:0]         compare13                  ;
wire                   [   5:0]         compare14                  ;


wire                   [   5:0]         compare21                  ;
wire                   [   5:0]         compare22                  ;


wire                   [   5:0]         compareout                 ;

assign compare11  = (point_pitahaya < point_orgenge) ? point_pitahaya : point_orgenge;
assign compare12  = (point_mango < point_apple) ? point_mango : point_apple;
assign compare13  = (point_grape< point_banana) ? point_grape: point_banana;
assign compare14  = (point_pear < point_kiwi) ? point_pear : point_kiwi;


assign compare21  = (compare11 < compare12) ? compare11 : compare12;
assign compare22  = (compare13 < compare14) ? compare13 : compare14;

               
assign compareout = (compare21 < compare22) ? compare21 : compare22;

always @(posedge pixelclk or negedge reset_n) begin
    if(!reset_n) begin
        o_char_result1 <= 8'd0;
    end
    else begin
        if (i_frame_cnt == 3'd3) begin
            case (compareout)
                point_pitahaya: begin
                    o_char_result1 <= `pitahaya;
                end
                point_orgenge: begin
                    o_char_result1 <= `orgenge;
                end
                point_mango: begin
                    o_char_result1 <= `mango;
                end
                point_apple: begin
                    o_char_result1 <= `apple;
                end
                point_grape: begin
                    o_char_result1 <= `grape;
                end
                point_banana: begin
                    o_char_result1 <= `banana;
                end
                point_pear: begin
                    o_char_result1 <= `pear;
                end
                point_kiwi: begin
                    o_char_result1 <= `kiwi;
                end
				
                default : begin
                    o_char_result1 <= 8'd0;
                end
            endcase
        end
        else begin
            o_char_result1 <= o_char_result1;
        end
    end
end

endmodule