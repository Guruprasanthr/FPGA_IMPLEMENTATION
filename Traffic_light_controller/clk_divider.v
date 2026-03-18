module clk_divider (
    input  wire clk_in,
    input  wire reset,
    output reg  clk_out
);
    parameter COUNT_MAX = 25_000_000;  // for 50 MHz FPGA

    reg [24:0] counter;

    always @(posedge clk_in or posedge reset) begin
        if (reset) begin
            counter <= 0;
            clk_out <= 0;
        end else if (counter == COUNT_MAX - 1) begin
            counter <= 0;
            clk_out <= ~clk_out;   // toggle → 1 Hz square wave
        end else begin
            counter <= counter + 1;
        end
    end
endmodule
