`timescale 1ns / 1ps

module spi_rx (
    input clk,          // 系统时钟（通常与CPU同频）
    input reset_n,      // 异步低电平复位
    // SPI 接口
    input sck,          // SPI 时钟（由主机提供）
    input cs_n,         // 片选（低电平有效）
    input mosi,         // 主出从入数据线
    // 用户接口
    output [7:0] rx_data,// 接收到的数据
    output rx_valid      // 数据有效标志（脉冲信号）
);

    // 状态定义
    localparam IDLE  = 2'b00;
    localparam RX    = 2'b01;
    localparam DONE  = 2'b10;

    reg [1:0] state;         // 状态机
    reg [2:0] bit_count;     // 已接收的比特数（0-7）
    reg [7:0] shift_reg;     // 移位寄存器

    reg [7:0] rx_data_r; // 接收到的数据
    reg rx_valid_r;    

    // 同步SCK和CS_N以避免亚稳态
    reg sck_sync1, sck_sync2;
    reg cs_sync1, cs_sync2;

    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            sck_sync1 <= 1'b0;
            sck_sync2 <= 1'b0;
            cs_sync1  <= 1'b1;
            cs_sync2  <= 1'b1;
        end else begin
            sck_sync1 <= sck;
            sck_sync2 <= sck_sync1;
            cs_sync1  <= cs_n;
            cs_sync2  <= cs_sync1;
        end
    end

    // 检测SCK上升沿（CPHA=0模式）
    wire sck_rising = (sck_sync2 == 0) && (sck_sync1 == 1);
    wire cs_active = (cs_sync2 == 0);  // 片选有效（低电平）

    // 主状态机
    always @(posedge clk or negedge reset_n) begin
        if (!reset_n) begin
            state      <= IDLE;
            bit_count  <= 3'b0;
            shift_reg  <= 8'b0;
            rx_data_r    <= 8'b0;
            rx_valid_r   <= 1'b0;
        end else begin
            rx_valid_r <= 1'b0;  // 默认无效

            case (state)
                IDLE: begin
                    if (cs_active && sck_rising) begin
                        state <= RX;
                        shift_reg <= {shift_reg[6:0], mosi};  // 采样第一位
                        bit_count <= bit_count + 1;
                    end
                end

                RX: begin
                    if (sck_rising) begin
                        shift_reg <= {shift_reg[6:0], mosi};  // 移位输入
                        bit_count <= bit_count + 1;

                        if (bit_count == 3'b111) begin  // 收满8位
                            state <= DONE;
                            rx_data_r <= {shift_reg[6:0], mosi};  // 锁存数据
                            rx_valid_r <= 1'b1;
                        end
                    end

                    if (!cs_active) begin  // 片选提前释放
                        state <= IDLE;
                    end
                end

                DONE: begin
                    state <= IDLE;
                end
            endcase
        end
    end

    assign rx_data = rx_data_r;
    assign rx_valid = rx_valid_r;

endmodule
