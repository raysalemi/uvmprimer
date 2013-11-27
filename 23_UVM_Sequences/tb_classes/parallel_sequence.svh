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
class parallel_sequence extends uvm_sequence #(uvm_sequence_item);
   `uvm_object_utils(parallel_sequence);

   protected reset_sequence reset;
   protected short_random_sequence short_random;
   protected fibonacci_sequence fibonacci;

   function new(string name = "parallel_sequence");
      super.new(name);
      reset = reset_sequence::type_id::create("reset");
      fibonacci = fibonacci_sequence::type_id::create("fibonacci");
      short_random = short_random_sequence::type_id::create("short_random");
   endfunction : new

   task body();
      reset.start(m_sequencer);
      fork
	    fibonacci.start(m_sequencer);
   	    short_random.start(m_sequencer);
      join
   endtask : body
endclass : parallel_sequence

     