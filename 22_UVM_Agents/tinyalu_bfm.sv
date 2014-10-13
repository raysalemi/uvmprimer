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
   import uvm_pkg::*;
   `include "uvm_macros.svh"
   import tinyalu_pkg::*;

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
   


   task send_op(input byte iA, input byte iB, input operation_t iop, output shortint alu_result);
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
            alu_result = result;
            start = 1'b0;
         end
      end // else: !if(iop == rst_op)
      
   endtask : send_op
   
   command_monitor command_monitor_h;

   function operation_t op2enum();
      case(op)
        3'b000 : return no_op;
        3'b001 : return add_op;
        3'b010 : return and_op;
        3'b011 : return xor_op;
        3'b100 : return mul_op;
	3'b111 : return rst_op;
        default : `uvm_fatal("TINYALU BFM",$sformatf("Illegal operation:  %d", int'(op)))
      endcase // case (op)
   endfunction : op2enum


   always @(posedge clk) begin : op_monitor
      static bit in_command = 0;
      command_transaction command;
      if (start) begin : start_high
        if (!in_command) begin : new_command
           command_monitor_h.write_to_monitor(A, B, op2enum());
           in_command = (op2enum() != no_op);
        end : new_command
      end : start_high
      else // start low
        in_command = 0;
   end : op_monitor

   always @(negedge reset_n) begin : rst_monitor
      command_transaction command;
      if (command_monitor_h != null) //guard against VCS time 0 negedge
        command_monitor_h.write_to_monitor($random,0,rst_op);
   end : rst_monitor
   
   result_monitor  result_monitor_h;

   initial begin : result_monitor_thread
      forever begin : result_monitor
         @(posedge clk) ;
         if (done) 
           result_monitor_h.write_to_monitor(result);
      end : result_monitor
   end : result_monitor_thread
   

   initial begin
      clk = 0;
      forever begin
         #10;
         clk = ~clk;
      end
   end


endinterface : tinyalu_bfm
