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
   protected int age=-1;


   function new(int age);
      set_age(age);
   endfunction : new

   function void set_age(int a);
      age = a;
   endfunction : set_age

   function int get_age();
      if (age == -1)
        $fatal(1, "You didn't set the age.");
      else
        return age;
   endfunction : get_age

   pure virtual function void make_sound();

endclass : animal


class lion extends animal;

   protected string        name;

   function new(int age, string n);
      super.new(age);
      name = n;
   endfunction : new

   function void make_sound();
      $display ("%s says Roar", get_name());
   endfunction : make_sound

   function string get_name();
      return name;
   endfunction : get_name
   
endclass : lion

class lion_cage;

    static lion cage[$];
   
endclass : lion_cage

module top;

   initial begin
      lion   lion_h;
      lion_h  = new(2,  "Kimba");
      lion_cage::cage.push_back(lion_h);
      lion_h  = new(3,  "Simba");
      lion_cage::cage.push_back(lion_h);
      lion_h  = new(15, "Mustafa");
      lion_cage::cage.push_back(lion_h);
      $display("Lions in cage"); 
      foreach (lion_cage::cage[i])
        $display(lion_cage::cage[i].get_name());
   end

endmodule : top


   
        
      