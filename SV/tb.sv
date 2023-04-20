`timescale 1ns / 1ps
module tb;
   logic start;
   reg clk;
   reg reset;
   wire [63:0] seed;
   wire [63:0] grid_e;
   
   // Instantiate DUT
   FSM dut (
      .clk(clk),
      .reset(reset),
      .a(start),
      .out()

   );
   MUX dut2(
      .in0(seed),
      .in1(),
      .grid_e(),
      .s()
   );
   
   // Generate clock
   initial clk = 0;
   always #5 clk = ~clk;
   
   // Add reset
   initial begin
      reset = 1;
      #10 reset = 0;
      #10 start = 1'b0; 
      #40 start = 1'b1;
   end
   
   // Add testbench stimulus
   initial begin
      #20 $display("Grid: %b", seed);
      #20 $display("Grid Evolve: %b", grid_e);
      #30 $display("Grid: %b", seed);
      #30 $display("Grid Evolve: %b", grid_e);
      #40 $display("Grid: %b", seed);
      #40 $display("Grid Evolve: %b", grid_e);
      #50 $finish;
   end
   
endmodule

