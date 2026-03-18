module door(
    input clk, rst, enter,
    input [3:0] sw,
    output reg op, err
);

parameter pass = 4'b0101;

parameter idle   = 3'b000,
          in     = 3'b001,
          check  = 3'b010,
          open_s = 3'b011,
          error_s= 3'b100;

reg [2:0] state, nxt_state;

// State register
always @(posedge clk or posedge rst) begin
    if (rst)
        state <= idle;
    else
        state <= nxt_state;
end

// Next-state logic
always @(*) begin
    case(state)
        idle: begin
            nxt_state = in;
        end
        
        in: begin
            if (enter)
                nxt_state = check;
            else
                nxt_state = in;
        end
        
        check: begin
            if (pass == sw)
                nxt_state = open_s;
            else
                nxt_state = error_s;
        end
        
        open_s: begin
            nxt_state = idle;
        end
        
        error_s: begin
            nxt_state = idle;
        end
        
        default: nxt_state = idle;
    endcase
end

always @(*) begin
    op  = 0;
    err = 0;

    case(state)
        open_s:  op  = 1;
        error_s: err = 1;
    endcase
end

endmodule
