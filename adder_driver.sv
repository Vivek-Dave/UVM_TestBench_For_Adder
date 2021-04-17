
class adder_driver extends uvm_driver #(adder_sequence_item);
  //----------------------------------------------------------------------------
  `uvm_component_utils(adder_driver)
  //----------------------------------------------------------------------------
  uvm_analysis_port #(adder_sequence_item) drv2sb;

  //----------------------------------------------------------------------------
  function new(string name="",uvm_component parent);
    super.new(name,parent);
    drv2sb=new("drv2sb",this);
  endfunction
  //---------------------------------------------------------------------------- 

  //--------------------------  virtual interface handel -----------------------  
  virtual interface intf vif;
  //----------------------------------------------------------------------------
  
  //-------------------------  get interface handel from top -------------------
  function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    if(!(uvm_config_db#(virtual intf)::get(this,"","vif",vif))) begin
      `uvm_fatal(get_type_name(),"unable to get interface");
    end
  endfunction
  //----------------------------------------------------------------------------
  
  //---------------------------- run task --------------------------------------
  task run_phase(uvm_phase phase);
    adder_sequence_item txn;
    forever begin
      seq_item_port.get_next_item(txn);
      @(posedge vif.clk);  // or vif.Clk_Blk.clk
      vif.in1 <= txn.in1;
      vif.in2 <= txn.in2;
      vif.rst <= txn.rst;
      drv2sb.write(txn);
      seq_item_port.item_done();    
    end
  endtask
  //----------------------------------------------------------------------------
  
endclass:adder_driver

