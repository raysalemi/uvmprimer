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
class env extends uvm_env;
   `uvm_component_utils(env);

   tinyalu_agent        class_tinyalu_agent_h,  module_tinyalu_agent_h;
   tinyalu_agent_config class_config_h, module_config_h;
   
   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      virtual tinyalu_bfm class_bfm;
      virtual tinyalu_bfm module_bfm;
      env_config env_config_h;


      
      if(!uvm_config_db #(env_config)::get(this, "","config", env_config_h))
        `uvm_fatal("RANDOM TEST", "Failed to get CLASS BFM");
      
      class_config_h  = new(.bfm(env_config_h.class_bfm),  .is_active(UVM_ACTIVE));
      module_config_h = new(.bfm(env_config_h.module_bfm), .is_active(UVM_PASSIVE));
      
      uvm_config_db #(tinyalu_agent_config)::set(this, "class_tinyalu_agent_h*",  
                                                 "config", class_config_h);
      
      uvm_config_db #(tinyalu_agent_config)::set(this, "module_tinyalu_agent_h*", 
                                                 "config", module_config_h);



      class_tinyalu_agent_h  = new("class_tinyalu_agent_h",this);
      module_tinyalu_agent_h = new("module_tinyalu_agent_h",this);
      
   endfunction : build_phase
   
endclass

