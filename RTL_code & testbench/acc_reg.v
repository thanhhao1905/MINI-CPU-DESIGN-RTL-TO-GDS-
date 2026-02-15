module acc_reg (
    input  wire clk,
    input  wire rst_n,
    input  wire we,
    input  wire [7:0] d,
    output reg  [7:0] q
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            q <= 8'd0;
        else if (we)
            q <= d;
    end
endmodule
