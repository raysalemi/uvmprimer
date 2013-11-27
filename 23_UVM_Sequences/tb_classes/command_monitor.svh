/*
   Copyright 2013 Ray Salemi

   Licensed under the Apache License, Version 2.0 (the "License");
   you may not use this file except in compliance with the License.
   You may obtain a copy of the License at

       http://www.apache.org/licenses/LICENSE-2.0

   Unless required by applicable law or agreed to in writing, software
   distributed under the License is distributed on an "AS IS" BASIS,
   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
   See the License for the specific language governing permissions and
   limitations under the License.
*/
class command_monitor extends uvm_component;
   `uvm_component_utils(command_monitor);

   virtual tinyalu_bfm bfm;
   uvm_analysis_port #(sequence_item) ap;

   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction

   function void build_phase(uvm_phase phase);

      if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
        `uvm_fatal("DRIVER", "Failed to get BFM")

      ap  = new("ap",this);
   endfunction : build_phase

   function void connect_phase(uvm_phase phase);
      bfm.command_monitor_h = this;
   endfunction : connect_phase

   function void write_to_monitor(byte A, byte B, operation_t op);
      sequence_item cmd;
      `uvm_info ("COMMAND MONITOR", $sformatf("MONITOR: A: %2h  B: %2h  op: %s",
                A, B, op.name()), UVM_HIGH);
      cmd = new("cmd");
      cmd.A = A;
      cmd.B = B;
      cmd.op = op;
      ap.write(cmd);
   endfunction : write_to_monitor
endclass : command_monitor


  