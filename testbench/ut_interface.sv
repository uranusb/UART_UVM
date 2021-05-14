interface ut_interface(input clk, rst_n);
  bit [7:0] tx_din; 
  bit tx_trigger;
  bit tx_busy;
  bit tx_done;
  bit [7:0] rx_dout;
  bit rx_comp;
  
  clocking dri_cb @(posedge clk);
    default input #1 output #1;
    output tx_din;
    output tx_trigger;
    input tx_busy;
    input tx_done;
    input rx_dout;
    input rx_comp;
  endclocking
  
  clocking mon_cb @(posedge clk);
    default input #1 output #1;
    input tx_din;
    input tx_trigger;
    input tx_busy;
    input tx_done;
    input rx_dout;
    input rx_comp;
  endclocking
  
  modport dri_mp (input clk, rst_n, clocking dri_cb);
  modport mon_mp (input clk, rst_n, clocking mon_cb);
  
endinterface
  
  