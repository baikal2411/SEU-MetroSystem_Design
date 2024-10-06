`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/27 11:15:11
// Design Name: 
// Module Name: Button_SIm
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







module Button_SIm(

    );
    reg sys_clk_i ;
    reg ext_rst ;
    reg[4:0]key_h ;
    wire[4:0]led ;
    Button buttontest(
	.clk(sys_clk_i),
	.rst_n(ext_rst),
	.button_in(key_h), //按键未按下时高电平，按下后低电平
	.button_out(led)
    );
initial begin
	sys_clk_i = 1'b0 ;
	ext_rst = 1'b1 ;
	key_h = 5'b00000 ;
	#1000
	@(posedge sys_clk_i) ; #2 ;
	ext_rst = 1'b0 ;
	@(posedge sys_clk_i) ; #2 ;
	ext_rst = 1'b1 ;
	//模拟按键抖动
	key_h[0] = 1'b0 ;
	#1000_000  ;//1ms
	key_h[0] = 1'b1 ;
	#5_000_000  ;//5ms
	key_h[0] = 1'b0 ;
	#3_000_000  ;//3ms
	key_h[0] = 1'b1 ;
	#1_000_000 
	key_h[0] = 1'b0 ;
	#1000_000  ;//1ms
	key_h[0] = 1'b1 ;
	#5_000_000  ;//5ms
	key_h[0] = 1'b0 ;
	#3_000_000  ;//3ms
	key_h[0] = 1'b1 ;
	#3_000_000  ;//3ms
	key_h[0] = 1'b0 ;
	#50_000_000  ;//50ms
	key_h[0] = 1'b1 ;
	#30_000_000  ;//30ms
	key_h[0] = 1'b0 ;
	#50_000_000  ;//50ms
	key_h[0] = 1'b1 ;
	$finish ;
end
always #10 sys_clk_i = ~sys_clk_i ;
endmodule
