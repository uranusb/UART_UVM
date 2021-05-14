class ut_sequence_item extends uvm_sequence_item;
  rand bit [7:0] tx_din; 
  bit tx_trigger = 1'b1;
  bit tx_busy;
  bit tx_done;
  bit [7:0] rx_dout;
  bit rx_comp;
  
  `uvm_object_utils_begin(ut_sequence_item)
  `uvm_field_int(tx_din, UVM_ALL_ON)
  `uvm_field_int(tx_trigger, UVM_ALL_ON)
  `uvm_field_int(tx_busy, UVM_ALL_ON)
  `uvm_field_int(tx_done,UVM_ALL_ON)
  `uvm_field_int(rx_dout, UVM_ALL_ON)
  `uvm_field_int(rx_comp, UVM_ALL_ON)
  `uvm_object_utils_end
  
  function new(string name = "ut_interface");
    super.new(name);
  endfunction
  
endclass
  
  
  