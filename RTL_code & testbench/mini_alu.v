module mini_alu (
    input  wire [2:0] op,
    input  wire [7:0] a,
    input  wire [7:0] b,
    output reg  [7:0] y
);
    always @(*) begin
        case (op)
            3'd0: y = a + b;
            3'd1: y = a - b;
            3'd4: y = a ^ b;
            default: y = 8'd0;
        endcase
    end
endmodule
