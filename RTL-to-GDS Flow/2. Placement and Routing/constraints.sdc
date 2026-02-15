# Clock 50 MHz (20 ns)
create_clock -name clk -period 20 [get_ports clk]


# I/O delays (demo)
set_input_delay  2.0 -clock clk [get_ports rst_n]
set_output_delay 4.0 -clock clk [get_ports {debug_pc[*] debug_acc[*] debug_dout[*]}]


# Uncertainty (đỡ lý tưởng)
set_clock_uncertainty 0.5 [get_clocks clk]
