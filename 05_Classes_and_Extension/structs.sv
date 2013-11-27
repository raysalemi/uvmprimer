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
typedef struct {
   int         length;
   int         width;
} rectangle_struct;

typedef struct {
   int         side;
} square_struct;
  
  module top_struct ;
    rectangle_struct rectangle_s;
    square_struct       square_s;
    initial begin
       rectangle_s.length = 50;
       rectangle_s.width  = 20;
       $display("rectangle area: %0d", rectangle_s.length * rectangle_s.width);
       square_s.side = 50;
       $display("square area: %0d", square_s.side ** 2);
    end
  endmodule

