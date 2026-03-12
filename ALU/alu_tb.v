module alu_tb;

reg [3:0] a,b;
reg [2:0] op;
wire [3:0] y;

alu dut(.a(a), .b(b), .op(op), .y(y));

initial begin
    a = 4'b0101;
    b = 4'b1010;

    op = 3'b000;
    #5 op = 3'b001;
    #5 op = 3'b010;
    #5 op = 3'b011;
    #5 op = 3'b100;
    #5 op = 3'b101;
    #5 op = 3'b110;
    #5 op = 3'b111;

    #10 $finish;
end

initial begin
  $monitor("a=%b,b=%b,op=%b,y=%b",a,b,op,y);
    $dumpfile("waves.vcd");
    $dumpvars();
end

endmodule
