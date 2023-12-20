`timescale 1ns / 1ps


module SubBytes(
    input [0:127] data ,
    input clk ,
    input strt,
    output reg finish_sub,
    output reg [127:0] stt_mat
    );

    reg [127:0] byteNum; 
    reg [127:0] temp;
    
    always @(posedge clk) begin
        
        if (strt) begin
    
            if(byteNum == 128) begin
                finish_sub = 1'b1;
            end
            else begin
                temp [byteNum +: 8] = data [byteNum +: 8];
                byteNum = byteNum + 8;
            end
        end
        else begin
            temp = 128'b0;
            byteNum = 0;
            finish_sub = 0;
        end
    end


    SBox SBox (
        .addr(temp [byteNum +: 8]),
        .dout(stt_mat [byteNum +: 8])
    );
endmodule
