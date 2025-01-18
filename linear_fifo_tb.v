module linear_fifo_tb;
    reg clk, rst, write_enb, read_enb;
    reg [3:0] datain;
    wire [3:0] dataout;
    wire full, empty;

    linear_fifo uut(
        .clk(clk),
        .rst(rst),
        .write_enb(write_enb),
        .read_enb(read_enb),
        .datain(datain),
        .dataout(dataout),
        .full(full),
        .empty(empty)
    );

    always #5 clk = ~clk;

    initial begin

        clk = 0; rst = 1; write_enb = 0; read_enb = 0; datain = 0;

        #20 rst = 0;
        
        #10 write_enb = 1;$display("Write Operation.");
        repeat (16) begin
            #10 datain = datain + 1;
          $display("write data: %d", datain);
        end

        if (full) $display("FIFO is full.");
        else $display("Error: FIFO is not full.");

        #10 write_enb = 0;

        #10 read_enb = 1;$display("Read Operation.");
        repeat (16) begin
            #10 $display("Read data: %d", dataout);
        end

        if (empty) $display("FIFO is empty.");
        else $display("Error: FIFO is not empty.");

        #10 read_enb = 0;
        #10 rst = 1;
        #20 rst = 0;
      
        if (empty) $display("FIFO reset successful.");
        else $display("Error: FIFO reset failed.");

        #50 $finish;
    end
endmodule

