
`timescale 1ns/1ps

module digital_block_tb();

    // Inputs
    reg clk, rst, ss, mosi, sck;
    reg sel, amux_sel;
    reg [7:0] amux_pad_en;

    // Outputs
    wire [7:0] amux_en;
    wire miso;

    // Instantiate the Unit Under Test (UUT)
    digital_block uut (
        .clk(clk),
        .rst(rst),
        .ss(ss),
        .mosi(mosi),
        .miso(miso),
        .sck(sck),
        .amux_en(amux_en),
        .sel(sel),
        .amux_sel(amux_sel),
        .amux_pad_en(amux_pad_en)
    );

    // Clock generation
    initial begin
        clk = 0;
        forever #5 clk = ~clk; // 10ns period clock
    end

    // Test sequence
    initial begin
        // Initialize Inputs
        rst = 1;
        ss = 1;
        mosi = 0;
        sck = 0;
        sel = 0;
        amux_sel = 1;
        amux_pad_en = 8'b00000000;

        // Apply Reset
        #10 rst = 1;
        #10 rst = 0;

        // SPI Byte Transmission Test
        #20 ss = 0; // Select the SPI device (Active Low)
        #10 mosi = 1; sck = 1; #10 sck = 0; // Bit 7
        #10 mosi = 0; sck = 1; #10 sck = 0; // Bit 6
        #10 mosi = 1; sck = 1; #10 sck = 0; // Bit 5
        #10 mosi = 1; sck = 1; #10 sck = 0; // Bit 4
        #10 mosi = 0; sck = 1; #10 sck = 0; // Bit 3
        #10 mosi = 1; sck = 1; #10 sck = 0; // Bit 2
        #10 mosi = 1; sck = 1; #10 sck = 0; // Bit 1
        #10 mosi = 0; sck = 1; #10 sck = 0; // Bit 0
        #10 ss = 1; // Deselect the SPI device

        // Wait and observe the output
        #100;

        // Finish simulation
        $finish;
    end

    // Monitor the outputs
    initial begin
        $monitor("Time = %0t | clk = %b | rst = %b | ss = %b | mosi = %b | miso = %b | sck = %b | sel = %b | amux_sel = %b | amux_pad_en = %b | amux_en = %b",
                 $time, clk, rst, ss, mosi, miso, sck, sel, amux_sel, amux_pad_en, amux_en);
    end

    // VCD Dump for GTKWave
    initial begin
        $dumpfile("digital_block_tb.vcd");
        $dumpvars(0, digital_block_tb);
    end

endmodule
