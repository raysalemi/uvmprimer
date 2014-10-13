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
interface tinyalu_bfm;
   import tinyalu_pkg::*;
   
   command_monitor command_monitor_h;
   result_monitor  result_monitor_h;

   byte         unsigned        A;
   byte         unsigned        B;
   bit          clk;
   bit          reset_n;
   wire [2:0]   op;
   bit          start;
   wire         done;
   wire [15:0]  result;
   operation_t  op_set;


   
   
   assign op = op_set;

   task reset_alu();
      reset_n = 1'b0;
      @(negedge clk);
      @(negedge clk);
      reset_n = 1'b1;
      start = 1'b0;
   endtask : reset_alu
   


   task send_op(input byte iA, input byte iB, input operation_t iop, shortint result);
      if (iop == rst_op) begin
         @(posedge clk);
         reset_n = 1'b0;
         start = 1'b0;
         @(posedge clk);
         #1;
         reset_n = 1'b1;
      end else begin
         @(negedge clk);
         op_set = iop;
         A = iA;
         B = iB;
         start = 1'b1;
         if (iop == no_op) begin
            @(posedge clk);
            #1;
            start = 1'b0;           
         end else begin
            do
              @(negedge clk);
            while (done == 0);
            start = 1'b0;
         end
      end // else: !if(iop == rst_op)
      
   endtask : send_op


   always @(posedge clk) begin : cmd_monitor
      bit new_command;
      if (!start) 
        new_command = 1;
      else
        if (new_command) begin 
           command_monitor_h.write_to_monitor(A, B, op);
           new_command = (op == 3'b000); // handle no_op
        end 
   end : cmd_monitor

   always @(negedge reset_n) begin : rst_monitor
      if (command_monitor_h != null) //guard against VCS time 0 negedge
         command_monitor_h.write_to_monitor(A, B, rst_op);
   end : rst_monitor
   

   always @(posedge clk) begin : rslt_monitor
         if (done) 
           result_monitor_h.write_to_monitor(result);
   end : rslt_monitor
   

   initial begin
      clk = 0;
      forever begin
         #10;
         clk = ~clk;
      end
   end


endinterface : tinyalu_bfm
