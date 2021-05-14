import uvm_pkg::*;
`include "uvm_macros.svh"
`include "ut_interface.sv"
`include "ut_test.sv"

module tb;
  bit clk;
  bit rst_n;
  
  always #5 clk = ~clk;
  
  ut_interface tif(clk, rst_n);
  
  UART dut(
    .clk(tif.clk),
    .rst_n(tif.rst_n),
    .tx_trigger(tif.tx_trigger),
    .tx_din(tif.tx_din),
    .tx_busy(tif.tx_busy),
    .tx_done(tif.tx_done),
    .rx_dout(tif.rx_dout),
    .rx_comp(tif.rx_comp));
  
  initial begin
    rst_n = 0;
    @(posedge clk);
    rst_n = 1;
  end
  
  initial begin
    uvm_config_db#(virtual ut_interface)::set(null, "", "vif", tif);
    $dumpfile("dump.vcd"); 
    $dumpvars(0, dut);
    run_test("ut_test");
  end
endmodule
