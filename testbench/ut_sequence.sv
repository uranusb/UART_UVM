class ut_sequence extends uvm_sequence#(ut_sequence_item);
  ut_sequence_item req;
  `uvm_object_utils(ut_sequence)
  
  function new(string name = "ut_sequence");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(5)begin
      req = ut_sequence_item::type_id::create("req");
      start_item(req);
      assert(req.randomize())
        else `uvm_fatal(get_type_name(), "Randomization Failed!")
      finish_item(req);
    end
  endtask
  
endclass
      
  
  
  