// Ultra-minimal testbench for sync_fifo
module tb_sync_fifo;

    reg clk=0, rst_n, winc, rinc;
    reg [7:0] wdata;
    wire [7:0] rdata;

    // Instantiate DUT (Design Under Test)
    sync_fifo dut (.*);

    // Clock generator
    always #5 clk = ~clk;

    // Minimal test sequence: write 'hAA', then read it.
    initial begin
        rst_n=0; #15; rst_n=1; // Reset the FIFO

        @(posedge clk);
        winc=1; wdata='hAA';   // Write 'hAA'
        @(posedge clk);
        winc=0;
        rinc=1;                // Enable read
        @(posedge clk);
        $display("Read data: %h (Expected: AA)", rdata);
        
        $finish;
    end
endmodule
