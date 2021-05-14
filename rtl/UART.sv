`include "U_TX.sv"
`include "U_RX.sv"

module UART (clk, rst_n, tx_trigger, tx_din, tx_busy, tx_done, rx_dout, rx_comp);
  input clk;
  input rst_n;
  input tx_trigger;
  input [7:0] tx_din;
  output reg tx_busy;
  output reg tx_done;
  output reg [7:0] rx_dout;
  output reg rx_comp;
  
  wire tx_rx;

  U_TX tx_int(
    .clk(clk),
    .rst_n(rst_n),
    .tx_trigger(tx_trigger),
    .tx_din(tx_din),
    .tx(tx_rx),
    .tx_busy(tx_busy),
    .tx_done(tx_done)
  );

  U_RX rx_int(
    .clk(clk),
    .rst_n(rst_n),
    .rx(tx_rx),
    .rx_dout(rx_dout),
    .rx_comp(rx_comp)
  );
  
endmodule