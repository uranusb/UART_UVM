class ut_monitor extends uvm_monitor;
  ut_sequence_item item_din;
  ut_sequence_item item_dout;
  virtual ut_interface vif;
  uvm_analysis_port#(ut_sequence_item) item_din_port; 
  uvm_analysis_port#(ut_sequence_item) item_dout_port;
  `uvm_component_utils(ut_monitor)
  
  function new(string name = "ut_monitor", uvm_component parent);
    super.new(name, parent);
    item_din_port = new("item_din_port", this);
    item_dout_port = new("item_dout_port", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    item_din = ut_sequence_item::type_id::create("item_din", this);
    item_dout = ut_sequence_item::type_id::create("item_dout", this);
    uvm_config_db#(virtual ut_interface)::get(this, "", "vif", vif);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      fork
        get_din();
        get_dout();
      join
    end
  endtask
  
  virtual task get_din();
    //!!!
    @(posedge vif.mon_mp.clk)
    @(posedge vif.mon_mp.clk)
    @(posedge vif.mon_mp.clk)
    item_din.tx_trigger = vif.mon_mp.mon_cb.tx_trigger;
    item_din.tx_din = vif.mon_mp.mon_cb.tx_din;
    $display("MON: tx_din:", vif.mon_mp.mon_cb.tx_din);
    @(posedge vif.mon_mp.mon_cb.tx_done);
    item_din_port.write(item_din);
  endtask
  
  virtual task get_dout();
    @(posedge vif.mon_mp.mon_cb.rx_comp);
    item_dout.rx_comp = vif.mon_mp.mon_cb.rx_comp;
    @(posedge vif.mon_mp.mon_cb.tx_done);
    item_dout.rx_dout = vif.mon_mp.mon_cb.rx_dout;
    $display("MON: rx_dout:", vif.mon_mp.mon_cb.rx_dout);
    item_dout_port.write(item_dout);
  endtask
  
endclass
  
  