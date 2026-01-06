----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: counter - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Simple sequence counter ofr filter timing
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity counter is
    port (
        i_clk : in std_logic;
        i_reset : in std_logic;
        i_length : in std_logic_vector(2 downto 0);
        o_new_seq : out std_logic
    );
end counter;

architecture Behavioral of counter is
    signal r_count :  unsigned(4 downto 0) := (others => '0');
    signal r_target_val : unsigned(3 downto 0) := (others => '0');
begin

    process(i_clk)
    begin
        if rising_edge(i_clk) then
            if i_reset = '1' then
                r_count <= (others => '0'); 
                o_new_seq <= '0'; 
            else
                -- Target value selection 
                case i_length is
                    when "100"  => r_target_val <= "0010";
                    when "101"  => r_target_val <= "0011";
                    when "110"  => r_target_val <= "0101";
                    when "111"  => r_target_val <= "1001";
                    when others => r_target_val <= "0000";
                end case;

                -- Counter logic 
                if r_count = unsigned(r_target_val) then
                    r_count <= (others => '0');
                    o_new_seq <= '1';
                else
                    r_count <= r_count + 1;
                    o_new_seq <= '0';
                end if;
            end if;
        end if;
    end process;
end Behavioral;

