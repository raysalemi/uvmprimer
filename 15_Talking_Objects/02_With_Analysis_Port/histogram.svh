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
class histogram extends uvm_subscriber #(int);
   `uvm_component_utils(histogram);

   int rolls[int];
   

   function new(string name, uvm_component parent);
      super.new(name,parent);
      for (int ii = 2; ii <= 12; ii++) rolls[ii] = 0;
   endfunction : new
   
   function void write(int t);
      rolls[t]++;
   endfunction : write


   function void report_phase(uvm_phase phase);
      string bar;
      string message;
      
      message = "\n";
      foreach (rolls[ii]) begin
         string roll_msg;
         bar = "";
         repeat (rolls[ii]) bar = {bar,"#"};
         roll_msg = $sformatf( "%2d: %s\n", ii, bar);
         message = {message,roll_msg};
      end
      $display(message);
   endfunction : report_phase
endclass : histogram
