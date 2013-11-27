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
class consumer extends uvm_component;
   `uvm_component_utils(consumer);

   uvm_get_port #(int) get_port_h;
   int shared;

   function void build_phase(uvm_phase phase);
      get_port_h = new("get_port_h", this);
   endfunction : build_phase


   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   task run_phase(uvm_phase phase);
      forever begin
         get_port_h.get(shared);
         $display("Received: %0d", shared);
      end
   endtask : run_phase
endclass : consumer

   