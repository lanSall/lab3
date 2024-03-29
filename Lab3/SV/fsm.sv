module FSM (clk, reset, left ,right ,y);

   input logic  clk;
   input logic  reset;
   input logic left;
   input logic right;

   output logic [5:0] y;

   typedef enum 	logic [3:0] {haz1,haz2,haz3,haz4,left1, left2, left3, left4, right1, right2, right3, right4, IDLE} statetype;
   statetype state, nextstate;
   
   // state register
   always_ff @(posedge clk, posedge reset)
     if (reset) state <= IDLE;
     else       state <= nextstate;
   
    always_comb
      case (state)

      //default state
      IDLE: begin
        y = 6'b000000;

        if(reset)             nextstate <= IDLE;
        else if(left&&right)  nextstate <= haz1;
        else if (left&&!right)        nextstate <= left1;
        else if (!left&&right)       nextstate <= right1;
        else                  nextstate <= IDLE;
      end
      //hazard state
      haz1: begin
        y = 6'b001100;

        if(reset)             nextstate <= IDLE;
        else                  nextstate <= haz2;
      end
      haz2: begin
        y = 6'b011110;

        if(reset)             nextstate <= IDLE;
        else                  nextstate <= haz3;
      end
      haz3: begin
        y = 6'b111111;

        if(reset)             nextstate <= IDLE;
        else                  nextstate <= haz4;
      end

      haz4: begin
      y = 6'b000000;

        if(reset)             nextstate <= IDLE;
        else if(left&&right)  nextstate <= haz1;
        else if(left&&!right)         nextstate <= left1;
        else if(!left&&right)        nextstate <= right1;
        else                  nextstate <= haz1;
      end

      //left state
      left1: begin
        y = 6'b001000;
      
        if (reset)            nextstate <= IDLE;
        else                  nextstate <= left2;
      end

      left2: begin
        y = 6'b011000;
      
        if (reset)            nextstate <= IDLE;
        else                  nextstate <= left3;
      end

      left3: begin
        y = 6'b111000;
      
        if (reset)            nextstate <= IDLE;
        else                  nextstate <= left4;
      end

      left4: begin
        y = 6'b000000;
    
        if (reset)            nextstate <= IDLE;
        else if (!left&&right)nextstate <= right1;
        else if (left&&right) nextstate <= haz1;
        else                  nextstate <= left1;
      end

      //right state
      right1: begin
        y = 6'b000100;
      
        if (reset)            nextstate <= IDLE;
        else                  nextstate <= right2;
      end

      right2: begin
        y = 6'b000110;
      
        if (reset)            nextstate <= IDLE;
        else                  nextstate <= right3;
      end

      right3: begin
        y = 6'b000111;
      
        if (reset)            nextstate <= IDLE;
        else                  nextstate <= right4;
      end

      right4: begin
        y = 6'b000000;

        if (reset)            nextstate <= IDLE;
        else if (left&&!right)nextstate <= left1;
        else if (left&&right) nextstate <= haz1;
        else                  nextstate <= right1;
      end

      default: begin
        nextstate <= IDLE;
      end 

      endcase

endmodule
