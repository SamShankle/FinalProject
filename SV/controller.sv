module FSM (clk, reset, out, a);

input logic clk;
input logic reset;
input logic a;
output logic out;

typedef enum logic {S0, S1} statetype;

statetype currentstate, nextstate;

always_ff @(posedge clk, posedge reset)
    if (reset) currentstate <=  S0;
    else currentstate <= nextstate;

always_comb 
    case(currentstate)
        S0: begin
            out <= 1'b0;
            if (a) nextstate <= S1;
            else nextstate <= S0;
        end
        S1: begin
            out <= 1'b1;
            if(a) nextstate <= S1;
            else nextstate <= S0;
        end
        default: begin
           out <= 1'b0;
           nextstate <= S0; 
        end
endcase

endmodule

module MUX(in0, in1, grid_e, s);
    output logic [63:0] grid_e;
    input logic[63:0] in0;
    input logic [63:0] in1;
    input logic s;
    assign grid_e = s ? in1 : in0;
endmodule

module gameStart(start, seed, clk, reset, outp);
    input logic start;
    input logic[63:0] seed;
    output logic[63:0] outp;
    logic line; 
    logic [63:0] grid_evolve;
    input logic clk, reset;
    
    
    FSM fsm(.a(start), .clk(clk), .reset(reset), .out(line));
    MUX mux(.s(line), .in0(seed), .in1(grid_evolve), .grid_e(outp));
    datapath dp(.grid(outp), .grid_evolve(grid_evolve));
endmodule
