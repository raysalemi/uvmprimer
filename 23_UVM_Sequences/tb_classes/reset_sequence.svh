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
class reset_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(reset_sequence)

   sequence_item command;

   function new(string name = "reset");
      super.new(name);
   endfunction : new

   task body();
      command = sequence_item::type_id::create("command");
      start_item(command);
      command.op = rst_op;
      finish_item(command);
   endtask : body
endclass : reset_sequence












