
module traffic_light_4way (
    input  wire clk,       // slow clock from divider
    input  wire reset,

    // North road
    output reg  n_green,
    output reg  n_yellow,
    output reg  n_red,

    // East road
    output reg  e_green,
    output reg  e_yellow,
    output reg  e_red,

    // South road
    output reg  s_green,
    output reg  s_yellow,
    output reg  s_red,

    // West road
    output reg  w_green,
    output reg  w_yellow,
    output reg  w_red
);
    // State encoding — 3 bits for 8 states
    parameter S0 = 3'd0,   // North  green
              S1 = 3'd1,   // North  yellow
              S2 = 3'd2,   // East   green
              S3 = 3'd3,   // East   yellow
              S4 = 3'd4,   // South  green
              S5 = 3'd5,   // South  yellow
              S6 = 3'd6,   // West   green
              S7 = 3'd7;   // West   yellow

    // How many slow-clock ticks each state lasts
    parameter GREEN_TIME  = 4'd9;   // 10 ticks = 10 s at 1 Hz
    parameter YELLOW_TIME = 4'd2;   //  3 ticks =  3 s at 1 Hz

    reg [2:0] state, next_state;
    reg [3:0] counter;
    reg [3:0] duration;   // how long current state should last

    // ── Block 1: State register + counter ────────────────
    always @(posedge clk or posedge reset) begin
        if (reset) begin
            state    <= S0;
            counter  <= 0;
            duration <= GREEN_TIME;
        end else begin
            if (counter == duration) begin
                state   <= next_state;
                counter <= 0;
                // pre-load timer for the incoming state
                case (next_state)
                    S0, S2, S4, S6: duration <= GREEN_TIME;
                    S1, S3, S5, S7: duration <= YELLOW_TIME;
                    default:        duration <= GREEN_TIME;
                endcase
            end else begin
                counter <= counter + 1;
            end
        end
    end

    // ── Block 2: Next-state logic ─────────────────────────
    always @(*) begin
        case (state)
            S0: next_state = S1;
            S1: next_state = S2;
            S2: next_state = S3;
            S3: next_state = S4;
            S4: next_state = S5;
            S5: next_state = S6;
            S6: next_state = S7;
            S7: next_state = S0;
            default: next_state = S0;
        endcase
    end

    // ── Block 3: Output logic (Moore) ─────────────────────
    always @(*) begin
        // default: all roads red
        {n_green, n_yellow, n_red} = 3'b001;
        {e_green, e_yellow, e_red} = 3'b001;
        {s_green, s_yellow, s_red} = 3'b001;
        {w_green, w_yellow, w_red} = 3'b001;

        case (state)
            S0: {n_green, n_yellow, n_red} = 3'b100;  // N green
            S1: {n_green, n_yellow, n_red} = 3'b010;  // N yellow
            S2: {e_green, e_yellow, e_red} = 3'b100;  // E green
            S3: {e_green, e_yellow, e_red} = 3'b010;  // E yellow
            S4: {s_green, s_yellow, s_red} = 3'b100;  // S green
            S5: {s_green, s_yellow, s_red} = 3'b010;  // S yellow
            S6: {w_green, w_yellow, w_red} = 3'b100;  // W green
            S7: {w_green, w_yellow, w_red} = 3'b010;  // W yellow
        endcase
    end

endmodule
