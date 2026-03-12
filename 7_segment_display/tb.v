module seven_segment_tb;
  reg[3:0]a;
  wire[6:0]out;
  seven_segment uut(.a(a),.out(out));
  initial begin
    a=4'b0000;
    #5a=4'b0001;
     #5a=4'b0010;
     #5a=4'b0011;
     #5a=4'b0100;
     #5a=4'b0101;
     #5a=4'b0110;
     #5a=4'b0111;
     #5a=4'b1000;
     #5a=4'b1001;
    #10 $finish;
  end
  initial begin
    $monitor("a=%b,out=%b",a,out);
  end
endmodule
