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
  class rectangle;
    int length;
    int width;
    
    function new(int l, int w);
      length = l;
      width  = w;
    endfunction
    
    function int area;
      return length * width;
    endfunction
  endclass : rectangle

  
  module top_rectangle ;

    rectangle rectangle_h;

    initial begin

      rectangle_h = new(.l(50),.w(20));

      $display("rectangle area: %0d", rectangle_h.area());

    end
endmodule : top_rectangle

