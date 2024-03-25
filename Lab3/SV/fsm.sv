module FSM (clk, reset, L, y);

   input logic  clk;
   input logic  reset;
   input logic 	L;
  
   
   output logic y;

   typedef enum logic [1:0] {left0, left1, left2}  logic [1:0] {Right0,Right1,Right2} statetype;
   

   statetype state, nextstate;
   
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= left0;
     else       state <= nextstate;
   
   // next state logic
   always_comb
     case (state)
       left0: begin
	  y <= 1'b0;	  
	  if (L) nextstate <= left0;
	  else   nextstate <= left1;
       end

       left1: begin
	  y <= 1'b0;	  	  
	  if (L) nextstate <= left2;
	  else   nextstate <= left1;
       end

       left2: begin
	  y <= 1'b1;	  	  
	  if (L) nextstate <= left2;
	  else   nextstate <= left0;
       end

         default: begin
	  y <= 1'b0;	  	  
	  nextstate <= S0;
       end
     endcase

//------------------------------

    always_ff @(posedge clk, posedge reset)
     if (reset) state <= Right0;
     else       state <= nextstate;

    Right1: begin
	  y <= 3'b00;	  
	  if (L) nextstate <= Right0;
	  else   nextstate <= Right1;
       end

       Right2: begin
	  y <= 1'b001;	  	  
	  if (L) nextstate <= Right2;
	  else   nextstate <= Right1;
       end

       Right3: begin
	  y <= 1'b0;	  	  
	  if (L) nextstate <= Right2;
	  else   nextstate <= Right0;
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