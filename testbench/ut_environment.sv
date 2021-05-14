`include "ut_agent.sv"
`include "ut_scoreboard.sv"

class ut_environment extends uvm_env;
  ut_agent ut_agt;
  ut_scoreboard ut_scb;
  `uvm_component_utils(ut_environment)
  
  function new(string name = "ut_environment", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ut_agt = ut_agent::type_id::create("ut_agt", this);
    ut_scb = ut_scoreboard::type_id::create("ut_scb", this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    ut_agt.ut_mon.item_din_port.connect(ut_scb.item_din_export);
    ut_agt.ut_mon.item_dout_port.connect(ut_scb.item_dout_export);
  endfunction
  
endclass