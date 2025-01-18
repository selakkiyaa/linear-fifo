module linear_fifo(
    input wire clk,
    input wire rst,
    input wire write_enb,
    input wire read_enb,
    input wire [3:0] datain,
    output reg [3:0] dataout,
    output reg full,
    output reg empty
);
    reg [3:0] mem [15:0];
    reg [3:0] wr_ptr, rd_ptr;
    reg [4:0] fifo_count;
    integer i;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            wr_ptr <= 0;
            rd_ptr <= 0;
            fifo_count <= 0;
            full <= 0;
            empty <= 1;
            dataout <= 0;
        end else begin
            if (write_enb && !full) begin
                mem[wr_ptr] <= datain;
                wr_ptr <= wr_ptr + 1;
                fifo_count <= fifo_count + 1;
            end
            if (read_enb && !empty) begin
                rd_ptr = rd_ptr + 1;
                dataout = mem[rd_ptr];
                fifo_count <= fifo_count - 1;
            end
        end
    end

    always @(fifo_count) begin
        full = (fifo_count == 16);
        empty = (fifo_count == 0);
    end
endmodule
