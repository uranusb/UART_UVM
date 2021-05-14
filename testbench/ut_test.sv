`include "ut_environment.sv"

class ut_test extends uvm_test;
  ut_sequence ut_seq;
  ut_environment ut_env;
  `uvm_component_utils(ut_test)
  
  function new(string name = "ut_test", uvm_component parent);
    super.new(name, parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    ut_seq = ut_sequence::type_id::create("ut_seq", this);
    ut_env = ut_environment::type_id::create("ut_env", this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    phase.raise_objection(this);
    ut_seq.start(ut_env.ut_agt.ut_seqr);
    phase.drop_objection(this);
  endtask
  
endclass
