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
class fibonacci_sequence extends uvm_sequence #(sequence_item);
   `uvm_object_utils(fibonacci_sequence);

   function new(string name = "fibonacci");
      super.new(name);
   endfunction : new
   

   task body();
      byte unsigned n_minus_2=0;
      byte unsigned n_minus_1=1;
      sequence_item command;
      
      command = sequence_item::type_id::create("command");
         
      start_item(command);
      command.op = rst_op;
      finish_item(command);

      `uvm_info("FIBONACCI", " Fib(01) = 00", UVM_MEDIUM);
      `uvm_info("FIBONACCI", " Fib(02) = 01", UVM_MEDIUM);
      for(int ff = 3; ff<=14; ff++) begin
       start_item(command);
       command.A = n_minus_2;
       command.B = n_minus_1;
       command.op = add_op;
       finish_item(command);
       n_minus_2 = n_minus_1;
       n_minus_1 = command.result;
       `uvm_info("FIBONACCI", $sformatf("Fib(%02d) = %02d", ff, n_minus_1),
                 UVM_MEDIUM);
      end 
   endtask : body
endclass : fibonacci_sequence



