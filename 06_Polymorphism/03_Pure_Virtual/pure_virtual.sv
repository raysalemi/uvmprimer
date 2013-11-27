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

   function new(int a);
      age = a;
   endfunction : new

   pure virtual function void make_sound();

endclass : animal


class lion extends animal;

   function new(int age);
      super.new(age);
   endfunction : new

   function void make_sound();
      $display ("The Lion says Roar");
   endfunction : make_sound

endclass : lion


class chicken extends animal;

   function new(int age);
      super.new(age);
   endfunction : new

   function void make_sound();
      $display ("The Chicken says BECAWW");
   endfunction : make_sound

endclass : chicken


module top;


   initial begin
   
      lion   lion_h;
      chicken  chicken_h;
      animal animal_h;
   
      animal_h = new(3); 
      
      lion_h  = new(15);
      lion_h.make_sound();
      $display("The Lion is %0d years old", lion_h.age);
      
      chicken_h = new(1);
      chicken_h.make_sound();
      $display("The Chicken is %0d years old", chicken_h.age);

      animal_h = lion_h;
      animal_h.make_sound();
      $display("The animal is %0d years old", animal_h.age);
      
      animal_h = chicken_h;
      animal_h.make_sound();
      $display("The animal is %0d years old", animal_h.age);
      
   end // initial begin

endmodule : top




