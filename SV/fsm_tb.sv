`timescale 1ns / 1ps
module tb ();
    logic clk;
    logic reset;
    logic a;
    logic out;
    logic seed;
    logic start;

    integer handle3;
    integer desc3;

    FSM dut(clk, seed, start, reset, a, out);
    initial 
    begin
    clk = 1'b1;
    forever #5 clk = ~clk;    
    end
    
    initial
    begin
    handle3 = $fopen("fsm.out");
    #500 $finish;
    end

    always 
    begin
    desc3 = handle3;
    #10 $fdisplay(desc3, "RST = %b | A = %b || Out = %b", reset, a, out);
    end

    initial
    begin 
    #0  reset = 1'b1;
    #0  a = 1'b0;
    #10 reset = 1'b0;

    #0  a = 1'b0;
    #10 a = 1'b1;
    #40 a = 1'b0;
    #0  reset = 1'b0;
    #10 reset = 1'b1;
    #10 reset = 1'b0;

    #0  a = 1'b0;
    #10 a = 1'b1;
    #40 a = 1'b0;
    #0  reset = 1'b0;
    #10 reset = 1'b1;
    #10 reset = 1'b0;

    #0  a = 1'b0;
    #10 a = 1'b1;
    #40 a = 1'b0;
    #0  reset = 1'b0;
    #10 reset = 1'b1;
    #10 reset = 1'b0;
    end
    
endmodule