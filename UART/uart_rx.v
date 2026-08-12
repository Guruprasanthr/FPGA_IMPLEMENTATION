module uart_rx (
    input  wire       clk,
    input  wire       rst,
    input  wire       baud_clk,   // baud strobe
    input  wire       rx,         // serial input
    input  wire       p_sel,      // parity select: 0=even, 1=odd

    output reg  [7:0] data_out,   // received byte
    output reg        busy,       // high during reception
    output reg        error       // 1-cycle pulse on parity/stop error
);

    // FSM states
    parameter [2:0] 
        IDLE   = 3'd0,
        DATA   = 3'd1,
        PARITY = 3'd2,
        STOP   = 3'd3;

      reg [2:0] state, next_state;

    // Internal regs
    reg [7:0] shift_reg;
    reg [2:0] bit_count;
    reg       parity_bit;

    // FSM sequential
  always @(posedge baud_clk or posedge rst) begin
        if (rst)
            state <= IDLE;
        else
            state <= next_state;
    end

    // FSM combinational
    always @(*) begin
        case (state)
            IDLE:   next_state = (!rx)        ? DATA   : IDLE;
            DATA:   next_state = (bit_count==3'd7) ? PARITY : DATA;
            PARITY: next_state = STOP;
            STOP:   next_state = IDLE;
            default:next_state = IDLE;
        endcase
    end

    // Data path
  always @(posedge baud_clk or posedge rst) begin
        if (rst) begin
            shift_reg <= 8'd0;
            data_out  <= 8'd0;
            bit_count <= 3'd0;
            busy      <= 1'b0;
            error     <= 1'b0;
            parity_bit<= 1'b0;
        end else begin
            error <= 1'b0; // default, pulse only when error occurs

            case (state)
                IDLE: begin
                    busy      <= 1'b0;
                    bit_count <= 3'd0;
                end

                DATA: begin
                    busy <= 1'b1;
                    if (baud_clk) begin
                        shift_reg <= {rx, shift_reg[7:1]}; // LSB first
                        bit_count <= bit_count + 1'b1;
                    end
                end

                PARITY: begin
                    if (baud_clk) begin
                        // compute parity of received data
                        case (p_sel)
                            1'b0: parity_bit <= (^shift_reg);     // even parity
                            1'b1: parity_bit <= ~(^shift_reg);    // odd parity
                        endcase

                        // compare with incoming parity bit
                        if (rx !== parity_bit) begin
                            error <= 1'b1;
                            busy  <= 1'b0;
                        end
                    end
                end

                STOP: begin
                    if (baud_clk) begin
                        if (rx == 1'b1 && !error) begin
                            data_out <= shift_reg;
                            busy     <= 1'b0;
                        end else begin
                            error <= 1'b1;
                            busy  <= 1'b0;
                        end
                    end
                end
            endcase
        end
    end

endmodule
