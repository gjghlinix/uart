module   uart_tx
#(
    parameter  UART_BPS =  'd9600,
	parameter  CLK_FREQ =  'd50_000_000
)
(
     input   wire        sys_clk   ,
	 input   wire        sys_rst_n ,
	 input   wire  [7:0] pi_data   ,
	 input   wire        pi_flag  ,                 
	 
	 output  reg         tx
	
);

reg          work_en;
reg  [15:0]  baud_cnt;
reg          bit_flag;
reg  [3:0]   bit_cnt;

parameter  BAUD_CNT = CLK_FREQ / UART_BPS;

//work_en
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    work_en <= 1'b0;
	else if(pi_flag == 1'b1)
	    work_en <= 1'b1;
	else if((bit_cnt == 4'd9) && (bit_flag == 1'b1))
	    work_en <= 1'b0;
	else
	    work_en <= work_en;

//*******************baud_cnt波特率计数器******************//
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    baud_cnt <= 16'd0;
	else if((baud_cnt == BAUD_CNT - 1'b1) || (work_en ==  1'b0))
        baud_cnt <= 16'd0;
	else
	    baud_cnt <= baud_cnt + 1'b1;

//*******************bit_flag比特标志信号******************//
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    bit_flag <= 1'b0;
	else if(baud_cnt == 16'd1)
	    bit_flag <= 1'b1;
	else
	    bit_flag <= 1'b0;

//*******************bit_cnt比特计数器******************//
always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    bit_cnt <= 4'd0;
    else if((bit_cnt == 4'd9) && (bit_flag == 1'b1))
	    bit_cnt <= 4'd0;
	else if((bit_flag == 1'b1) && (work_en ==1'b1))
	    bit_cnt <= bit_cnt +1'b1;
	else
	    bit_cnt <= bit_cnt;


always@(posedge sys_clk or negedge sys_rst_n)
    if(sys_rst_n == 1'b0)
	    tx <= 1'd1;
	else if(bit_flag == 1'b1)
	    case(bit_cnt)
		    0: tx <= 1'b0;//起始态
			1: tx <= pi_data[0];
			2: tx <= pi_data[1];
			3: tx <= pi_data[2];
			4: tx <= pi_data[3];
			5: tx <= pi_data[4];
			6: tx <= pi_data[5];
			7: tx <= pi_data[6];
			8: tx <= pi_data[7];
			9: tx <= 1'b1;
			default: tx <= 1'b1;
		endcase


endmodule












