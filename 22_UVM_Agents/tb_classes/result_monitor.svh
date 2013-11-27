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

   virtual tinyalu_bfm bfm;
   uvm_analysis_port #(result_transaction) ap;

   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      tinyalu_agent_config tinyalu_agent_config_h;
      if(!uvm_config_db #(tinyalu_agent_config)::get(this, "","config", tinyalu_agent_config_h))
	`uvm_fatal("RESULT MONITOR", "Failed to get CONFIG");

      tinyalu_agent_config_h.bfm.result_monitor_h = this;
      ap  = new("ap",this);
   endfunction : build_phase

   function void write_to_monitor(shortint r);
      result_transaction result_t;
      result_t = new("result_t");
      result_t.result = r;
      ap.write(result_t);
   endfunction : write_to_monitor
   
endclass : result_monitor






