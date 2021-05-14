`include "ut_sequence_item.sv"
`include "ut_sequence.sv"
`include "ut_sequencer.sv"
`include "ut_driver.sv"
`include "ut_monitor.sv"

class ut_agent extends uvm_agent;
  ut_sequencer ut_seqr;
  ut_driver ut_dri;
  ut_monitor ut_mon;
  `uvm_component_utils(ut_agent)
  
  function new(string name = "ut_agent", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(get_is_active() == UVM_ACTIVE) begin
      ut_seqr = ut_sequencer::type_id::create("ut_seqr", this);
      ut_dri = ut_driver::type_id::create("ut_dri", this);
    end
    ut_mon = ut_monitor::type_id::create("ut_mon", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    if(get_is_active() == UVM_ACTIVE)
      ut_dri.seq_item_port.connect(ut_seqr.seq_item_export);
  endfunction
  
endclass
    
    