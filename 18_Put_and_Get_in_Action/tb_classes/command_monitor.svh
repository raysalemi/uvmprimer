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
class command_monitor extends uvm_component;
   `uvm_component_utils(command_monitor);
   
   uvm_analysis_port #(command_s) ap;
   
   function void build_phase(uvm_phase phase);
      virtual tinyalu_bfm bfm;
   
   if(!uvm_config_db #(virtual tinyalu_bfm)::get(null, "*","bfm", bfm))
     $fatal("Failed to get BFM");
   
   bfm.command_monitor_h = this;
   
   ap  = new("ap",this);
   
endfunction : build_phase
   
   function void write_to_monitor(command_s cmd);
      $display("COMMAND MONITOR: A:0x%2h B:0x%2h op: %s", cmd.A, cmd.B, cmd.op.name());
      ap.write(cmd);
   endfunction : write_to_monitor
   
   
   function operation_t op2enum(bit[2:0] op);
      case(op)
        3'b000 : return no_op;
        3'b001 : return add_op;
        3'b010 : return and_op;
        3'b011 : return xor_op;
        3'b100 : return mul_op;
        3'b111 : return rst_op;
        default : $fatal($sprintf("Illegal operation on op bus: %3b",op));
      endcase // case (op)
   endfunction : op2enum
   
   function new (string name, uvm_component parent);
      super.new(name,parent);
   endfunction
   
endclass : command_monitor

  