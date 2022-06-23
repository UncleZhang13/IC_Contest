module Number_counter (
    input                               pixelclk                   ,
    input                               reset_n                    ,

    input              [  11:0]         hcount_l1                  ,
    input              [  11:0]         hcount_r1                  ,
    input              [  11:0]         hcount_l2                  ,
    input              [  11:0]         hcount_r2                  ,
    input              [  11:0]         hcount_l3                  ,
    input              [  11:0]         hcount_r3                  ,
    input              [  11:0]         hcount_l4                  ,
    input              [  11:0]         hcount_r4                  ,
    input              [  11:0]         hcount_l5                  ,
    input              [  11:0]         hcount_r5                  ,
    input              [  11:0]         hcount_l6                  ,
    input              [  11:0]         hcount_r6                  ,
    input              [  11:0]         hcount_l7                  ,
    input              [  11:0]         hcount_r7                  ,
    input              [  11:0]         hcount_l8                  ,
    input              [  11:0]         hcount_r8                  ,

    output             [   7:0]         char_result_number          
);

reg                    [   7:0]         char_result_number_r       ;

    always @(posedge pixelclk or negedge reset_n) begin
        if(!reset_n) begin
            char_result_number_r <= 0;
        end
        else if ((hcount_l1 > 1024) || (hcount_r1 > 1024)) begin
            char_result_number_r <= 0;
        end
        else if ((hcount_l2 > 1024) || (hcount_r2 > 1024)) begin
            char_result_number_r <= 1;
        end
        else if ((hcount_l3 > 1024) || (hcount_r3 > 1024)) begin
            char_result_number_r <= 2;
        end
        else if ((hcount_l4 > 1024) || (hcount_r4 > 1024)) begin
            char_result_number_r <= 3;
        end
        else if ((hcount_l5 > 1024) || (hcount_r5 > 1024)) begin
            char_result_number_r <= 4;
        end
        else if ((hcount_l6 > 1024) || (hcount_r6 > 1024)) begin
            char_result_number_r <= 5;
        end
        else if ((hcount_l7 > 1024) || (hcount_r7 > 1024)) begin
            char_result_number_r <= 6;
        end
        else if ((hcount_l8 > 1024) || (hcount_r8 > 1024)) begin
            char_result_number_r <= 7;
        end
        else if ((hcount_l8 < 1024) || (hcount_r8 < 1024)) begin
            char_result_number_r <= 8;
        end
        else begin
            char_result_number_r <= 0;
        end
    end

    assign char_result_number = char_result_number_r;

endmodule