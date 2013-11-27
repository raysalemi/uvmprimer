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
class driver extends uvm_component;
   `uvm_component_utils(driver)

   virtual tinyalu_bfm bfm;

   uvm_get_port #(command_s) command_port;
   
   function void build_phase(uvm_phase phase);
      if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
        $fatal("Failed to get BFM");
      command_port = new("command_port",this);
   endfunction : build_phase

   task run_phase(uvm_phase phase);
      command_s    command;
      shortint     result;
      
      forever begin : command_loop
         command_port.get(command);
         bfm.send_op(command.A, command.B, command.op, result);
      end : command_loop
   endtask : run_phase

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : driver

