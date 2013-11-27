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
class runall_sequence extends tinyalu_sequence;
   `uvm_object_utils(tinyalu_runall_sequence);

   reset_sequence reset;
   maxmult_sequence maxmult;
   random_sequence random;
   
   task body();
      reset = reset_sequence::type_id::create("reset");
      maxmult = maxmult_sequence::type_id::create("maxmult");
      random = random_sequence::type_id::create("random");

      reset.start(m_sequencer);
      maxmult.start(m_sequencer);
      random.start(m_sequencer);
   endtask : body
endclass : tinyalu_runall_sequence

     