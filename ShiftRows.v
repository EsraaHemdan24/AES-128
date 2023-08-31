module ShiftRows(
    input finish_sub,
    input clk,
    input [127:0] stt_mat ,
    output reg finish_shift ,
    output reg [127:0] shift_mat
    );
    reg [127:0] in;

    always @(posedge clk ) begin
        if (finish_sub & (!finish_shift) ) begin
            in [31:0] = stt_mat [31:0];
            in [63:32] = {stt_mat [39:32],stt_mat [63:40]};
            in [95:64] = {stt_mat [79:64],stt_mat [95:80]};
            in [127:96] = {stt_mat [119:96],stt_mat [127:120]};
            finish_shift = 1'b1;
        end
        else begin
            shift_mat = in;
        end

        shift_mat = in;
    end


endmodule
