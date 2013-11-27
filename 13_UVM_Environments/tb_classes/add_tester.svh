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
class add_tester extends random_tester;
   `uvm_component_utils(add_tester)

   function operation_t get_op();
      bit [2:0] op_choice;
      return add_op;
   endfunction : get_op
         
   function new (string name, uvm_component parent);
      super.new(name, parent);
   endfunction : new

endclass : add_tester






