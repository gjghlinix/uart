module  tb_uart_tx();

reg             sys_clk;
reg             sys_rst_n;
reg    [7:0]    pi_data;
reg             pi_flag;

wire            tx;

//初始化输入参数
initial
    begin
	    sys_clk   <= 1'b1;
		sys_rst_n <= 1'b0;
		#20
		sys_rst_n <= 1'b1;
	end


//产生时钟
always  #10 sys_clk = ~sys_clk;

initial
    begin
	    pi_data <= 8'd0;
		pi_flag <= 1'b0;
		#200                //保持空闲状态
		//发送数据0
		pi_data <= 8'd0;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期，10bit,20ns
		
		//发送数据1
		pi_data <= 8'd1;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期，10bit,20ns
		
		//发送数据2
		pi_data <= 8'd2;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期，10bit,20ns
		
		//发送数据3
		pi_data <= 8'd3;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期，10bit,20ns
		
		//发送数据4
		pi_data <= 8'd4;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期，10bit,20ns
		
		//发送数据5
		pi_data <= 8'd5;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期，10bit,20ns
		
		//发送数据6
		pi_data <= 8'd6;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低
		#(5208*10*20)         //5208个时钟周期,10bit,20ns
		
		//发送数据7
		pi_data <= 8'd7;
		pi_flag <= 1'b1;
		#20                 //20ns对应50MHz的一个时钟周期
		pi_flag <= 1'b0;    //一个周期的高电平之后拉低

	end



uart_tx  
#(
    .UART_BPS (9600),
	.CLK_FREQ (50_000_000)
)
uart_tx_inst
(
     .sys_clk   (sys_clk),
	 .sys_rst_n (sys_rst_n),
	 .pi_data   (pi_data),
     .pi_flag   (pi_flag), 

	 .tx        (tx)
);

endmodule 
