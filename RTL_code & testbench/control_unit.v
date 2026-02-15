module control_unit (
    input  wire [3:0] opcode,
    output reg        rf_we,
    output reg  [2:0] alu_op,
    output reg        dmem_we,
    output reg        acc_we,
    output reg        pc_sel
);


    always @(*) begin
        // defaults
        rf_we   = 1'b0;
        dmem_we = 1'b0;
        acc_we  = 1'b0;
        pc_sel  = 1'b0;
        alu_op  = 3'd0;


        case (opcode)
            4'h1: begin
                rf_we = 1'b1;          // LDI
            end


            4'h2: begin
                alu_op = 3'd0;         // ADD
                acc_we = 1'b1;
            end


            4'h3: begin
                alu_op = 3'd1;         // SUB
                acc_we = 1'b1;
            end


            4'h4: begin
                alu_op = 3'd4;         // XOR
                acc_we = 1'b1;
            end


            4'h5: begin
                rf_we = 1'b1;          // LD
            end


            4'h6: begin
                dmem_we = 1'b1;        // ST
            end


            4'h7: begin
                pc_sel = 1'b1;         // JMP
            end
        endcase
    end


endmodule
