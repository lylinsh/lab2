`timescale 1ns / 1ps

module spi_rx_tb();

    localparam CLK_PERIOD = 10;   
    localparam SCK_PERIOD = 40;   

    reg clk;
    reg reset_n;
    reg sck;
    reg cs_n;
    reg mosi;
    wire [7:0] rx_data;
    wire rx_valid;

    spi_rx uut (
        .clk(clk),
        .reset_n(reset_n),
        .sck(sck),
        .cs_n(cs_n),
        .mosi(mosi),
        .rx_data(rx_data),
        .rx_valid(rx_valid)
    );

    initial begin
        clk = 0;
        forever #(CLK_PERIOD/2) clk = ~clk;
    end

    initial begin
        sck = 1'b1;
        forever #(SCK_PERIOD/2) sck = ~sck;
    end

    initial begin
        reset_n = 0;
        cs_n = 1'b1;
        mosi = 1'b0;
        #100;

        reset_n = 1;
        #20;

        $display("=== Test 1: Send 0xA5 ===");
        spi_send_byte(8'hA5);
        #50;

        $display("=== Test 2: Send 0x12, 0x34 ===");
        spi_send_byte(8'h12);
        spi_send_byte(8'h34);
        #300;

        $display("All tests completed.");
        $finish;
    end


    task spi_send_byte;
        input [7:0] data;
        integer i;
        begin
            cs_n = 1'b0;           
            #(SCK_PERIOD/2);        

            for (i = 7; i >= 0; i = i - 1) begin
                mosi = data[i];     
                #(SCK_PERIOD);    
            end

            cs_n = 1'b1;            
            mosi = 1'b0;
            #(SCK_PERIOD/2);
        end
    endtask

    always @(posedge clk) begin
      if (rx_valid) begin
           $display("Time=%0t: Received data=0x%02X", $time, rx_data);
       end
    end

    initial begin
        $dumpfile("spi_rx.fsdb");
        $dumpvars(0, spi_rx_tb);
    end

endmodule
