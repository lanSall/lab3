module FSM (clk, reset, a, y);

   input logic  clk;
   input logic  reset;
   input logic 	L;
   input logic R;
   
   output logic y;

   typedef enum 	logic [1:0] {S0, S1, S2}, [1:0] {R1,R2,R3} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  y <= 1'b0;	  
	  if (L) nextstate <= S0;
	  else   nextstate <= S1;
       end

       S1: begin
	  y <= 1'b0;	  	  
	  if (L) nextstate <= S2;
	  else   nextstate <= S1;
       end

       S2: begin
	  y <= 1'b1;	  	  
	  if (L) nextstate <= S2;
	  else   nextstate <= S0;
       end

//------------------------------

    R1: begin
	  y <= 3'b00;	  
	  if (R) nextstate <= R0;
	  else   nextstate <= R1;
       end

       R2: begin
	  y <= 1'b001;	  	  
	  if (R) nextstate <= R2;
	  else   nextstate <= R1;
       end

       R3: begin
	  y <= 1'b0;	  	  
	  if (R) nextstate <= R2;
	  else   nextstate <= R0;
       end


//----------------------------------

       default: begin
	  y <= 1'b0;	  	  
	  nextstate <= S0;
       end
     endcase
/*
module clk_div (input logic clk, input logic rst, output logic clk_en);
logic [23:0] clk_count;
always_ff @(posedge clk)
//posedge defines a rising edge (transition from 0 to 1)
begin
if (rst)
clk_count <= 24'h0;
else
clk_count <= clk_count + 1;
end
assign clk_en = clk_count[23];
endmodule
*/

endmodule

 //always_ff @(posedge clk, posedge reset)
 /*    if (reset) state <= S0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       S0: begin
	  y <= 1'b0;	  
	  if (a) nextstate <= S0;
	  else   nextstate <= S1;
       end

       S1: begin
	  y <= 1'b0;	  	  
	  if (a) nextstate <= S2;
	  else   nextstate <= S1;
       end

       S2: begin
	  y <= 1'b1;	  	  
	  if (a) nextstate <= S2;
	  else   nextstate <= S0;
       end

       default: begin
	  y <= 1'b0;	  	  
	  nextstate <= S0;
       end
     endcase
     */