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
class runall_sequence extends uvm_sequence #(uvm_sequence_item);
   `uvm_object_utils(runall_sequence);

   protected reset_sequence reset;
   protected maxmult_sequence maxmult;
   protected random_sequence random;
   protected sequencer sequencer_h;
   protected uvm_component uvm_component_h;
   
 function new(string name = "runall_sequence");
   super.new(name);
    
    uvm_component_h =  uvm_top.find("*.env_h.sequencer_h");

    if (uvm_component_h == null)
     `uvm_fatal("RUNALL SEQUENCE", "Failed to get the sequencer")

    if (!$cast(sequencer_h, uvm_component_h))
      `uvm_fatal("RUNALL SEQUENCE", "Failed to cast from uvm_component_h.")
      
      
    reset = reset_sequence::type_id::create("reset");
    maxmult = maxmult_sequence::type_id::create("maxmult");
    random = random_sequence::type_id::create("random");
 endfunction : new

 task body();
    reset.start(sequencer_h);
    maxmult.start(sequencer_h);
    random.start(sequencer_h);
 endtask : body
   
endclass : runall_sequence



