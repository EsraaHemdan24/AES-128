module MixColumns(
    input finish_shift ,
    input clk ,
    input [127:0] shift_mat ,
    output reg finish_mix ,
    output reg [127:0] mix_mat 
    
);

reg [31:0] in0;
reg [31:0] in1;
reg [31:0] in2;
reg [31:0] in3;
reg [127:0] byteNum;
reg [127:0] rowNum;

always @(posedge clk) begin

    if (finish_shift) begin
        if (byteNum == 32) begin
            finish_mix = 1'b1;
        end
        else begin
            case (rowNum)
            0: begin
                if ({shift_mat[byteNum+7],shift_mat[byteNum+39]} == 2'b00) begin
                    in0 [byteNum +: 8] = (shift_mat[byteNum +: 8] <<1)^((shift_mat[byteNum+32 +: 8] <<1)^shift_mat[byteNum+32 +: 8])^shift_mat[byteNum+64 +: 8]^shift_mat[byteNum+96 +: 8];
                end
                else if ({shift_mat[byteNum+7],shift_mat[byteNum+39]} == 2'b11) begin
                    in0 [byteNum +: 8] = (shift_mat[byteNum +: 8] <<1)^((shift_mat[byteNum+32 +: 8] <<1)^shift_mat[byteNum+32 +: 8])^shift_mat[byteNum+64 +: 8]^shift_mat[byteNum+96 +: 8]^8'b00011011^8'b00011011;
                end
                else begin
                    in0 [byteNum +: 8] = (shift_mat[byteNum +: 8] <<1)^((shift_mat[byteNum+32 +: 8] <<1)^shift_mat[byteNum+32 +: 8])^shift_mat[byteNum+64 +: 8]^shift_mat[byteNum+96 +: 8]^8'b00011011;
                end
              
                rowNum = 1;
            end
            1: begin
                if ({shift_mat[byteNum+71],shift_mat[byteNum+39]} == 2'b00) begin
                    in1 [byteNum +: 8] = shift_mat[byteNum +: 8]^(shift_mat[byteNum+32 +: 8] <<1)^((shift_mat[byteNum+64 +: 8] <<1)^shift_mat[byteNum+64 +: 8])^shift_mat[byteNum+96 +: 8];
                end
                else if ({shift_mat[byteNum+71],shift_mat[byteNum+39]} == 2'b11) begin
                    in1 [byteNum +: 8] = shift_mat[byteNum +: 8]^(shift_mat[byteNum+32 +: 8] <<1)^((shift_mat[byteNum+64 +: 8] <<1)^shift_mat[byteNum+64 +: 8])^shift_mat[byteNum+96 +: 8]^8'b00011011^8'b00011011;
                end
                else begin
                    in1 [byteNum +: 8] = shift_mat[byteNum +: 8]^(shift_mat[byteNum+32 +: 8] <<1)^((shift_mat[byteNum+64 +: 8] <<1)^shift_mat[byteNum+64 +: 8])^shift_mat[byteNum+96 +: 8]^8'b00011011;
                end

                rowNum = 2;
            end
            2: begin
                if ({shift_mat[byteNum+71],shift_mat[byteNum+103]} == 2'b00) begin
                    in2 [byteNum +: 8] = shift_mat[byteNum +: 8]^shift_mat[byteNum+32 +: 8]^(shift_mat[byteNum+64 +: 8] <<1)^((shift_mat[byteNum+96 +: 8] <<1)^shift_mat[byteNum+96 +: 8]);
                end
                else if ({shift_mat[byteNum+71],shift_mat[byteNum+103]} == 2'b11) begin
                    in2 [byteNum +: 8] = shift_mat[byteNum +: 8]^shift_mat[byteNum+32 +: 8]^(shift_mat[byteNum+64 +: 8] <<1)^((shift_mat[byteNum+96 +: 8] <<1)^shift_mat[byteNum+96 +: 8])^8'b00011011^8'b00011011;
                end
                else begin
                    in2 [byteNum +: 8] = shift_mat[byteNum +: 8]^shift_mat[byteNum+32 +: 8]^(shift_mat[byteNum+64 +: 8] <<1)^((shift_mat[byteNum+96 +: 8] <<1)^shift_mat[byteNum+96 +: 8])^8'b00011011;
                end

                rowNum = 3;
            end
            3: begin
                if ({shift_mat[byteNum+7],shift_mat[byteNum+103]} == 2'b00) begin
                    in3 [byteNum +: 8] = ((shift_mat[byteNum +: 8] <<1)^shift_mat[byteNum+32 +: 8])^shift_mat[byteNum+32 +: 8]^shift_mat[byteNum+64 +: 8]^(shift_mat[byteNum+96 +: 8]<< 1);
                end
                else if ({shift_mat[byteNum+7],shift_mat[byteNum+103]} == 2'b11) begin
                    in3 [byteNum +: 8] = ((shift_mat[byteNum +: 8] <<1)^shift_mat[byteNum+32 +: 8])^shift_mat[byteNum+32 +: 8]^shift_mat[byteNum+64 +: 8]^(shift_mat[byteNum+96 +: 8]<< 1)^8'b00011011^8'b00011011;
                end
                else begin
                    in3 [byteNum +: 8] = ((shift_mat[byteNum +: 8] <<1)^shift_mat[byteNum+32 +: 8])^shift_mat[byteNum+32 +: 8]^shift_mat[byteNum+64 +: 8]^(shift_mat[byteNum+96 +: 8]<< 1)^8'b00011011;
                end

                rowNum = 0;
                byteNum = byteNum + 8;
            end
            default: begin
                rowNum = 0;
                byteNum = 0;
            end
        endcase

        end

        mix_mat = {in3,in2,in1,in0};
        
    end
    else begin
        byteNum = 0;
        rowNum = 0;
        finish_mix = 1'b0;
        in0 = 32'b0;
        in1 = 32'b0;
        in2 = 32'b0;
        in3 = 32'b0;
    end
end

endmodule
