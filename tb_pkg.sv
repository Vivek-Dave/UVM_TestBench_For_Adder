
`ifndef TB_PKG
`define TB_PKG
`include "uvm_macros.svh"
package tb_pkg;
 import uvm_pkg::*;
 `include "adder_sequence_item.sv"        // transaction class
 `include "adder_sequence.sv"             // sequence class
 `include "adder_sequencer.sv"            // sequencer class
 `include "adder_driver.sv"               // driver class
 `include "adder_monitor.sv"
 `include "adder_agent.sv"                // agent class  
 `include "adder_coverage.sv"             // coverage class
 `include "adder_scoreboard.sv"           // scoreboard class
 `include "adder_env.sv"                  // environment class

 `include "adder_test.sv"                      // test

endpackage
`endif 


