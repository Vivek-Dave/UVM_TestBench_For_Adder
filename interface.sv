interface intf(input bit clk);
    // ------------------- port declaration-------------------------------------
    parameter N=4;

    logic [N-1:0] in1;
    logic [N-1:0] in2;
    logic [N:0]   out;
    logic rst;
    //--------------------------------------------------------------------------

    //------------- clocking & modport declaration -----------------------------
   /* clocking Clk_Blk @(posedge clk);
      default input #1step output #1step;
      output in1,in2;   //input of DUT
      input  out;       //output of DUT
    endclocking
  */
    //modport modport_name(clocking name_of_block);
    //--------------------------------------------------------------------------
        
  
  property p1;
    disable iff(rst==1)
    @(posedge clk) (out==in1+in2);
  endproperty
  
  ASSERT:assert property(p1) $display("------------ PASS -------------");
    else $display("---------- FAIL -------------");
endinterface

