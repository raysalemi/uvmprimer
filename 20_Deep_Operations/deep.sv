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

class mammal extends animal;
   int    babies_in_litter;
   function new(int a = 0, b = 0);
      super.new(a);
      babies_in_litter = b;
   endfunction : new


   function string convert2string();
      return {super.convert2string(), 
              $sformatf("\nbabies in litter: %0d",babies_in_litter)};
   endfunction : convert2string


   function void do_copy(animal copied_animal);
      mammal copied_mammal;
      super.do_copy(copied_animal);
      $cast(copied_mammal, copied_animal);
      babies_in_litter = copied_mammal.babies_in_litter;
   endfunction : do_copy
endclass : mammal

class lion extends mammal;
   bit is_female;
   
   function new(int age = 0, int babies_in_litter = 0, bit is_female = 0);
      super.new(age, babies_in_litter);
      this.is_female = is_female;
   endfunction : new

   function string convert2string();
      string gender_s;
      gender_s = (is_female) ? "Female" : "Male";
      return {super.convert2string(), "\nGender: ",gender_s};
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

   function new(int age=0, int babies_in_litter = 0,  bit is_female=0, string name="");
      super.new(age,babies_in_litter, is_female);
      this.name = name;
   endfunction : new

   function string convert2string();
      return { super.convert2string(),"\nName: ", name };
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

   function new(int age=0, bit is_female=0, int babies_in_litter = 0,
                string name="", byte numb_tricks=0);
      super.new(age,babies_in_litter, is_female, name);
      this.numb_tricks = numb_tricks;
   endfunction : new

   function string convert2string();
      return {super.convert2string(),"\n",
              $sformatf("numb_tricks: %0d",numb_tricks)};
   endfunction : convert2string
   
   function void do_copy(animal copied_animal);
      circus_lion copied_circus_lion;
      super.do_copy(copied_animal);
      $cast(copied_circus_lion, copied_animal);
      this.numb_tricks = copied_circus_lion.numb_tricks;
   endfunction : do_copy


endclass : circus_lion


module top;
   circus_lion   circus_lion1_h, circus_lion2_h;

   initial begin
      circus_lion1_h = new(.age(2), .is_female(1), 
                           .babies_in_litter(2), .name("Agnes"),
                           .numb_tricks(2));
      $display("\n--- Lion 1 ---\n",circus_lion1_h.convert2string());
      circus_lion2_h = new();
      $display("\n--- Lion 2 before copy ---\n",
               circus_lion2_h.convert2string());
      circus_lion2_h.do_copy(circus_lion1_h);
      $display("\n--- Lion 2 after copy ---\n",
               circus_lion2_h.convert2string());
   end
endmodule : top


   
        
      