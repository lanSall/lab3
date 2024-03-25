`timescale 1ns / 1ps
module stimulus ();

   logic  clk;
   logic  L;
   logic  reset;
   logic  R;
   logic  H;


   logic  [5:0]y;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, L, y, R, H );   
   
   // Setup the clock to toggle every 1 time units 
   initial 
     begin	
	clk = 1'b1;
	forever #5 clk = ~clk;
     end

   initial
     begin
	// Gives output file name
	handle3 = $fopen("fsm.out");
	// Tells when to finish simulation
	#500 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b %b  || %b", reset, L, y, R ,H);
     end   
   
   initial 
     begin      
	#0   reset = 1'b1;
	#20  reset = 1'b0;	

	#0   L <= 1'b0;
	#20  L <= 1'b1;
	#20  L <= 1'b0;

     #0   R <= 1'b0;
	#20  R <= 1'b1;
	#20  R <= 1'b0;

     #0   H <= 1'b0;
	#20  H <= 1'b1;
	#20  H <= 1'b0;
     end

endmodule // FSM_tb

