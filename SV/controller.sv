module FSM (clk, reset, out, a,);

input logic clk;
input logic reset;
input logic a;
output logic out;

typedef enum logic {S0, S1} statetype;

statetype state, nextstate;

always_ff @(posedge clk, posedge reset)
    if (reset) state <=  S0;
    else state <= nextstate;

always_comb 
    case(state)
        S0: begin
            out <= 1'b0;
            if (a) nextstate <= S1;
            else nextstate <= S0;
        end
        S1: begin
            out <= 1'b1;
            if(a) nextstate <= S0;
            else nextstate <= S0
        end
endcase

endmodule

module mux();
  assign c = sel ? a : b;
endmodule