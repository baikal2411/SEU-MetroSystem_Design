module SW(     
    input clk,
    input rst_n,
    input [15:0] sw_in,
    output reg [15:0] sw_out
    );
	reg [29:0] SW_Counter = 30'b0; //计数器存�?
    always@(posedge clk)//每个时钟上升沿检查一�?
	begin
		if(~rst_n)//系统复位信号由高电平变为低电平，则清�?
        SW_Counter <=30'b0;
		if (~(sw_in[15:0]||16'b0))//�?测到低电�?
			SW_Counter<=30'b0;
		else if (SW_Counter==30'd1_999_999&&(sw_in)) 
			SW_Counter <= SW_Counter;
		else
			SW_Counter<=SW_Counter+1'b1;
	end
	always@(posedge clk)//每个时钟上升沿检查一�?
	if(~rst_n)
	sw_out <= 16'b0;
	else if(SW_Counter==30'd1_999_998)
	sw_out <= sw_in;
	else
	sw_out <= 16'b0;
    // reg [1:0]Next_State;//存储下一个状�?
    // reg [15:0]SW_Temp;
    // reg Time_20ms;
    // reg SW_Flag;
    // reg [28:0] SW_Counter;

    // always @ ( posedge clk or negedge rst_n )

	//     if( ~rst_n )//出现复位信号的下降，则进行异步复�?
	// 	    begin
	// 		    SW_Temp <= 16'b0000000000000000;
	// 		    Next_State <= 2'b0;
	// 		    SW_Flag     <= 1'b0;
	// 		    sw_out <= 16'b0000000000000000;
	// 	    end
	//     else
	// 	    begin
	// 		    case(Next_State) 
	// 			    2'b00:
	// 				    if(sw_in!=16'b0000000000000000)
	// 					    begin
	// 						    Next_State<= 2'b01;
	// 						    SW_Flag<= 1'b1;
	// 						    SW_Temp<= sw_in;
	// 					    end//�?测到有输入，则计数器标志位置1�?始计数，同时进行缓存，同时进行状态的跳转
	// 					else
	// 					    begin
	// 						    Next_State<= 2'd00;
	// 						    SW_Temp<= 16'b0000000000000000;
	// 						    SW_Flag<= 1'b0;
	// 					    end//�?测到无输入，则计数器标志位置0不计数，同时缓存�?0，状态不�?
	// 			    2'b01:
	// 				    if(Time_20ms==1'b1 )//如果按键维持20ms
	// 				    	begin
	// 						    SW_Flag<= 1'b0;//结束计数
	// 						    Next_State<= 2'b10;//状�?�跳转至2状�??
	// 				    	end
	// 				    else
	// 				    	begin
	// 				    		SW_Temp<= sw_in;
	// 				    		if(sw_in!=SW_Temp)
	// 				    			begin
	// 				    				SW_Flag<=1'b0;
	// 				    				Next_State<= 2'b00;
	// 				    			end
	// 				    		else
	// 							    begin
	// 								    Next_State<= 2'b01;
	// 								    SW_Flag<= 1'b1;//置一，开始计�?
	// 							    end
	// 				    	end
	// 			    2'b10:
	// 				    if(sw_in!=SW_Temp || sw_in==16'b0000000000000000)//按键松开
	// 					    begin
	// 						    sw_out<= SW_Temp;    
	// 						    Next_State<= 2'b11;//�?测到按键松开，也即开关再次被拨动，则跳转�?3状�??
	// 					    end
	// 				    else
	// 					    begin 
	// 						    sw_out<= 16'b0000000000000000;
	// 						    Next_State<= 2'b10;
	// 					    end
	// 			    2'b11:
	// 			    	begin
	// 					    Next_State<= 2'b00;
	// 					    sw_out<= 16'b0000000000000000;
	// 			    	end
	// 			    default:
    //                 Next_State<= 2'd0;
	// 		    endcase
	// 			sw_out <= SW_Temp;
	// 		 end
			 
	// always @ ( posedge clk or negedge rst_n )
	// 	if(!rst_n)
	// 	    begin
	// 		    Time_20ms<=1'b0;
	// 		    SW_Counter<=28'd0;
	// 	    end
	// 	else if(SW_Flag==1'b1)
	// 	    if(SW_Counter==28'd100000)//计数到达100000ns到达消抖时间
	// 		    begin
	// 			    Time_20ms<=1'b1;
	// 			    SW_Counter<=28'd0;
	// 		    end
	// 	    else
	// 		    begin
	// 			    Time_20ms<=1'b0;
	// 			    SW_Counter<=SW_Counter+1'd1;//
	// 		    end
	// 	else
	// 	    begin
	// 		    Time_20ms<=1'b0;
	// 		    SW_Counter<=28'd0;
	//     	end
			
endmodule