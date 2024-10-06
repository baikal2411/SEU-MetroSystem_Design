`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/27 10:24:52
// Design Name: 
// Module Name: Button
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 这是按键检测模块，检测哪个按键被按下
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments: https://blog.csdn.net/qq_46490027/article/details/123338108
// 
//////////////////////////////////////////////////////////////////////////////////


module Button
(
    input clk,
	input rst_n,
	input [4:0] button_in,//5-bit button
	output reg [4:0] button_out
    );
    //由于FPGA系统时钟是50MHz，需要计数到20ms 20ms/20ns得到结果为1_000_000次，表示需要每一个
    //时钟上升沿计数，从0开始计数，计数到999_999,二十进制换算，
    //需要采用20bit的寄存器来保存计数次数。计数至20ms时应进行清零操作
    reg [19:0] Button_Counter; //计数器存储
    always@(posedge clk or negedge rst_n)//每个时钟上升沿检查一次
	begin
		if(~rst_n)//系统复位信号由高电平变为低电平，则清零
        Button_Counter <=20'd0;
		else if (~(button_in||5'b00000))//检测到低电平
			Button_Counter<=20'd0;
		else if (Button_Counter==20'd999_999&&(button_in||5'b00000)) 
			Button_Counter <= Button_Counter;
		else
			Button_Counter<=Button_Counter+1'b1;
	end
	always@(posedge clk or negedge rst_n)//每个时钟上升沿检查一次
	if(~rst_n)
	button_out <= 5'b0;
	else if(Button_Counter==20'd999_998)
	button_out <= button_in;
	else
	button_out <= 5'b0;
endmodule
