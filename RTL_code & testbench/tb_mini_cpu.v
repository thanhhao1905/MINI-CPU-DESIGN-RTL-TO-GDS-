`timescale 1ns/1ps


module tb_mini_cpu;


    reg clk;
    reg rst_n;


    wire [7:0] debug_pc;
    wire [7:0] debug_acc;
    wire [7:0] debug_dout;


    // DUT
    mini_cpu_top dut (
        .clk(clk),
        .rst_n(rst_n),
        .debug_pc(debug_pc),
        .debug_acc(debug_acc),
        .debug_dout(debug_dout)
    );


    // Clock 50 MHz => 20 ns
    initial begin
        clk = 1'b0;
        forever #10 clk = ~clk;
    end


    // Reset + run
    initial begin
        rst_n = 1'b0;


        // dump waveform
        $dumpfile("wave.vcd");
        $dumpvars(0, tb_mini_cpu);


        #45;
        rst_n = 1'b1;   // release reset


        #2000;          // run CPU
        $finish;
    end


    // Optional: in log ra console (Verilog chuẩn)
    always @(posedge clk) begin
        if (rst_n) begin
            $display("t=%0t | PC=%h | ACC=%h | DOUT=%h",
                     $time, debug_pc, debug_acc, debug_dout);
        end
    end


endmodule
