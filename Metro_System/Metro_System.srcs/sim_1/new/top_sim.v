`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/28 14:11:41
// Design Name: 
// Module Name: top_sim
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


module top_sim(

    );
    wire [6:0] SEG;
    wire [7:0] AN;
    wire DP;
    reg [15:0] sw_in;
    reg [4:0] button_in;
    wire [15:0] sw_out;
    wire [4:0] button_out;
    reg clk;
    reg rst_n;
    wire  RGB1_Blue;
    wire  RGB1_Green;
    wire  RGB1_Red;
    wire  RGB2_Blue;
    wire  RGB2_Green;
    wire  RGB2_Red;
   
    top top_test( 
    .clk(clk),
    .sw_in(sw_in),
    .rst_n(rst_n),
    .button_in(button_in),
    .SEG(SEG),
    .AN(AN),
    .DP(DP),
    .sw_out(sw_out),
    .button_out(button_out),
    .RGB1_Blue(RGB1_Blue),
    .RGB1_Green(RGB1_Green),
    .RGB1_Red(RGB1_Red),
    .RGB2_Blue(RGB2_Blue),
    .RGB2_Green(RGB2_Green),
    .RGB2_Red(RGB2_Red)
    );
    initial begin
    clk = 1'b0;
	rst_n = 1'b1 ;
	button_in = 5'b00000 ;
    sw_in = 16'b0;
	#1000
    //芯片上电复位
	@(posedge clk) ; #10 ;
	rst_n = 1'b0 ;
	@(posedge clk) ; #10 ;
    rst_n = 1'b1 ;
	
   
    
    //button[4]:Make sure
    //button[0]:Up
    //button[1]:left
    //button[2]:right
    //button[3]:down

	#3_000_000  ;//25ms
	button_in[0] = 1'b1 ;
	#3_000_000  ;//20ms
	button_in[0] = 1'b0 ;
    //模拟按键
    #3_000_000 ;//30ms
    button_in[0] = 1'b1;
    #3_000_000 ;//10ms
    button_in[0] = 1'b0;
    //此时应该显示�??5�??
    
    //再点击确�??
    #5_000_000 ;
    button_in[4] = 1'b1;
    #3_000_000 ;
    button_in[4] = 1'b0;

    //进入选票模式
    #3_000_000;
    button_in[3] = 1'b1;
    #2_000_000;
    button_in[3] = 1'b0;
    //相当于�?�择9张票，应该显�??45�??

    //按�?�确定�?�键确定总价�??
   #5_000_000;
    button_in[4] = 1'b1;
    #8_000_000;
    button_in[4] = 1'b0;
    //然后进入付款状�??
    #10_000_000;
    sw_in[3] = 1'b1;
    #10_000_000;
    sw_in[3] = 1'b0;
    //先投20�??
    
    #10_000_000;
    sw_in[2] = 1'b1;
    #10_000_000;
    sw_in[2] = 1'b0;
    //�??10�??

    #10_000_000;
    sw_in[1] = 1'b1;
    #10_000_000;
    sw_in[1] = 1'b0;
    //�??5�??

    #10_000_000;
    sw_in[3] = 1'b1;
    #10_000_000;
    sw_in[3] = 1'b0;
    //�??20�??

    #10_000_000;
    button_in[4] = 1'b1;
    #100_000_000;
    button_in[4] = 1'b0;
    //再按确定键返�??
    #100_000_000;
    end
 

    always #1 begin
        clk = ~clk;
    end

endmodule
