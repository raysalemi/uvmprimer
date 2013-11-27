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
class result_transaction extends uvm_transaction;
   `uvm_object_utils(result_transaction)

   shortint result;
   
   function bit do_compare(uvm_object rhs, uvm_comparer comparer);
      result_transaction tested;
      bit   same;
      
      if (!$cast(tested,rhs))
        same = 0;
      else
        same = super.do_compare(rhs, comparer) && 
               (tested.result == result);
      
      return same;
   endfunction : do_compare

   function void do_copy(uvm_object rhs);
      result_transaction copied_transaction_h;

      if(rhs == null) 
        `uvm_fatal(get_type_name(), "Tried to copy from a null pointer")

      if(!$cast(copied_transaction_h,rhs))
        `uvm_fatal(get_type_name(),
         {"Tried to copy to ",get_type_name()," with wrong transaction type: ", rhs.get_type_name()});
      
      super.do_copy(rhs); // copy all parent class data

      result = copied_transaction_h.result;

   endfunction : do_copy

   
   function string convert2string();
      string s;
      s = $sformatf("result: %4h",result);
      return s;
   endfunction : convert2string
   
   function new (string name = "");
      super.new(name);
   endfunction : new

endclass : result_transaction

      
        