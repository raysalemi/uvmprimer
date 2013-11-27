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
class average extends uvm_subscriber #(int);
   `uvm_component_utils(average);

   real dice_total;
   real count;

   function new(string name, uvm_component parent = null);
      super.new(name,parent);
      dice_total = 0.0;
      count = 0.0;
   endfunction : new

   function void write(int t);
      dice_total = dice_total + t;
      count++;
   endfunction : write

   function void report_phase(uvm_phase phase);
      
      $display ("DICE AVERAGE: %2.1f",dice_total/count);
   endfunction : report_phase
   
endclass : average
