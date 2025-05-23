module sync_fifo
(
    input wire clk,
    input wire rst,
    input wire wr_en,
    input wire rd_en,
    input wire [7:0] din,
    output reg [7:0] dout,
    output reg full,
    output reg empty
);
    parameter DATA_WIDTH = 8;
    parameter DEPTH = 64;
    parameter PTR = 6;

    reg [DATA_WIDTH-1:0] mem [0:DEPTH-1];
    reg [PTR-1:0] wr_ptr = 0;
    reg [PTR-1:0] rd_ptr = 0;
    reg [63:0] count = 0;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            count <= 0;
            full <= 0;
            empty <= 1;
        end else begin
            // Write operation
            if (wr_en && !full) begin
                mem[wr_ptr] <= din;
                wr_ptr <= wr_ptr + 1;
                count <= count + 1;
            end

            // Read operation
            if (rd_en && !empty) begin
                dout <= mem[rd_ptr];
                rd_ptr <= rd_ptr + 1;
                count <= count - 1;
            end

            // Update status flags
            full <= (count == DEPTH);
            empty <= (count == 0);
        end
    end
endmodule