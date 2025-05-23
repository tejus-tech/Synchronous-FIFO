module tb_sync_fifo;
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 64;

    reg clk = 0;
    reg rst;
    reg wr_en;
    reg rd_en;
    reg [DATA_WIDTH-1:0] din;
    wire [DATA_WIDTH-1:0] dout;
    wire full;
    wire empty;

    sync_fifo #(.DATA_WIDTH(DATA_WIDTH), .DEPTH(DEPTH)) uut (
        .clk(clk),
        .rst(rst),
        .wr_en(wr_en),
        .rd_en(rd_en),
        .din(din),
        .dout(dout),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;  // 100MHz clock

    initial begin
      $dumpfile("info.vcd");
      $dumpvars(0,tb_sync_fifo);
      
        $display("Starting FIFO test...");
        rst = 1;
        wr_en = 0;
        rd_en = 0;
        din = 0;
        #20;

        rst = 0;

        // Write data into FIFO
        repeat (10) begin
            @(posedge clk);
            wr_en = 1;
            din = din + 1;
        end
        wr_en = 0;

        // Wait and then read data from FIFO
        #20;
        repeat (10) begin
            @(posedge clk);
            rd_en = 1;
        end
        rd_en = 0;

        #20;
        $display("Test completed.");
        $finish;
    end
endmodule