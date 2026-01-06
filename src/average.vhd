----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: average - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Performs arithmetic mean using bit-shifting.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity average is
    port ( 
       i_clk : in std_logic;
       i_sum : in std_logic_vector(7 downto 0);
       i_length : in std_logic_vector(2 downto 0);
       o_average : out std_logic_vector(7 downto 0)
    );
end average;

architecture Behavioral of average is
    signal r_avg : unsigned(7 downto 0) := (others => '0');
begin

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            case i_length is
                when "000" => r_avg <= unsigned(i_sum);
                when "100" => r_avg <= shift_right(unsigned(i_sum), 1); -- Divide by 2 
                when "101" => r_avg <= shift_right(unsigned(i_sum), 2); -- Divide by 4 
                when "110" => r_avg <= shift_right(unsigned(i_sum), 3); -- Divide by 8 
                when "111" => r_avg <= shift_right(unsigned(i_sum), 4); -- Divide by 16 
                when others => r_avg <= unsigned(i_sum);
            end case;
        end if;
    end process;

    o_average <= std_logic_vector(r_avg); 
end Behavioral;