----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: generator - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Logic unit for data generation. Orchestrates
--              LFSR and timing enable pulses.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity generator is
    port ( 
       i_control: in std_logic_vector(2 downto 0);
       i_reset: in std_logic;
       i_clk: in std_logic;
       o_clk: out std_logic;
       o_num: out std_logic_vector(7 downto 0)
    );
end generator;

architecture Behavioral of generator is
signal w_clk : std_logic;
begin

    -- Instance of the new Clock Enable generator
    INST_CLK_GEN: entity work.frequency_divider
        port map (
            i_clk_100M => i_clk,
            i_reset => i_reset,
            i_control => i_control,
            o_clk => w_clk
        );

    -- LFSR triggered by System Clock but controlled by Clock Enable
    INST_LFSR: entity work.lfsr
        port map (
            i_clk => i_clk, -- Runs at 100MHz
            i_reset => i_reset,
            i_control => i_control,
            o_random_num => o_num
        );

    o_clk <= w_clk;
end Behavioral;