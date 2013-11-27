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
virtual class animal;
   int age=-1;

   function new(int a = 0);
      age = a;
   endfunction : new

   virtual function string convert2string();
      return $sformatf("Age: %0d", age);
   endfunction : convert2string

   virtual function void do_copy(animal copied_animal);
      age = copied_animal.age;
   endfunction : do_copy
   
endclass : animal


class lion extends animal;
   bit is_female;
   
   function new(int age = 0, bit is_female = 0);
      super.new(age);
      this.is_female = is_female;
   endfunction : new

   function string convert2string();
      string gender_s;
      gender_s = (is_female) ? "Female" : "Male";
      return sformat("Age: %0d Gender: ",age, gender_s);
   endfunction : convert2string

   function void do_copy(animal copied_animal);
      lion copied_lion;
      super.do_copy(copied_animal);
      $cast(copied_lion, copied_animal);
      this.is_female = copied_lion.is_female;
   endfunction : do_copy
   
      
endclass : lion

class captive_lion extends lion;
   string name;

   function new(int age=0, bit is_female=0, string name="");
      super.new(age,is_female);
      this.name = name;
   endfunction : new

   function string convert2string();
      return {$sformatf("age: %0d is_female: %0b name: %s", 
      	       age, is_female, name) };
   endfunction : convert2string

   function void do_copy(animal copied_animal);
      captive_lion copied_captive_lion;
      super.do_copy(copied_animal);
      $cast(copied_captive_lion, copied_animal);
      this.name = copied_captive_lion.name;
   endfunction : do_copy
endclass : captive_lion

class circus_lion extends captive_lion;
   byte numb_tricks;

   function new(int age=0, bit is_female=0, 
                string name="", byte numb_tricks=0);
      super.new(age, is_female, name);
      this.numb_tricks = numb_tricks;
   endfunction : new

   function string convert2string();
      return {$sformatf("age: %0d is_female: %0b name: %s  numb_tricks: %0d",
      	age, is_female, name, numb_tricks)};
   endfunction : convert2string
   
   function void do_copy(animal copied_animal);
      circus_lion copied_circus_lion;
      super.do_copy(copied_animal);
      $cast(copied_circus_lion, copied_animal);
      this.numb_tricks = copied_circus_lion.numb_tricks;
   endfunction : do_copy


   function void bad_copy(circus_lion copied_circus_lion);
      numb_tricks = copied_circus_lion.numb_tricks;
      name = copied_circus_lion.name;
      is_female = copied_circus_lion.is_female;
      age = copied_circus_lion.age;
   endfunction 

endclass : circus_lion


module top;
   circus_lion   circus_lion1_h, circus_lion2_h;

   initial begin
      circus_lion1_h = new(2, 1, "Agnus", 2);
      $display("\n--- Lion 1 ---\n",circus_lion1_h.convert2string());
      circus_lion2_h = new();
      $display("\n--- Lion 2 before copy ---\n",
               circus_lion2_h.convert2string());
      circus_lion2_h.bad_copy(circus_lion1_h);
      $display("\n--- Lion 2 after copy ---\n",
               circus_lion2_h.convert2string());
   end
endmodule : top


   
        
      