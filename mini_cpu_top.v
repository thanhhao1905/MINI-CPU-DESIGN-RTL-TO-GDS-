module mini_cpu_top (
    input  wire clk,
    input  wire rst_n,
    output wire [7:0] debug_pc,
    output wire [7:0] debug_acc,
    output wire [7:0] debug_dout
);


    /* ========= Wires ========= */
    wire [7:0] pc, pc_next;
    wire [15:0] instr;


    wire [3:0] opcode;
    wire [1:0] rd, rs;
    wire [7:0] imm;


    wire        rf_we;
    wire [1:0]  rf_waddr;
    wire [7:0]  rf_wdata;
    wire [7:0]  rdata0, rdata1;


    wire [2:0]  alu_op;
    wire [7:0]  alu_y;


    wire        dmem_we;
    wire        acc_we;
    wire        pc_sel;
    wire [7:0]  dmem_rdata;


    /* ========= PC ========= */
    pc_unit u_pc (
        .clk(clk),
        .rst_n(rst_n),
        .next_pc(pc_next),
        .pc(pc)
    );


    assign debug_pc = pc;


    /* ========= IMEM ========= */
    mini_imem u_imem (
        .addr(pc),
        .data(instr)
    );


    /* ========= Decode ========= */
    assign opcode = instr[15:12];
    assign rd     = instr[11:10];
    assign rs     = instr[9:8];
    assign imm    = instr[7:0];


    /* ========= Control ========= */
    control_unit u_ctrl (
        .opcode(opcode),
        .rf_we(rf_we),
        .alu_op(alu_op),
        .dmem_we(dmem_we),
        .acc_we(acc_we),
        .pc_sel(pc_sel)
    );


    /* ========= Regfile ========= */
    assign rf_waddr = rd;   // đích ghi lấy trực tiếp từ instruction


    mini_regfile u_rf (
        .clk(clk),
        .rst_n(rst_n),
        .raddr0(rd),
        .raddr1(rs),
        .rdata0(rdata0),
        .rdata1(rdata1),
        .we(rf_we),
        .waddr(rf_waddr),
        .wdata(rf_wdata)
    );


    /* ========= ALU ========= */
    mini_alu u_alu (
        .op(alu_op),
        .a(rdata0),
        .b(rdata1),
        .y(alu_y)
    );


    /* ========= ACC ========= */
    acc_reg u_acc (
        .clk(clk),
        .rst_n(rst_n),
        .we(acc_we),
        .d(alu_y),
        .q(debug_acc)
    );


    /* ========= DMEM ========= */
    mini_dmem u_dmem (
        .clk(clk),
        .we(dmem_we),
        .addr(imm),
        .wdata(rdata0),
        .rdata(dmem_rdata)
    );


    /* ========= Write-back ========= */
    // LDI -> ghi immediate
    // LD  -> ghi dữ liệu từ RAM
    assign rf_wdata = (opcode == 4'h1) ? imm : dmem_rdata;


    /* ========= Debug DOUT Unit ========= */
    debug_dout_unit u_debug_dout (
        .clk(clk),
        .rst_n(rst_n),
        .opcode(opcode),
        .rdata0(rdata0),
        .dmem_rdata(dmem_rdata),
        .debug_dout(debug_dout)
    );


    /* ========= Next PC ========= */
    assign pc_next = (pc_sel) ? imm : pc + 8'd1;


endmodule
