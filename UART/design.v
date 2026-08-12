`timescale 1ns/1ps

`include "baud_gen.v"
`include "uart_tx.v"
`include "uart_rx.v"

// ======================================================
// UART Top Module
// Instantiates: uart_baud_gen + uart_tx + uart_rx
// Loopback testable (tx -> rx inside the module)
// ======================================================
module uart_top #(
    parameter CLK_FREQ  = 50000000,  // Hz
    parameter BAUD_RATE = 9600       // baud
)(
    input  wire       clk,
    input  wire       rst,
    input  wire       tx_start,   // start transmission
    input  wire [7:0] data_in,    // parallel data
    input  wire       p_sel,      // parity select: 0=even, 1=odd
  	input  wire		  rx,	
    output wire       tx,         // serial TX line
    output wire [7:0] data_out,   // received data
    output wire       busy,       // RX busy
    output wire       error       // RX error
);  

    // Internal signal from baud generator
    wire baud_tick;

    // ======================================================
    // Baud Generator
    // ======================================================
    uart_baud_gen #(
        .CLK_FREQ (CLK_FREQ),
        .BAUD_RATE(BAUD_RATE)
    ) baud_gen_inst (
        .clk       (clk),
        .rst       (rst),
        .baud_tick (baud_tick)
    );

    // ======================================================
    // Transmitter FSM
    // ======================================================
    uart_tx tx_inst (
        .clk       (clk),
        .rst       (rst),
        .baud_tick (baud_tick),
        .tx_start  (tx_start),
        .data_in   (data_in),
        .p_sel     (p_sel),
        .tx        (tx)
    );

    // ======================================================
    // Receiver FSM
    // ======================================================
    uart_rx rx_inst (
        .rst      (rst),
        .baud_clk (baud_tick),
      	.rx       (rx),       // internal loopback from TX
        .p_sel    (p_sel),    // same parity as TX
        .data_out (data_out),
        .busy     (busy),
        .error    (error)
    );

endmodule
