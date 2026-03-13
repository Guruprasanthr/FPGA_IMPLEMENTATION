module top (
    input  [3:0] sw,
    output reg [3:0] led_tens,
    output reg [3:0] led_ones
);
    always @(*) begin
        led_tens = sw / 10;
        led_ones = sw % 10;
    end
endmodule
