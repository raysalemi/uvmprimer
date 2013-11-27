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
class driver extends uvm_driver #(sequence_item);
   `uvm_component_utils(driver)

   virtual tinyalu_bfm bfm;
 
   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
        `uvm_fatal("DRIVER", "Failed to get BFM")
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      sequence_item cmd;

      forever begin : cmd_loop
         shortint unsigned result;
         seq_item_port.get_next_item(cmd);
         bfm.send_op(cmd.A, cmd.B, cmd.op, result);
         cmd.result = result;
         seq_item_port.item_done();
      end : cmd_loop
   endtask : run_phase
   
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
endclass : driver


