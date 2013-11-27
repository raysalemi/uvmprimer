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
class result_monitor extends uvm_component;
   `uvm_component_utils(result_monitor);

   uvm_analysis_port #(shortint) ap;

   function void write_to_monitor(shortint r);
      $display ("RESULT MONITOR: resultA: 0x%0h",r);
      ap.write(r);
   endfunction : write_to_monitor
   
   function void build_phase(uvm_phase phase);
    virtual tinyalu_bfm bfm;
    if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
       $fatal("Failed to get BFM");
    bfm.result_monitor_h = this;
    ap  = new("ap",this);
   endfunction : build_phase
   
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : result_monitor






