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
class communication_test extends uvm_test;
   `uvm_component_utils(communication_test)
   
   producer producer_h;
   consumer consumer_h;
   uvm_tlm_fifo #(int) fifo_h;

   function void build_phase(uvm_phase phase);
      producer_h = new("producer_h", this);
      consumer_h = new("consumer_h", this);
      fifo_h = new("fifo_h",this);
   endfunction : build_phase

   function new(string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void connect_phase(uvm_phase phase);
      producer_h.put_port_h.connect(fifo_h.put_export);
      consumer_h.get_port_h.connect(fifo_h.get_export);

   endfunction : connect_phase
endclass : communication_test

