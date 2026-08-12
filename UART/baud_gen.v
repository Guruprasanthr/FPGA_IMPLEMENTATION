// ======================================================
// UART Baud Generator
// ======================================================
module uart_baud_gen #(
    parameter CLK_FREQ  = 50000000,  // system clock frequency in Hz
    parameter BAUD_RATE = 9600       // desired baud rate
)(
    input  wire clk,
    input  wire rst,
    output reg  baud_tick
);

    localparam integer DIVISOR = CLK_FREQ / BAUD_RATE;
    localparam integer CNT_W   = $clog2(DIVISOR);

    reg [CNT_W-1:0] counter;

    always @(posedge clk or posedge rst) begin
        if (rst) begin
            counter   <= 0;
            baud_tick <= 0;
        end else begin
            if (counter == DIVISOR-1) begin
                counter   <= 0;
                baud_tick <= 1'b1; // 1-cycle pulse
            end else begin
                counter   <= counter + 1'b1;
                baud_tick <= 1'b0;
            end
        end
    end

endmodule
