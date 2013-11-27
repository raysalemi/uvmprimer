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
module top;
   import uvm_pkg::*;
   import   tinyalu_pkg::*;
`include "tinyalu_macros.svh"
`include "uvm_macros.svh"
   
 tinyalu_bfm       class_bfm();
   
 tinyalu class_dut (.A(class_bfm.A), .B(class_bfm.B), .op(class_bfm.op), 
                    .clk(class_bfm.clk), .reset_n(class_bfm.reset_n), 
                    .start(class_bfm.start), .done(class_bfm.done), 
                    .result(class_bfm.result));

 tinyalu_bfm       module_bfm();

 tinyalu module_dut (.A(module_bfm.A), .B(module_bfm.B), .op(module_bfm.op), 
                     .clk(module_bfm.clk), .reset_n(module_bfm.reset_n), 
                     .start(module_bfm.start), .done(module_bfm.done), 
                     .result(module_bfm.result));

 tinyalu_tester_module stim_module(module_bfm);

 initial begin
  uvm_config_db #(virtual tinyalu_bfm)::set(null, "*", "class_bfm", class_bfm);
  uvm_config_db #(virtual tinyalu_bfm)::set(null, "*", "module_bfm", module_bfm);
  run_test("dual_test");
 end
   
endmodule : top

     
   