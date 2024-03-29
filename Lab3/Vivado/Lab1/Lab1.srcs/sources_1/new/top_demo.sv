`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 01/15/2021 06:40:11 PM
// Design Name: 
// Module Name: top_demo
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module top_demo
(
  // input
  input  logic [7:0] sw,
  input  logic [3:0] btn,
  input  logic       sysclk_125mhz,
  input  logic       rst,
  // output  
  output logic [7:0] led,
  output logic sseg_ca,
  output logic sseg_cb,
  output logic sseg_cc,
  output logic sseg_cd,
  output logic sseg_ce,
  output logic sseg_cf,
  output logic sseg_cg,
  output logic sseg_dp,
  output logic [3:0] sseg_an
);

  logic [16:0] CURRENT_COUNT;
  logic [16:0] NEXT_COUNT;
  logic        smol_clk;
  logic [5:0]  y;
  logic        clk_en;
  
  // Place TicTacToe instantiation here
  FSM dut(clk_en,sw[0],sw[1],sw[2],y)


  always @(*) begin
    case(y)
    //all off
    6'b000000 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b0,1'b0,1'b0,1'b0,1'b0};
    //left
    6'b001000 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b0,1'b1,1'b0,1'b0,1'b0};
    6'b011000 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b1,1'b1,1'b0,1'b0,1'b0};
    6'b111000 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b1,1'b1,1'b1,1'b0,1'b0,1'b0};
    //right
    6'b000100 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b0,1'b0,1'b1,1'b0,1'b0};
    6'b000110 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b0,1'b0,1'b1,1'b1,1'b0};
    6'b000111 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b0,1'b0,1'b1,1'b1,1'b1};
    //haz
    6'b001100 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b0,1'b1,1'b1,1'b0,1'b0};
    6'b011110 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b0,1'b1,1'b1,1'b1,1'b1,1'b0};
    6'b111111 : {led[5],led[4],led[3],led[2],led[1],led[0]} = {1'b1,1'b1,1'b1,1'b1,1'b1,1'b1};
    endcase
  end

  // 7-segment display
  segment_driver driver(
  .clk(smol_clk),
  .rst(btn[3]),
  .digit0(),
  .digit1(),
  .digit2(),
  .digit3(),
  .decimals({1'b0, btn[2:0]}),
  .segment_cathodes({sseg_dp, sseg_cg, sseg_cf, sseg_ce, sseg_cd, sseg_cc, sseg_cb, sseg_ca}),
  .digit_anodes(sseg_an)
  );

// Register logic storing clock counts
  always@(posedge sysclk_125mhz)
  begin
    if(btn[3])
      CURRENT_COUNT = 17'h00000;
    else
      CURRENT_COUNT = NEXT_COUNT;
  end

  logic [23:0] clk_div;

    // Reset the counter and clk_en signal on reset
    always_ff @(posedge clk or posedge rst) begin
        if (rst) begin
            clk_div <= 24'b0;
            clk_en <= 1'b0;
        end else begin
            // Increment the counter on each clock cycle
            clk_div <= clk_div + 1;

            // Set clk_en to 1 when MSB of clk_div is 1
            clk_en <= clk_div[23];
        end
    end
  
  // Increment logic
  assign NEXT_COUNT = CURRENT_COUNT == 17'd100000 ? 17'h00000 : CURRENT_COUNT + 1;

  // Creation of smaller clock signal from counters
  assign smol_clk = CURRENT_COUNT == 17'd100000 ? 1'b1 : 1'b0;

endmodule
