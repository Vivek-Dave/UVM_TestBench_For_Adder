
/***************************************************
  analysis_port from driver
  analysis_port from monitor
***************************************************/

`uvm_analysis_imp_decl( _drv )
`uvm_analysis_imp_decl( _mon )

class adder_scoreboard extends uvm_scoreboard;
  
  `uvm_component_utils(adder_scoreboard)
  
  uvm_analysis_imp_drv #(adder_sequence_item, adder_scoreboard) aport_drv;
  uvm_analysis_imp_mon #(adder_sequence_item, adder_scoreboard) aport_mon;
  
  uvm_tlm_fifo #(adder_sequence_item) expfifo;
  uvm_tlm_fifo #(adder_sequence_item) outfifo;
  
  int VECT_CNT, PASS_CNT, ERROR_CNT;
  reg [5:0]t_out,past_out;
  reg [4:0]t_in1,t_in2;


  function new(string name="adder_scoreboard",uvm_component parent);
    super.new(name,parent);
  endfunction
    
  function void build_phase(uvm_phase phase);
	super.build_phase(phase);
	  aport_drv = new("aport_drv", this);
	  aport_mon = new("aport_mon", this);
	  expfifo= new("expfifo",this);
	  outfifo= new("outfifo",this);
  endfunction


  function void write_drv(adder_sequence_item tr);
    `uvm_info("write_drv STIM", tr.input2string(), UVM_MEDIUM)
    if(tr.rst==1) 
      begin 
        t_out=0;
      end
    else 
      begin
    	t_in1=tr.in1;
    	t_in2=tr.in2;
    	t_out=t_in1+t_in2;
      end
     tr.out = t_out;
    void'(expfifo.try_put(tr));
  endfunction

  function void write_mon(adder_sequence_item tr);
    `uvm_info("write_mon OUT ", tr.convert2string(), UVM_MEDIUM)
    void'(outfifo.try_put(tr));
  endfunction
  
  task run_phase(uvm_phase phase);
	adder_sequence_item exp_tr, out_tr;
	forever begin
	    `uvm_info("scoreboard run task","WAITING for expected output", UVM_DEBUG)
	    expfifo.get(exp_tr);
	    `uvm_info("scoreboard run task","WAITING for actual output", UVM_DEBUG)
	    outfifo.get(out_tr);
        
        if (out_tr.out == exp_tr.out) begin
            PASS();
           `uvm_info ("PASS ",out_tr.convert2string() , UVM_MEDIUM)
	      end
      
      	else begin
	        ERROR();
          `uvm_info ("ERROR [ACTUAL_OP]",out_tr.convert2string() , UVM_MEDIUM)
          `uvm_info ("ERROR [EXPECTED_OP]",exp_tr.convert2string() , UVM_MEDIUM)
          `uvm_warning("ERROR",exp_tr.convert2string())
	      end
    end
  endtask

  function void PASS();
	VECT_CNT++;
	PASS_CNT++;
  endfunction

  function void ERROR();
  	VECT_CNT++;
  	ERROR_CNT++;
  endfunction

endclass