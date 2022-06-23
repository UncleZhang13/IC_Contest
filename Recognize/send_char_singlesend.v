
`define TAIL  8'h0a
`define HEAD  8'h0a

module send_char(
    input                               pixelclk                   ,
    input                               reset_n                    ,
    input              [   2:0]         vpframe_cnt                ,
    input                               i_vsync                    ,

    input              [   7:0]         char_result_fruit1         ,
    input              [   7:0]         char_result_fruit2         ,
    input              [   7:0]         char_result_fruit3         ,
    input              [   7:0]         char_result_fruit4         ,
    input              [   7:0]         char_result_fruit5         ,
    input              [   7:0]         char_result_fruit6         ,
    input              [   7:0]         char_result_fruit7         ,
    input              [   7:0]         char_result_fruit8         ,
	  
    input              [   7:0]         char_result_colour1        ,
    input              [   7:0]         char_result_colour2        ,
    input              [   7:0]         char_result_colour3        ,
    input              [   7:0]         char_result_colour4        ,
    input              [   7:0]         char_result_colour5        ,
    input              [   7:0]         char_result_colour6        ,
    input              [   7:0]         char_result_colour7        ,
    input              [   7:0]         char_result_colour8        ,

    input              [   7:0]         char_result_number         ,

    output                              Rs232_Tx                    
       );

reg                                     send_en                    ;
reg                    [   7:0]         Data_Byte                  ;
wire                                    Tx_Done                    ;
wire                                    uart_state                 ;
reg                                     i_vsync_r                  ;
wire                                    i_vsync_pos                ;
wire                                    zero_flag                  ;

reg                    [   7:0]         char_result_fruit1_r       ;
reg                    [   7:0]         char_result_fruit2_r       ;
reg                    [   7:0]         char_result_fruit3_r       ;
reg                    [   7:0]         char_result_fruit4_r       ;
reg                    [   7:0]         char_result_fruit5_r       ;
reg                    [   7:0]         char_result_fruit6_r       ;
reg                    [   7:0]         char_result_fruit7_r       ;
reg                    [   7:0]         char_result_fruit8_r       ;

reg                    [   7:0]         char_result_colour1_r      ;
reg                    [   7:0]         char_result_colour2_r      ;
reg                    [   7:0]         char_result_colour3_r      ;
reg                    [   7:0]         char_result_colour4_r      ;
reg                    [   7:0]         char_result_colour5_r      ;
reg                    [   7:0]         char_result_colour6_r      ;
reg                    [   7:0]         char_result_colour7_r      ;
reg                    [   7:0]         char_result_colour8_r      ;

reg                    [   7:0]         char_result_number_r       ;
       
reg                    [   7:0]         cnt                        ;
reg                    [   7:0]         char_check                 ;
reg                    [   7:0]         char_check1                ;
reg                    [   7:0]         char_check2                ;
wire                                    send_flag                  ;


assign     send_flag = (char_check == char_check1 && char_check != char_check2)?1'b1:1'b0;
assign i_vsync_pos = (i_vsync &(!i_vsync_r));
always @(posedge pixelclk)begin
  i_vsync_r <= i_vsync;
end


always @(posedge pixelclk or negedge reset_n) begin
  if(reset_n == 1'b0)begin
    char_result_fruit1_r<= 8'h00;
    char_result_fruit2_r<= 8'h00;
    char_result_fruit3_r<= 8'h00;
    char_result_fruit4_r<= 8'h00;
    char_result_fruit5_r<= 8'h00;
    char_result_fruit6_r<= 8'h00;
    char_result_fruit7_r<= 8'h00;
    char_result_fruit8_r<= 8'h00;
    char_result_colour1_r<= 8'h00;
    char_result_colour2_r<= 8'h00;
    char_result_colour3_r<= 8'h00;
    char_result_colour4_r<= 8'h00;
    char_result_colour5_r<= 8'h00;
    char_result_colour6_r<= 8'h00;
    char_result_colour7_r<= 8'h00;
    char_result_colour8_r<= 8'h00;
    char_result_number_r<= 8'h00;
  end
  else if(vpframe_cnt == 3'd3 ) begin
    char_result_fruit1_r<= char_result_fruit1;
    char_result_fruit2_r<= char_result_fruit2;
    char_result_fruit3_r<= char_result_fruit3;
    char_result_fruit4_r<= char_result_fruit4;
    char_result_fruit5_r<= char_result_fruit5;
    char_result_fruit6_r<= char_result_fruit6;
    char_result_fruit7_r<= char_result_fruit7;
    char_result_fruit8_r<= char_result_fruit8;
    char_result_colour1_r<= char_result_colour1;
    char_result_colour2_r<= char_result_colour2;
    char_result_colour3_r<= char_result_colour3;
    char_result_colour4_r<= char_result_colour4;
    char_result_colour5_r<= char_result_colour5;
    char_result_colour6_r<= char_result_colour6;
    char_result_colour7_r<= char_result_colour7;
    char_result_colour8_r<= char_result_colour8;
    char_result_number_r<= char_result_number;
  
  end
end

always @(posedge pixelclk or negedge reset_n) begin
  if(reset_n == 1'b0)begin
    char_check <= 0;
    char_check1 <= 0;
    char_check2 <= 0;
  end
  else if(vpframe_cnt == 3'd3 && i_vsync_pos == 1'b1)begin
    char_check2 <= char_check1;
    char_check1 <= char_check;
    char_check <= char_result_fruit1 || char_result_fruit2 || char_result_fruit3 || char_result_fruit4 || char_result_fruit5 || char_result_fruit6 || char_result_fruit7 || char_result_fruit8
                  &char_result_colour1 || char_result_colour2 || char_result_colour3 || char_result_colour4 || char_result_colour5&char_result_colour6 || char_result_colour7 || char_result_colour8;//有一个水果即可
  end
end

always @(posedge pixelclk or negedge reset_n) begin
  if(reset_n == 1'b0)begin
    cnt <= 8'd0;
  end
  else if(cnt==17 ) begin
    cnt <= 8'd0;
  end
  else if(send_en == 1'b1) begin
    cnt <= cnt + 8'd1;
  end
end

always @(posedge pixelclk or negedge reset_n) begin
  if(reset_n == 1'b0)begin
    send_en <= 1'b0;
    Data_Byte <= 8'b00000000;
  end
  else if(vpframe_cnt == 3'd0 && i_vsync_pos == 1'b1 && send_flag == 1'b1 ) begin
    send_en <= 1'b1;
    Data_Byte <= `HEAD;
  end
  else if(Tx_Done == 1'b1 && cnt < 17) begin
    case(cnt)
      8'd1:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit1_r;
      end
      8'd2:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit2_r;
      end
      8'd3:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit3_r;
      end
      8'd4:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit4_r;
      end
      8'd5:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit5_r;
      end
      8'd6:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit6_r;
      end
      8'd7:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit7_r;
      end
      8'd8:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_fruit8_r;
      end
      8'd9:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour1_r;
      end
      8'd10:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour2_r;
      end
      8'd11:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour3_r;
      end
      8'd12:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour4_r;
      end
      8'd13:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour5_r;
      end
      8'd14:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour6_r;
      end
      8'd15:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour7_r;
      end
      8'd16:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_colour8_r;
      end
      8'd17:begin
          send_en <= 1'b1;
          Data_Byte <= char_result_number_r;
      end
      default:begin
          send_en <= 1'b0;
          Data_Byte <= 8'b00000000;
      end
    endcase
  end
  else begin
    send_en <= 1'b0;
    Data_Byte <= Data_Byte;
  end
end


uart_byte_tx U_uart_byte_tx(
    .Clk                               (pixelclk                  ),
    .Rst_n                             (reset_n                   ),
    .send_en                           (send_en                   ),
    .baud_set                          (3'd4                      ),
    .Data_Byte                         (Data_Byte                 ),
    
    .Rs232_Tx                          (Rs232_Tx                  ),
    .Tx_Done                           (Tx_Done                   ),
    .uart_state                        (uart_state                ) 
);

endmodule