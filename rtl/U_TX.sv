module U_TX(clk, rst_n, tx_trigger, tx_din, tx, tx_busy, tx_done);
  input clk;
  input rst_n;
  input tx_trigger;
  input [7:0] tx_din;
  output reg tx;
  output reg tx_busy;
  output reg tx_done;
  
  parameter clk_rate = 50000000;
  parameter baud_rate = 115200;
  parameter clk_div = clk_rate / baud_rate;
  
  parameter TX_IDLE = 0, TX_START = 1, TX_DATA = 2, TX_STOP = 3, TX_DONE = 4;
  
  reg [2:0] tx_state;
  reg [16:0] clk_cnt;
  reg [2:0] data_index;
  reg [7:0] tmp_data;
  
  always@(posedge clk or negedge rst_n)begin
    if(rst_n == 0)begin
      tmp_data <= 0;
      tx_busy <= 0;
      tx_done <= 0;
      tx_state <= TX_IDLE;
    end
    else begin
      case(tx_state)
          
        TX_IDLE:
          begin
            tx_done <= 0;
            clk_cnt <= 0;
            data_index <= 0;
            tx <= 1;
            if(tx_trigger == 1)begin
              tx_busy <= 1;
              tx_state <= TX_START;
            end
            else begin
              tx_state <= TX_IDLE;
            end
          end
          
        TX_START:
          begin
            tmp_data <= tx_din;
            tx <= 0;
            if(clk_cnt == clk_div - 1)begin
              clk_cnt <= 0;
              tx_state <= TX_DATA;
            end
            else begin
              clk_cnt <= clk_cnt + 1;
              tx_state <= TX_START;
            end
          end
          
        TX_DATA:
          begin
            tx <= tmp_data[data_index];
            if(clk_cnt == clk_div - 1)begin
              clk_cnt <= 0;
              if(data_index == 7)begin
                data_index <= 0;
                tx_state <= TX_STOP;
              end
              else begin
                data_index <= data_index + 1;
                tx_state <= TX_DATA;
              end
            end
            else begin
              clk_cnt <= clk_cnt + 1;
            end
          end
          
        TX_STOP:
          begin
            tx <= 1;
            if(clk_cnt == clk_div - 1)begin
              clk_cnt <= 0;
              tx_done <= 1;
              tx_busy <= 0;
              tx_state <= TX_DONE;
            end
            else begin
              clk_cnt <= clk_cnt + 1;
              tx_state <= TX_STOP;
            end
          end
          
        TX_DONE:
          begin
            tx_state <= TX_IDLE;
          end
          
        default: tx_state <= TX_IDLE;
          
      endcase
    end
  end
  
endmodule

  
