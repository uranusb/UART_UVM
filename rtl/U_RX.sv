module U_RX(clk, rst_n, rx, rx_dout, rx_comp);
  input clk;
  input rst_n;
  input rx;
  output reg [7:0] rx_dout;
  output reg rx_comp;
  
  parameter clk_rate = 50000000;
  parameter baud_rate = 115200;
  parameter clk_div = clk_rate / baud_rate;
  
  parameter RX_IDLE = 0, RX_START = 1, RX_DATA = 2, RX_STOP = 3, RX_DONE = 4; 
  
  reg [2:0] rx_state;
  reg [16:0] clk_cnt;
  reg [2:0] data_index;
  
  always@(posedge clk or negedge rst_n)begin
    if(rst_n == 0)begin
      rx_comp <= 0;
      rx_state <= RX_IDLE;
    end
    else begin 
      case(rx_state)
        
        RX_IDLE:
          begin
            rx_comp <= 0;
            clk_cnt <= 0;
            data_index <= 0;
            if(rx == 0)begin
              rx_state <= RX_START;
            end
            else begin
              rx_state <= RX_IDLE;
            end
          end
        
        RX_START:
          begin
            if(clk_cnt == (clk_div - 1) / 2)begin
              if(rx == 0)begin
                clk_cnt <= 0;
                rx_state <= RX_DATA;
              end
              else begin
                rx_state <= RX_IDLE;
              end
            end
            else begin
              clk_cnt <= clk_cnt + 1;
              rx_state <= RX_START;
            end
          end
        
        RX_DATA:
          begin
            if(clk_cnt == clk_div - 1) begin
              clk_cnt <= 0;
              rx_dout[data_index] <= rx;
              if(data_index == 7)begin
                data_index <= 0;
                rx_state <= RX_STOP;
              end
              else begin
                data_index <= data_index + 1;
                rx_state <= RX_DATA;
              end
            end
            else begin
              clk_cnt <= clk_cnt + 1;
              rx_state <= RX_DATA;
            end
          end
        
        RX_STOP:
          begin
            if(clk_cnt == clk_div - 1)begin
              rx_comp <= 1;
              clk_cnt <= 0;
              rx_state <= RX_DONE;
            end
            else begin
              clk_cnt <= clk_cnt + 1;
              rx_state <= RX_STOP;
            end
          end
        
        RX_DONE:
          begin
            rx_comp <= 0;
            rx_state <= RX_IDLE;
          end
        
        default: rx_state <= RX_IDLE;
        
      endcase
    end
  end
endmodule
  
