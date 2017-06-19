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
virtual class tinyalu_base_test extends uvm_test;
`else 
class tinyalu_base_test extends uvm_test;
`endif

   env       env_h;
   sequencer sequencer_h;
   
   function void build_phase(uvm_phase phase);
      env_h = env::type_id::create("env_h",this);
   endfunction : build_phase

   function void end_of_elaboration_phase(uvm_phase phase);
      sequencer_h = env_h.sequencer_h;
   endfunction : end_of_elaboration_phase

   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

endclass
   
   
   