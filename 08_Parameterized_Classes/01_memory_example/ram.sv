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
module RAM #(awidth, dwidth) (
			       input wire [awidth-1:0] address, 
			       inout wire [dwidth-1:0] data,
			       input we);

   initial $display("awidth: %0d  dwidth %0d",awidth, dwidth);
   // code to implement RAM
endmodule // RAM

   
   