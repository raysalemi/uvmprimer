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
class env_config;
 virtual tinyalu_bfm class_bfm;
 virtual tinyalu_bfm module_bfm;

 function new(virtual tinyalu_bfm class_bfm, virtual tinyalu_bfm module_bfm);
    this.class_bfm = class_bfm;
    this.module_bfm = module_bfm;
 endfunction : new
endclass : env_config

