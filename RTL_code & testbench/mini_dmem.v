module mini_dmem (
    input  wire       clk,
    input  wire       we,
    input  wire [7:0] addr,
    input  wire [7:0] wdata,
    output wire [7:0] rdata
);
    reg [7:0] mem[0:255];


    assign rdata = mem[addr];


    always @(posedge clk) begin
        if (we)
            mem[addr] <= wdata;
    end
endmodule
