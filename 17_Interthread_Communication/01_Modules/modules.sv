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
module producer(output byte shared, input bit put_it, output bit get_it);
   initial
     repeat(3) begin 
        $display("Sent %0d", ++shared);
        get_it = ~get_it;
        @(put_it);
     end
endmodule : producer

module consumer(input byte shared,  output bit put_it, input bit get_it);
   initial
      forever begin
         @(get_it);
         $display("Received: %0d", shared);
         put_it = ~put_it;
      end
endmodule : consumer

module top; 
   byte shared;
   producer p (shared, put_it, get_it);
   consumer c (shared, put_it, get_it);
endmodule : top

       