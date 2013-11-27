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
class coverage extends uvm_subscriber#(int);
   `uvm_component_utils(coverage);
   int the_roll;

   covergroup dice_cg;
      coverpoint the_roll{
         bins  twod6[] = {2,3,4,5,6,7,8,9,10,11,12};}
   endgroup


   function new(string name, uvm_component parent = null);
      super.new(name,parent);
      dice_cg = new();
   endfunction : new
   

   function void write (int t);
      the_roll = t;
      dice_cg.sample();
   endfunction : write

   function void report_phase(uvm_phase phase);
      
     $display("\nCOVERAGE: %2.0f%% ", dice_cg.get_coverage());
   endfunction : report_phase
endclass : coverage

   
      