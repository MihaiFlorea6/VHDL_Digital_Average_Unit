----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: debouncer - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Filter mechanical bounce from buttons and
--              generates a single-cycle pulse on press 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity debouncer is
    port ( 
       i_btn: in std_logic;
       i_clk: in std_logic;
       i_reset: in std_logic;
       o_pulse: out std_logic
    );
end debouncer;

architecture Behavioral of debouncer is
    signal r_cnt : unsigned(15 downto 0) := (others => '0');
    signal r_q1, r_q2, r_q3 : std_logic := '0';
begin

    process(i_clk)
    begin
        if rising_edge(i_clk) then
             if i_reset = '1' then
                 r_cnt <= (others => '0');
                 r_q1 <= '0'; r_q2 <= '0'; r_q3 <= '0';
             else 
                 r_cnt <= r_cnt + 1;
                 -- Sample button every ~0.65ms at 100MHz
                 if r_cnt = x"FFFF" then
                     r_q1 <= i_btn;
                 end if;
                 -- Edge detection shift register
                 r_q2 <= r_q1;
                 r_q3 <= r_q2;
             end if;
        end if;
    end process;
    
    -- Generate pulse on rising edge
    o_pulse <= r_q2 and (not r_q3);    
end Behavioral;