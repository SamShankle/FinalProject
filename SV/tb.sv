`timescale 1ns / 1ps
module tb;
   logic start;
   logic [63:0] hdmi;
   logic clk;
   logic reset;
   logic [63:0] seed;
   
   // Instantiate DUT
   gameStart dut(
      .start(start), 
      .seed(seed), 
      .clk(clk), 
      .reset(reset), 
      .outp(hdmi)
   );
  assign seed = 64'h0412_6424_0034_3C28;
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
   

  
   
endmodule
