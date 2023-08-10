`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 27.07.2023 22:58:45
// Design Name: 
// Module Name: sub_byte
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module SubBytes(
    input [0:127] data ,
    input clk ,
    input strt,
    output reg finish_sub,
    output reg [127:0] stt_mat
    );

    reg [127:0] byteNum; 
    reg [127:0] temp;
    

    initial begin
        byteNum = 0;
        finish_sub = 1'b0;
        temp = 128'b0;
    end
    
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
