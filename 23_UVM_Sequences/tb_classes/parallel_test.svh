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
class parallel_test extends tinyalu_base_test;
   `uvm_component_utils(parallel_test);

   parallel_sequence parallel_h;
      
   function new(string name, uvm_component parent);
      super.new(name,parent);
      parallel_h = new("parallel_h");
   endfunction : new

   task run_phase(uvm_phase phase);
      phase.raise_objection(this);
      parallel_h.start(sequencer_h);
      phase.drop_objection(this);
   endtask : run_phase

endclass


