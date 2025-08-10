module sync_fifo(
    input clk, rst_n, winc, rinc,
    input [7:0] wdata,
    output [7:0] rdata,
    output full, empty
);
    reg [7:0] mem[0:15];
    reg [3:0] wptr, rptr;
    reg [4:0] count;

    assign rdata = mem[rptr];
    assign full = (count == 16);
    assign empty = (count == 0);

    always @(posedge clk or negedge rst_n) begin
        if (!rst_n) begin
            wptr <= 0; rptr <= 0; count <= 0;
        end else begin
            case ({winc && !full, rinc && !empty})
                2'b10: begin // Write only
                    mem[wptr] <= wdata;
                    wptr <= wptr + 1;
                    count <= count + 1;
                end
                2'b01: begin // Read only
                    rptr <= rptr + 1;
                    count <= count - 1;
                end
                2'b11: begin // Read and Write
                    mem[wptr] <= wdata;
                    wptr <= wptr + 1;
                    rptr <= rptr + 1;
                end
            endcase
        end
    end
endmodule
