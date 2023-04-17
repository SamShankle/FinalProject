module FSM (clk, reset, out, a,);

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
endcase

endmodule

module MUX(in0, in1, grid_e, s);
    output logic [63:0] grid_e;
    input logic[63:0] in0, in1;
    input logic s;
    assign grid_e = s ? in1 : in0;
endmodule

module gameStart(init, inp0, inp1, outp);
    input logic init;
    input logic[63:0] inp0, inp1;
    output logic[63:0] outp;
    logic line;
    
    TB tb(.start(a));
    FSM fsm(.a(init), .out(line));
    MUX mux(.s(line), .in0(inp0), .in1(inp1), .grid_e(outp));
    datapath dp(.grid(grid_evolve), .grid_evolve(grid_e))
endmodule
