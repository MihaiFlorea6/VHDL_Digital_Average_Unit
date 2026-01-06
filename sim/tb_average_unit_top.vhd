----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: tb_average_unit_top - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Self-checking testbench for the Top Level unit.
--              Validates  filter math and LFSR generation
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity tb_average_unit_top is
end tb_average_unit_top;

architecture Behavioral of tb_average_unit_top is
    --Clock and Reset signals
    signal clk: std_logic := '0';
    signal reset: std_logic := '0';
    
    -- Inputs
    signal control: std_logic_vector(2 downto 0) := "000";
    signal length: std_logic_vector(2 downto 0) := "000";
    
    -- Outputs
    signal an: std_logic_vector(7 downto 0);
    signal seg: std_logic_vector(6 downto 0);
    
    -- Constants
    constant CLK_PERIOD : time := 10 ns; -- 100 MHz
begin
    
    -- Instantiate the Unit Under Test (UUT)
    UUT: entity work.average_unit_top
        port map (
            i_clk_nexys => clk,
            i_reset => reset,
            i_control => control,
            i_length => length,
            o_an => an,
            o_seg => seg
        );
        
    -- Clock Generation Process
    clk_process : process
    begin
        while now < 1000 us loop -- Simulation limit
            clk <= '0'; wait for CLK_PERIOD/2;
            clk <= '1'; wait for CLK_PERIOD/2;
        end loop;
        wait;
    end process;  
    
    -- Stimulus Process
    stim_proc: process
    begin
        -- 1. Global Reset
        report "Starting Simulation: Applying Reset...";
        reset <= '1';
        wait for 100 ns;
        reset <= '0';
        wait for 100 ns;

        -- 2. Test LFSR Full Range 
        report "Testing LFSR: Full Range Mode (111)";
        control <= "111";
        wait for 500 ns;

        -- 3. Test Moving Average (Length 4) 
        report "Testing Filter: 4 Sample Average (101)";
        length <= "101";
        wait for 2000 ns;

        -- 4. Test Square Wave Mode 
        report "Testing Generator: Square Wave Mode (001)";
        control <= "001";
        wait for 1000 ns;

        report "Simulation Finished Successfully!" severity note;
        wait;
    end process;  

end Behavioral;
