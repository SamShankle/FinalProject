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
      .toHDMI(hdmi)
   );
integer handle3;
integer desc3;
   initial
      begin
         handle3 = $fopen("gol.out");
         desc3 = handle3;
      end

   always @(hdmi)
      begin
         $fdisplay(desc3, "%b\n%b\n%b\n%b\n%b\n%b\n%b\n%b\n", 
                  hdmi[63:56],hdmi[55:48],hdmi[47:40],hdmi[39:32],
                  hdmi[31:24],hdmi[23:16],hdmi[15:8],hdmi[7:0]);
      end
   assign seed = 64'h0412_6424_0034_3C28;
   // Generate clock

   initial begin 
      clk = 1'b0;
      forever#5 clk = ~clk;
   end
   // Add reset
   initial begin
      reset = 1'b1;
      #10 reset = 1'b0;
      #10 start = 1'b0; 
      #40 start = 1'b1;
   end
   

  
   
endmodule
