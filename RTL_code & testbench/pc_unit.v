module pc_unit (
    input  wire clk,
    input  wire rst_n,
    input  wire [7:0] next_pc,
    output reg  [7:0] pc
);
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            pc <= 8'd0;
        else
            pc <= next_pc;
    end
endmodule
