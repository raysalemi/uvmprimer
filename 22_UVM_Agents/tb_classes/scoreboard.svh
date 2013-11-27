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
class scoreboard extends uvm_subscriber #(result_transaction);
   `uvm_component_utils(scoreboard);


   uvm_tlm_analysis_fifo #(command_transaction) cmd_f;
   
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

   function void build_phase(uvm_phase phase);
      cmd_f = new ("cmd_f", this);
   endfunction : build_phase

function result_transaction predict_result(command_transaction cmd);
   result_transaction predicted;
      
   predicted = new("predicted");
      
   case (cmd.op)
     add_op: predicted.result = cmd.A + cmd.B;
     and_op: predicted.result = cmd.A & cmd.B;
     xor_op: predicted.result = cmd.A ^ cmd.B;
     mul_op: predicted.result = cmd.A * cmd.B;
   endcase // case (op_set)

   return predicted;

endfunction : predict_result
   

   function void write(result_transaction t);
      string data_str;
      command_transaction cmd;
      result_transaction predicted;

      do
        if (!cmd_f.try_get(cmd))
          `uvm_fatal("SCOREBOARD", {"No command for result: ", t.convert2string()})
      while ((cmd.op == no_op) || (cmd.op == rst_op));

      predicted = predict_result(cmd);
      
      data_str = {                    cmd.convert2string(), 
                  " ==>  Actual "  ,    t.convert2string(), 
                  "/Predicted ",predicted.convert2string()};
                  
                  
      if (!predicted.compare(t))
        `uvm_error("SELF CHECKER", {"FAIL: ",data_str})
      else
        `uvm_info ("SELF CHECKER", {"PASS: ", data_str}, UVM_MEDIUM)

   endfunction : write
endclass : scoreboard






