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

interface clk_bfm;
   bit clk;
   initial clk = 0;
   always #7 clk = ~clk;
endinterface : clk_bfm


module top;
   import uvm_pkg::*;
`include "uvm_macros.svh"

   import example_pkg::*;

   clk_bfm clk_bfm_i();

   initial begin
      example_pkg::clk_bfm_i = clk_bfm_i;
      run_test("communication_test");
   end

endmodule : top
