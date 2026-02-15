module mini_imem (
    input  wire [7:0] addr,
    output reg  [15:0] data
);
    always @(*) begin
        case (addr)
            8'h00: data = {4'h1,2'd0,2'd0,8'h05}; // LDI R0,5
            8'h01: data = {4'h1,2'd1,2'd0,8'h03}; // LDI R1,3
            8'h02: data = {4'h2,2'd0,2'd1,8'h00}; // ADD
            8'h03: data = {4'h6,2'd0,2'd0,8'h10}; // ST
            8'h04: data = {4'h5,2'd2,2'd0,8'h10}; // LD
            8'h05: data = {4'h4,2'd2,2'd1,8'h00}; // XOR
            8'h06: data = {4'h7,2'd0,2'd0,8'h02}; // JMP
            default: data = 16'h0000;
        endcase
    end
endmodule
