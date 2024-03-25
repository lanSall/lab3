module FSM (clk, reset, L, y, R, H);

   input logic  clk;
   input logic  reset;
   input logic 	L;
   input logic 	R;
   input logic 	H;
   

  
   
   output logic [5:0]y;

   typedef enum logic [5:0] {left0, left1, left2, Right0, Right1 ,Right2, IDLE,  HAZ0, HAZ1, HAZ2} statetype;

   statetype state, nextstate;
   
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= left0;
     else       state <= nextstate;
   // next state logic

   always_comb
     case (state)
       IDLE: begin
        if (L) nextstate <= left0;
        else if (R) nextstate <= Right0;
        else if (H) nextstate <= HAZ0;
        else nextstate <= IDLE;
       end
//____________________________________ LEFT LIGHTS
  left0: begin
	  y <= 6'b000_100;	  
	  if (L) nextstate <= left0;
	  else   nextstate <= left1;
       end

       left1: begin
	  y <= 6'b000_110;	  	  
	  if (L) nextstate <= left2;
	  else   nextstate <= left1;
       end

       left2: begin
	  y <= 6'b000_111;	  	  
	  if (L) nextstate <= left2;
	  else   nextstate <= left0;
       end

     //____________________________ RIGHT LIGHTS

    Right0: begin
	  y <= 6'b001_000;	  
	  if (R) nextstate <= Right0;
	  else   nextstate <= Right1;
       end

       Right1: begin
	  y <= 6'b011_000;	  	  
	  if (R) nextstate <= Right2;
	  else   nextstate <= Right1;
       end

       Right2: begin
	  y <= 6'b111_000;	  	  
	  if (R) nextstate <= Right2;
	  else   nextstate <= Right0;
       end
//_____________________________ HAZARDS
        HAZ0: begin
	  y <= 6'b001_100;	  
	  if (H) nextstate <= HAZ0;
	  else   nextstate <= HAZ1;
       end

       HAZ1: begin
	  y <= 6'b011_110;	  	  
	  if (H) nextstate <= HAZ2;
	  else   nextstate <= HAZ1;
       end

       HAZ2: begin
	  y <= 6'b111_111;	  	  
	  if (H) nextstate <= HAZ2;
	  else   nextstate <= HAZ0;
       end

       default: begin
	  y <= 6'b000_000;	  	  
	  nextstate <= IDLE;
       end
     endcase


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