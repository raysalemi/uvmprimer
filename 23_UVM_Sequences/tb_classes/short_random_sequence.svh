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
class short_random_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(short_random_sequence);
   
   sequence_item command;

   function new(string name = "short_random_sequence");
      super.new(name);
   endfunction : new
   


   task body();
      repeat (14) begin : short_random_loop
         command = sequence_item::type_id::create("command");
         start_item(command);
         assert(command.randomize());
         finish_item(command);
// Moved relative to the book example so as to show result
    `uvm_info("SHORT RANDOM", $sformatf("random command: %s", command.convert2string), UVM_MEDIUM)
      end : short_random_loop
   endtask : body
endclass : short_random_sequence











