`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/28 13:07:21
// Design Name: 
// Module Name: top
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


module top(
    input clk,
    input [15:0] sw_in,
    input rst_n,
    input [4:0] button_in,
    output [6:0] SEG,
    output [7:0] AN,
    output DP,
    output [15:0] sw_out,
    output [4:0] button_out,
    output  RGB1_Blue,
    output  RGB1_Green,
    output  RGB1_Red,
    output  RGB2_Blue,
    output  RGB2_Green,
    output  RGB2_Red
    );
//state 2'b00: User chooses the price by themselves or according to the start and the destination
//state 2'b01: Press the button to change the ticket num
//state:2'b10: The total price will be displayed on the right 2 bits of LEDs and 
// users need to pay, when the amount meets the demand the mode will be changed into "repay mode"
//state 2'b11: some parameters will be cleared , and after some time the state will be changed into 2'b00





//    
    Button Metro_Button(
    .clk(clk),
    .button_in(button_in),
    .rst_n(rst_n),
    .button_out(button_out)
    );
    SW Metro_Switch(
    .clk(clk),
    .rst_n(rst_n),
    .sw_in(sw_in),
    .sw_out(sw_out)
    );
    //button[4]:Make sure
    //button[0]:Up
    //button[1]:left
    //button[2]:right
    //button[3]:down
    reg [29:0] final_state_counter = 30'b0;
    reg [1:0] state = 2'b00;
    always @(posedge clk) begin
      if(final_state_counter==30'd199_999_999)
      final_state_counter<=30'b0;
      else
        final_state_counter<=final_state_counter+1'b1;
    end
    always@(posedge clk)begin
      if(~rst_n)
      state <= 2'b00;
      else if(sw_out[15])
        state<= 2'b00;
      else if(state==2'b11&&final_state_counter==30'b0)
        state<=2'b00;
      else begin 
        if(button_out[4])begin 
          if(state<2'b11)begin
            state<= state+1'b1;
          end
          else 
            state <= 2'b00;
        end
      end
    end
   assign  RGB1_Blue = ~(state[0]^state[1]);
   assign  RGB1_Green = (~state[0])&(state[1]);
   assign  RGB1_Red = (state[0])&(~state[1]);
   assign  RGB2_Blue = (~state[0])&(~state[1]);
   assign  RGB2_Green = (state[0])^(state[1]);
   assign  RGB2_Red = (state[0])&(state[1]);
  
   StatusMachine Metro( 
    .rst_n(rst_n),
   .button(button_out),
   .sw_out(sw_out),
   .clk(clk),
  .status(state),
   .AN(AN),
  .SEG(SEG),
  .DP(DP)
   );
      
    
endmodule
