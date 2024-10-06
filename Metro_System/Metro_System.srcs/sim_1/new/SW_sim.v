`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 2024/08/27 21:45:14
// Design Name: 
// Module Name: SW_sim
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


module SW_sim(

    );
    reg sys_clk_i ;
    reg ext_rst_n ;
    reg[15:0]sw_test ;
    wire[15:0]sw_out ;
    SW swtest(
	.clk(sys_clk_i),
	.rst_n(ext_rst_n),
	.sw_in(sw_test), //按键未按下时高电平，按下后低电平
	.sw_out(sw_out)
    );
initial begin
	sys_clk_i = 1'b0 ;
	ext_rst_n = 1'b0 ;
	sw_test = 16'b0;
	#1000
	@(posedge sys_clk_i) ; #2 ;
	ext_rst_n = 1'b1 ;
	@(posedge sys_clk_i) ; #2 ;

	//模拟按键抖动
	sw_test[0] = 1'b0 ;
	#1000_000  ;//1ms
	sw_test[0] = 1'b1 ;
	#5_000_000  ;//5ms
	sw_test[0] = 1'b0 ;
	#3_000_000  ;//3ms
	sw_test[0] = 1'b1 ;
	#1_000_000 
	sw_test[0] = 1'b0 ;
	#1000_000  ;//1ms
	sw_test[0] = 1'b1 ;
	#5_000_000  ;//5ms
	sw_test[0] = 1'b0 ;
	#3_000_000  ;//3ms
	sw_test[0] = 1'b1 ;
	#3_000_000  ;//3ms
	sw_test[0] = 1'b0 ;
	#50_000_000  ;//50ms
	sw_test[0] = 1'b1 ;
	#30_000_000  ;//30ms
	sw_test[0] = 1'b0 ;
	#50_000_000  ;//50ms
	sw_test[0] = 1'b1 ;
	$finish ;
end
always #10 sys_clk_i = ~sys_clk_i ;
endmodule
