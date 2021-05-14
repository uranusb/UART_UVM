`uvm_analysis_imp_decl(_din)
`uvm_analysis_imp_decl(_dout)

class ut_scoreboard extends uvm_scoreboard;
  uvm_analysis_imp_din#(ut_sequence_item, ut_scoreboard) item_din_export;
  uvm_analysis_imp_dout#(ut_sequence_item, ut_scoreboard) item_dout_export;
  `uvm_component_utils(ut_scoreboard)
  
  function new(string name = "ut_scoreboard", uvm_component parent);
    super.new(name, parent);
    item_din_export = new("item_din_export", this);
    item_dout_export = new("item_dout_export", this);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
  endfunction
  
  int match, mismatch;
  
  bit [7:0] expect_dout;
  
  function void write_din(ut_sequence_item item_din);
    expect_dout = item_din.tx_din;
  endfunction
  
  function void write_dout(ut_sequence_item item_dout);
    if(expect_dout == item_dout.rx_dout)begin
      match = match + 1;
      $display("SCB: expected data: %2h, actual data: %2h", expect_dout, item_dout.rx_dout);
      $display("************		Match!		************");
      
    end
    else begin
      mismatch = mismatch + 1;
      $display("SCB: expected data: %2h, actual data: %2h", expect_dout, item_dout.rx_dout);
      $display("************		Mismatch!		************");
    end
  endfunction
  
  virtual function void report_phase(uvm_phase phase);
    `uvm_info(get_type_name(), $sformatf("Result: passed=%0d  failed=%0d\n", match, mismatch), UVM_NONE)
  endfunction
endclass
        