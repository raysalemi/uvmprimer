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
class random_test extends uvm_test;
   `uvm_component_utils(random_test);

 virtual tinyalu_bfm bfm;
   
   function new (string name, uvm_component parent);
      super.new(name,parent);
      if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
        $fatal("Failed to get BFM");
   endfunction : new


   task run_phase(uvm_phase phase);
      random_tester    random_tester_h;
      coverage  coverage_h;
      scoreboard scoreboard_h;

      phase.raise_objection(this);

      random_tester_h    = new(bfm);
      coverage_h  = new(bfm);
      scoreboard_h = new(bfm);
      
      fork
         coverage_h.execute();
         scoreboard_h.execute();
      join_none

      random_tester_h.execute();
      phase.drop_objection(this);
   endtask : run_phase

endclass
   