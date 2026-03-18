module top (
    input  wire clk,
    input  wire reset,
    output wire [11:0] lights   // packed: {n_g,n_y,n_r, e_g,e_y,e_r,
                                //          s_g,s_y,s_r, w_g,w_y,w_r}
);
    wire slow_clk;

    clk_divider u_div (
        .clk_in  (clk),
        .reset   (reset),
        .clk_out (slow_clk)
    );

    traffic_light_4way u_fsm (
        .clk     (slow_clk),
        .reset   (reset),
        .n_green (lights[11]), .n_yellow (lights[10]), .n_red (lights[9]),
        .e_green (lights[8]),  .e_yellow (lights[7]),  .e_red (lights[6]),
        .s_green (lights[5]),  .s_yellow (lights[4]),  .s_red (lights[3]),
        .w_green (lights[2]),  .w_yellow (lights[1]),  .w_red (lights[0])
    );

endmodule
