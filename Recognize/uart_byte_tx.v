/***************************************************
*    Module Name        :    uart_byte_tx
*    Engineer           :    小梅哥
*    Target Device    :    EP4CE10F17C8
*    Tool versions    :    Quartus II 13.0
*    Create Date        :    2017-3-31
*    Revision           :    v1.0
*    Description        :  串口发送模块
**************************************************/
module uart_byte_tx(
    Clk,
    Rst_n,
    send_en,
    baud_set,
    Data_Byte,

    Rs232_Tx,
    Tx_Done,
    uart_state
);

    input                               Clk                        ;
    input                               Rst_n                      ;
    input                               send_en                    ;
    input              [   2:0]         baud_set                   ;
    input              [   7:0]         Data_Byte                  ;

    output reg                          Rs232_Tx                   ;
    output reg                          Tx_Done                    ;
    output reg                          uart_state                 ;
	
reg                    [  15:0]         bps_DR                     ;//计数器计数最大值
reg                    [  15:0]         div_cnt                    ;//分频计数器变量
reg                                     bps_clk                    ;//波特率波形
reg                    [   3:0]         bps_cnt                    ;
reg                    [   7:0]         r_Data_Byte                ;
	
localparam                              START_BIT = 1'b0           ;
localparam                              STOP_BIT = 1'b1            ;
	
	//将输入的数据Data_Byt放寄存器中，防止传输过程中改变
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        r_Data_Byte <= 8'd0;
    else if(send_en)
        r_Data_Byte <= Data_Byte;
    else
        r_Data_Byte <= r_Data_Byte;
		
	//波特率查找表
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        bps_DR = 16'd5207;
    else begin
        case(baud_set)
            3'd0:bps_DR = 16'd5207;                                 //波特率9600
            3'd1:bps_DR = 16'd2603;                                 //波特率19200
            3'd2:bps_DR = 16'd1301;                                 //波特率38400
            3'd3:bps_DR = 16'd867;                                  //波特率57600
            //3'd4:bps_DR = 16'd564;  //65mhz
			//3'd4:bps_DR = 16'd346;  //60hz波特率115200
			//3'd4:bps_DR = 16'd459;  //80hz波特率115200
            //3'd4:bps_DR = 16'd206;   //80hz-256000
            3'd5:bps_DR = 16'd31;                                   //波特率1562500
            default:bps_DR = 16'd5207;
        endcase
    end
	
	//分频计数器的实现
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        div_cnt <= 16'd0;
    else if(!uart_state)
        div_cnt <= 16'd0;
    else if(div_cnt == bps_DR)
        div_cnt <= 16'd0;
    else
        div_cnt <= div_cnt + 16'b1;
		
	//波特率的产生
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        bps_clk <= 1'b0;
    else if(div_cnt == 16'b1)
        bps_clk <= 1'b1;
    else
        bps_clk <= 1'b0;
		
	//数据传输计数器bps_cnt
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        bps_cnt <= 4'd0;
    else if(bps_cnt == 4'd11)
        bps_cnt <= 4'd0;
    else if(bps_clk)
        bps_cnt <= bps_cnt + 4'd1;
    else
        bps_cnt <= bps_cnt;
		
	//一次数据传送完成输出位Tx_Done
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        Tx_Done <= 1'b0;
    else if(bps_cnt == 4'd11)
        Tx_Done <= 1'b1;
    else
        Tx_Done <= 1'b0;
		
	//数据的发送输出Rs232_Tx
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        Rs232_Tx <= 1'b1;
    else begin
        case(bps_cnt)
            4'd0:Rs232_Tx <= 1'b1;
            4'd1:Rs232_Tx <= START_BIT;
            4'd2:Rs232_Tx <= r_Data_Byte[0];
            4'd3:Rs232_Tx <= r_Data_Byte[1];
            4'd4:Rs232_Tx <= r_Data_Byte[2];
            4'd5:Rs232_Tx <= r_Data_Byte[3];
            4'd6:Rs232_Tx <= r_Data_Byte[4];
            4'd7:Rs232_Tx <= r_Data_Byte[5];
            4'd8:Rs232_Tx <= r_Data_Byte[6];
            4'd9:Rs232_Tx <= r_Data_Byte[7];
            4'd10:Rs232_Tx <= STOP_BIT;
            default:Rs232_Tx <= 1'b1;
        endcase
    end
	
	//串口状态输出uart_state
    always@(posedge Clk or negedge Rst_n)
    if(!Rst_n)
        uart_state <= 1'b0;
    else if(send_en)
        uart_state <= 1'b1;
    else if(Tx_Done)
        uart_state <= 1'b0;
    else
        uart_state <= uart_state;

endmodule