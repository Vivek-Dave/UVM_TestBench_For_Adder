class adder_sequence_item extends uvm_sequence_item;

  //------------ i/p || o/p field declaration----------------------------------
  parameter N=4;
   
  rand logic [N-1:0]in1;  //i/p
  rand logic [N-1:0]in2;

  logic [N:0]out;        //o/p
  logic rst;
  
  //---------------- register adder_sequence_item class with factory ----------
  `uvm_object_utils_begin(adder_sequence_item) 
     `uvm_field_int( in1 ,UVM_ALL_ON)
     `uvm_field_int( in2 ,UVM_ALL_ON)
     `uvm_field_int( out ,UVM_ALL_ON)
     `uvm_field_int( rst ,UVM_ALL_ON)
  `uvm_object_utils_end
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  function new(string name="adder_sequence_item");
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  // write DUT inputs here for printing
  function string input2string();
    return($sformatf("in1=%4b  in2=%4b rst=%0b", in1,in2,rst));
  endfunction
  
  // write DUT outputs here for printing
  function string output2string();
    return($sformatf("out=%5h ", out));
  endfunction
    
  function string convert2string();
    return($sformatf({input2string(), "  ", output2string()}));
  endfunction
  //----------------------------------------------------------------------------

endclass:adder_sequence_item
