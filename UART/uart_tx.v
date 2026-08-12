// ======================================================
// UART Transmitter FSM
// ======================================================
module uart_tx (
    input  wire       clk,
    input  wire       rst,
    input  wire       baud_tick,   // from baud generator
    input  wire       tx_start,    // start transmission
    input  wire [7:0] data_in,     // parallel data
    input  wire       p_sel,       // 0=even, 1=odd
    output reg        tx           // serial output
);

    // FSM states
    parameter [2:0] 
        IDLE     = 3'd0,
        DATA     = 3'd1,
        PARITY   = 3'd2,
        FRAME    = 3'd3,
        TRANSMIT = 3'd4;


  reg [2:0]  state, next_state;

    // Shift register for frame {stop, parity, data, start}
    reg [10:0] shift_reg;
    reg [3:0]  bit_count;  // up to 11

    reg parity_bit;

    // FSM Sequential
    always @(posedge clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM Combinational
    always @(*) begin
        case (state)
            IDLE:     next_state = tx_start ? DATA     : IDLE;
            DATA:     next_state = PARITY;
            PARITY:   next_state = FRAME;
            FRAME:    next_state = TRANSMIT;
            TRANSMIT: next_state = (bit_count == 11) ? IDLE : TRANSMIT;
            default:  next_state = IDLE;
        endcase
    end

    // Data Path
    always @(posedge clk or posedge rst) begin
        if (rst) begin
            tx        <= 1'b1;  // idle line high
            shift_reg <= 11'd0;
            bit_count <= 4'd0;
            parity_bit<= 1'b0;
        end else begin
            case (state)
                IDLE: begin
                    tx        <= 1'b1;
                    bit_count <= 4'd0;
                end

                DATA: begin
                    // nothing to do here, just move to next
                end

                PARITY: begin
                    // compute parity
                    case (p_sel)
                        1'b0: parity_bit <= ^data_in ? 1'b1 : 1'b0; // even
                        1'b1: parity_bit <= ^data_in ? 1'b0 : 1'b1; // odd
                    endcase
                end

                FRAME: begin
                    // assemble frame {stop=1, parity, data[7:0], start=0}
                    shift_reg <= {1'b1, parity_bit, data_in, 1'b0};
                end

                TRANSMIT: begin
                    if (baud_tick) begin
                        tx        <= shift_reg[0];
                        shift_reg <= shift_reg >> 1;
                        bit_count <= bit_count + 1'b1;
                    end
                end
            endcase
        end
    end

endmodule
