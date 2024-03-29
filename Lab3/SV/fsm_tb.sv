`timescale 1ns / 1ps
module stimulus ();

   logic  clk;

   logic  reset;
   
   logic  [5:0] y;
   logic left;
   logic right;
   
   integer handle3;
   integer desc3;
   
   // Instantiate DUT
   FSM dut (clk, reset, left, right, y);   
   
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
	#1000 $finish;		
     end

   always 
     begin
	desc3 = handle3;
	#10 $fdisplay(desc3, "%b %b %b|| %b", 
		     reset, left, right, y);
     end   
   
   initial 
     begin      
     #0 reset <=1'b1;
     #0  right <= 1'b1;
     #20  reset <= 1'b0;
     #20 reset <= 1'b1;
     #30 reset <=1'b0;
  
     end

endmodule // FSM_tb

