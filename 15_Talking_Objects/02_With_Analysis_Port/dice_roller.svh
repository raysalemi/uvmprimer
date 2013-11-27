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
class dice_roller extends uvm_component;
   `uvm_component_utils(dice_roller);

   uvm_analysis_port #(int) roll_ap;

   function void build_phase (uvm_phase phase);
      
      roll_ap = new("roll_ap",this);
      
   endfunction : build_phase
   
   rand byte die1;
   rand byte die2;
   
   constraint d6 { die1 >= 1; die1 <= 6; 
                   die2 >= 1; die2 <= 6; }


   task run_phase(uvm_phase phase);
      int the_roll;
      phase.raise_objection(this);
      void'(randomize());
      repeat (20) begin
         void'(randomize());
         the_roll = die1 + die2;
         roll_ap.write(the_roll);
      end
      phase.drop_objection(this);
   endtask : run_phase
   


   function new(string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new
   
endclass : dice_roller


      

   