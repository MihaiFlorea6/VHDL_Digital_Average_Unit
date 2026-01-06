----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: lfsr - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: 8-bit Linear Feedback Shift Register for pseudo-random 
--              number generation with configurable modes. 
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity lfsr is
   port( 
         i_clk: in std_logic;
         i_control: in std_logic_vector(2 downto 0);
         i_reset: in std_logic;
         o_random_num: out std_logic_vector(7 downto 0)
        );
end lfsr;

architecture Behavioral of lfsr is
   -- Internal register to hold the LFSR state
   signal r_lfsr_reg : unsigned(7 downto 0) := (others => '1');
   signal w_feedback : std_logic; 
begin
   
   process(i_clk)
   begin  								
   if rising_edge(i_clk) then
            if i_reset = '1' then
                r_lfsr_reg <= (others => '1');
            else
                case i_control is
                    when "110" => -- 4-bit mode reduced 
                        r_lfsr_reg(3 downto 0) <= r_lfsr_reg(2 downto 0) & (r_lfsr_reg(2) xor r_lfsr_reg(3));
                        r_lfsr_reg(7 downto 4) <= (others => '0');
                        
                    when "111" | "000" => -- Full 8-bit/Test mode 
                        r_lfsr_reg <= r_lfsr_reg(6 downto 0) & (r_lfsr_reg(2) xor r_lfsr_reg(3) xor r_lfsr_reg(4) xor r_lfsr_reg(6));
                    
                    when "001" => -- Square wave shift 
                        r_lfsr_reg <= r_lfsr_reg(6 downto 0) & (r_lfsr_reg(7) xor r_lfsr_reg(6));
                    
                    when "100" => r_lfsr_reg <= x"AA"; -- Static patterns 
                    when "101" => r_lfsr_reg <= x"55"; 
                    
                    when others =>
                        r_lfsr_reg <= r_lfsr_reg + 1; -- Default behavior
                end case;
            end if;
        end if;
    end process;

    o_random_num <= std_logic_vector(r_lfsr_reg);
end Behavioral;