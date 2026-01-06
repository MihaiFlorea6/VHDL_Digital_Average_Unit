----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: average_unit_top - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Top-level wrapper that integrates the Generator,
--              Moving Average Filter and Debouncer.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity average_unit_top is
    port ( 
        i_clk_nexys: in std_logic; -- 100MHz System Clock
        i_reset: in std_logic; -- MasterReset (from Button)
        i_control: in std_logic_vector(2 downto 0); -- Generator mode selection
        i_length: in std_logic_vector(2 downto 0); -- Filter length selection
        o_an: out std_logic_vector(7 downto 0); -- 7-Segment Anodes
        o_seg: out std_logic_vector(6 downto 0) -- 7-Segment Catodes 
    );
end average_unit_top;

architecture Behavioral of average_unit_top is
    -- Internal signals for interconnecting modules
    signal w_reset_sync: std_logic;
    signal w_num_gen: std_logic_vector(7 downto 0);
    signal w_data_ce: std_logic;
begin        
    
    -- C1: Data Generator instance
    -- Produces the 8-bit number stream and the Clock Enable pulse.
    INST_GENERATOR: entity work.generator
        port map (
            i_clk => i_clk_nexys,
            i_reset => w_reset_sync,
            i_control => i_control,
            o_clk => w_data_ce,
            o_num => w_num_gen
        );
    
    -- C2: Filter and Display Unit 
    -- Processes the incoming numbers and manages the SSD display.
    INST_FILTER: entity work.filter
        port map (
            i_clk_nexys => i_clk_nexys,
            i_clk_ce => w_data_ce,
            i_reset => w_reset_sync,
            i_length => i_length,
            i_data => w_num_gen,
            o_an => o_an,
            o_seg => o_seg
        );
        
    -- C3: Debouncer instance for the reset signal 
    -- Ensures the system reset is clean and single-pulse.
    INST_DEBOUNCER: entity work.debouncer
        port map (
            i_clk => i_clk_nexys,
            i_reset => '0',
            i_btn => i_reset,
            o_pulse => w_reset_sync
        );    
    
end Behavioral;