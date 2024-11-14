module ser_neuron_grid_tb();

integer data_file, i, code;
reg line;

reg clk, rst, ss, done_iw;
reg [7:0] dout_iw, dout_iw_prev;
wire [7:0] dout;

`define NULL 0    

ser_neuron_grid DUT(
    .clk(clk),
    .rst(rst),
    .ss(ss),
    .done_iw(done_iw),
    .dout_iw(dout_iw),
    .dout(dout)
);

always #5 clk = ~clk;

initial begin
    $dumpfile("designs/results/ser_neuron_grid/ser_neuron_grid.vcd");
    $dumpvars();

    data_file = $fopen("designs/testbench/ser_neuron_grid/grid_data.txt", "r");
    if (data_file == `NULL) begin
        $display("data_file handle was NULL");
        $finish;
    end

    clk = 0;
    rst = 1;
    ss = 1;
    done_iw = 0;
    dout_iw = 0;
    dout_iw_prev = 0;

    #100
    rst = 0;

    #100
    while (!$feof(data_file)) begin
        dout_iw_prev = dout_iw;
        #10 ss = 0;
        #20 ss = 1;
        #10 code = $fscanf(data_file, "%d\n", dout_iw);
        done_iw = 1;
        #10 done_iw = 0;
        if (dout_iw == 128 && dout_iw_prev == 128) begin
            #2000 done_iw = 0;
        end
    end
    
    #100 $finish;

end



endmodule