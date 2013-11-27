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
class producer extends uvm_component;
   `uvm_component_utils(producer);

   int shared;
   uvm_put_port #(int) put_port_h;

   function void build_phase(uvm_phase phase);
      put_port_h = new("put_port_h", this);
   endfunction : build_phase
   
   
   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new
   
   
   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      repeat (3) begin
         put_port_h.put(++shared);
         $display("Sent %0d", shared);
      end
      phase.drop_objection(this);
   endtask : run_phase
endclass : producer

   