class ut_driver extends uvm_driver#(ut_sequence_item);
  ut_sequence_item req;
  virtual ut_interface vif;
  `uvm_component_utils(ut_driver)
  
  function new(string name = "ut_driver", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!uvm_config_db#(virtual ut_interface)::get(this, "", "vif", vif))
      `uvm_fatal("Driver: ", "No vif is found!")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      seq_item_port.get_next_item(req);
      @(posedge vif.dri_mp.clk);
      vif.dri_mp.dri_cb.tx_trigger <= req.tx_trigger;
      vif.dri_mp.dri_cb.tx_din <= req.tx_din;
      @(posedge vif.dri_mp.dri_cb.rx_comp);
      @(posedge vif.dri_mp.dri_cb.tx_done);
      seq_item_port.item_done();
    end
  endtask
    
endclass
    
    
    