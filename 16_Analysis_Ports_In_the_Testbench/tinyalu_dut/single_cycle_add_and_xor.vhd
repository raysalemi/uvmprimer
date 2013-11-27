--   Copyright 2013 Ray Salemi
--
--   Licensed under the Apache License, Version 2.0 (the "License");
--   you may not use this file except in compliance with the License.
--   You may obtain a copy of the License at
--
--       http://www.apache.org/licenses/LICENSE-2.0
--
--   Unless required by applicable law or agreed to in writing, software
--   distributed under the License is distributed on an "AS IS" BASIS,
--   WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
--   See the License for the specific language governing permissions and
--   limitations under the License.
library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;

entity single_cycle is
  port(
    A          : in  unsigned ( 7 downto 0 );
    B          : in  unsigned ( 7 downto 0 );
    clk        : in  std_logic;
    op         : in  std_logic_vector ( 2 downto 0 );
    reset_n    : in  std_logic;
    start      : in  std_logic;
    done_aax   : out std_logic;
    result_aax : out unsigned (15 downto 0)
    );

-- Declarations

end single_cycle;

--
architecture add_and_xor of single_cycle is

  signal a_int, b_int       : unsigned (7 downto 0);
  signal mul_int1, mul_int2 : unsigned(15 downto 0);
  signal done_aax_int       : std_logic;  -- VHDL can't read an output  -- Doh!
begin
-----------------------------------------------------------------
  single_cycle_ops          : process (clk)
-----------------------------------------------------------------
  begin
    if (clk'event and clk = '1') then
      -- Synchronous Reset
      if (reset_n = '0') then
        -- Reset Actions
        result_aax       <= "0000000000000000";
      else
        if START = '1' then
          case op is
            when "001"  =>
              result_aax <= ("00000000" & A) +
                            ("00000000" & B);
            when "010"  =>
              result_aax <= unsigned(std_logic_vector("00000000" & A) and
                                     std_logic_vector("00000000" & B));
            when "011"  =>
              result_aax <= unsigned(std_logic_vector("00000000" & A) xor
                                     std_logic_vector("00000000" & B));
            when others => null;
          end case;
        end if;

      end if;
    end if;
  end process single_cycle_ops;

-- purpose: This block sets the done signal. This is set on the clock edge if the start signal is high.
-- type : sequential
-- inputs : clk, reset_n, start,op
-- outputs: done_aax_int
  set_done : process (clk, reset_n)
  begin  -- process set_done_sig
    if reset_n = '0' then               -- asynchronous reset (active low)
      done_aax_int   <= '0';
    elsif clk'event and clk = '1' then  -- rising clock edge
      if ((start = '1') and (op /= "000")) then
        done_aax_int <= '1';
      else
        done_aax_int <= '0';
      end if;
    end if;
  end process set_done;


  done_aax <= done_aax_int;
end architecture add_and_xor;

