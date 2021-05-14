class ut_sequencer extends uvm_sequencer#(ut_sequence_item);
  `uvm_component_utils(ut_sequencer)
  
  function new(string name = "ut_sequencer", uvm_component parent);
    super.new(name, parent);
  endfunction
  
endclass