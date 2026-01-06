----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: frequency_divider - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Generates a single-cycle pulse to enable logic
--              at lower frequencies without gating the clock.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity frequency_divider is
    port ( 
       i_clk_100M : in std_logic;
       i_reset: in std_logic;
       i_control:in std_logic_vector(2 downto 0);
       o_clk: out std_logic
    );  
end frequency_divider;

architecture Behavioral of frequency_divider is
    signal r_cnt : unsigned(29 downto 0) := (others => '0');
    signal r_clk : std_logic := '0';
begin

   process(i_clk_100M)
    begin
        if rising_edge(i_clk_100M) then
            if i_reset = '1' then
                r_cnt <= (others => '0');
                r_clk <= '0';
            else
                r_cnt <= r_cnt + 1; 
                
                -- Generate pulse based on control frequency 
                if i_control = "001" then
                    -- Pulse every 2^29 cycles
                    if r_cnt(28 downto 0) = (28 downto 0 => '1') then r_clk <= '1'; else r_clk <= '0'; end if;
                else
                    -- Pulse every 2^27 cycles
                    if r_cnt(26 downto 0) = (26 downto 0 => '1') then r_clk <= '1'; else r_clk <= '0'; end if;
                end if;
            end if;
        end if;
    end process;

    o_clk <= r_clk;
end Behavioral;