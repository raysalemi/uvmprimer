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
`ifdef QUESTA
virtual class base_tester extends uvm_component;
`else
class base_tester extends uvm_component;
`endif

`uvm_component_utils(base_tester)
   virtual tinyalu_bfm bfm;
   
   uvm_put_port #(command_s) command_port;

   function void build_phase(uvm_phase phase);
      command_port = new("command_port", this);
   endfunction : build_phase

   pure virtual function operation_t get_op();

   pure virtual function byte get_data();

   task run_phase(uvm_phase phase);
      byte         unsigned        iA;
      byte         unsigned        iB;
      operation_t                  op_set;
      command_s    command;
      
      phase.raise_objection(this);
      command.op = rst_op;
      command_port.put(command);
      repeat (1000) begin : random_loop
         command.op = get_op();
         command.A =  get_data();
         command.B =  get_data();
         command_port.put(command);
      end : random_loop
      #500;
      phase.drop_objection(this);
   endtask : run_phase

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : base_tester
