module mini_regfile (
    input  wire       clk,
    input  wire       rst_n,
    input  wire [1:0] raddr0,
    input  wire [1:0] raddr1,
    output reg  [7:0] rdata0,
    output reg  [7:0] rdata1,
    input  wire       we,
    input  wire [1:0] waddr,
    input  wire [7:0] wdata
);


    reg [7:0] r0, r1, r2, r3;


    /* ===== READ (combinational) ===== */
    always @(*) begin
        case (raddr0)
            2'd0: rdata0 = r0;
            2'd1: rdata0 = r1;
            2'd2: rdata0 = r2;
            2'd3: rdata0 = r3;
            default: rdata0 = 8'd0;
        endcase


        case (raddr1)
            2'd0: rdata1 = r0;
            2'd1: rdata1 = r1;
            2'd2: rdata1 = r2;
            2'd3: rdata1 = r3;
            default: rdata1 = 8'd0;
        endcase
    end


    /* ===== WRITE (sequential) ===== */
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            r0 <= 8'd0;
            r1 <= 8'd0;
            r2 <= 8'd0;
            r3 <= 8'd0;
        end else if (we) begin
            case (waddr)
                2'd0: r0 <= wdata;
                2'd1: r1 <= wdata;
                2'd2: r2 <= wdata;
                2'd3: r3 <= wdata;
            endcase
        end
    end


endmodule
