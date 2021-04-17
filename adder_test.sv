
class adder_test extends uvm_test;

    //--------------------------------------------------------------------------
    `uvm_component_utils(adder_test)
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function new(string name="",uvm_component parent);
	    super.new(name,parent);
    endfunction
    //--------------------------------------------------------------------------

    adder_env env_h;
    int file_h;


    adder_sequence seq;
    adder_add_zero_in1 seq1_1;
    adder_add_zero_in1 seq1_2;

    adder_add_zero_in2 seq2_1;
    adder_add_zero_in2 seq2_2;

    add_F seq3_1;
    add_F seq3_2;
  
    reset rst;

    //--------------------------------------------------------------------------
    function void build_phase(uvm_phase phase);
      super.build_phase(phase);
      env_h = adder_env::type_id::create("env_h",this);

      seq=adder_sequence::type_id::create("seq");
      seq1_1=adder_add_zero_in1::type_id::create("seq1_1");
      seq1_2=adder_add_zero_in1::type_id::create("seq1_2");
      seq2_1=adder_add_zero_in2::type_id::create("seq2_1");
      seq2_2=adder_add_zero_in2::type_id::create("seq2_2");
      seq3_1=add_F::type_id::create("seq3_1");
      seq3_2=add_F::type_id::create("seq3_2");
      rst=reset::type_id::create("rst");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void end_of_elobartion_phase(uvm_phase phase);
      //super.end_of_elobartion_phase(phase);
      //factory.print();
      $display("End of eleboration phase in agent");
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    function void start_of_simulation_phase(uvm_phase phase);
      //super.start_of_simulation_phase(phase);
      $display("start_of_simulation_phase");
      file_h=$fopen("LOG_FILE.log","w");
      set_report_default_file_hier(file_h);
      set_report_severity_action_hier(UVM_INFO,UVM_DISPLAY+UVM_LOG);
      env_h.set_report_verbosity_level_hier(UVM_MEDIUM);
      seq.loop_count=100;
    endfunction
    //--------------------------------------------------------------------------

    //--------------------------------------------------------------------------
    task run_phase(uvm_phase phase);
	      phase.raise_objection(this);
           // seq.start(env_h.agent_h.sequencer_h);
            rst.start(env_h.agent_h.sequencer_h);
            seq.start(env_h.agent_h.sequencer_h);
            seq3_1.start(env_h.agent_h.sequencer_h);
            seq1_1.start(env_h.agent_h.sequencer_h);
            seq2_1.start(env_h.agent_h.sequencer_h);
            
            #10;
	      phase.drop_objection(this);
    endtask
    //--------------------------------------------------------------------------

endclass:adder_test

