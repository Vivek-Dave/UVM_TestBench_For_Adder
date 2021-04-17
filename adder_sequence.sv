
/***************************************************
** class name  : adder_sequence
** description : generate random inputs i.e, in1 
                 and in2
***************************************************/
class adder_sequence extends uvm_sequence#(adder_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_object_utils(adder_sequence)            
  //----------------------------------------------------------------------------

  adder_sequence_item txn;
  longint loop_count=20;

  //----------------------------------------------------------------------------
  function new(string name="adder_sequence");  
    super.new(name);
  endfunction
  //----------------------------------------------------------------------------

  //----------------------------------------------------------------------------
  virtual task body();
    repeat(loop_count)
      begin
        txn=adder_sequence_item::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize());
        txn.rst=0;
        finish_item(txn);
      end  
  endtask:body
  //----------------------------------------------------------------------------
endclass:adder_sequence

/***************************************************
** class name  : adder_add_zero_in1
** description : add value 0 , in1 reamains 0 
***************************************************/
class adder_add_zero_in1 extends adder_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(adder_add_zero_in1)      
  //----------------------------------------------------------------------------
  
  adder_sequence_item txn;
  longint loop_count=30;
  
  //----------------------------------------------------------------------------
  function new(string name="adder_add_zero_in1");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(loop_count)
      begin
        txn=adder_sequence_item::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{txn.in1==0;});
         txn.rst=0;
        finish_item(txn);
      end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

/***************************************************
** class name  : adder_add_zero_in2
** description : add 0 , in2 remains 0
***************************************************/
class adder_add_zero_in2 extends adder_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(adder_add_zero_in2)      
  //----------------------------------------------------------------------------
  
  adder_sequence_item txn;
  longint loop_count=30;
  
  //----------------------------------------------------------------------------
  function new(string name="adder_add_zero_in2");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(loop_count)
      begin
        txn=adder_sequence_item::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{txn.in2==0;});
         txn.rst=0;
        finish_item(txn);
      end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass


/***************************************************
** class name  : add_F
** description : in1 and in2 are F(4'b1111)
***************************************************/
class add_F extends adder_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(add_F)      
  //----------------------------------------------------------------------------
  
  adder_sequence_item txn;
  longint loop_count=30;
  
  //----------------------------------------------------------------------------
  function new(string name="add_F");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
    repeat(loop_count)
      begin
        txn=adder_sequence_item::type_id::create("txn");
        start_item(txn);
        assert(txn.randomize()with{txn.in1=='b1111; txn.in2=='b1111;});
         txn.rst=0;
        finish_item(txn);
      end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass



class reset extends adder_sequence;
  //----------------------------------------------------------------------------   
  `uvm_object_utils(reset)      
  //----------------------------------------------------------------------------
  
  adder_sequence_item txn;
  
  //----------------------------------------------------------------------------
  function new(string name="reset");
      super.new(name);
  endfunction
  //----------------------------------------------------------------------------
  
  //----------------------------------------------------------------------------
  task body();
      begin
        txn=adder_sequence_item::type_id::create("txn");
        start_item(txn);
        txn.rst=1;
        txn.in1=0;
        txn.in2=0;
        #3;
        finish_item(txn);
      end
  endtask:body
  //----------------------------------------------------------------------------
  
endclass

