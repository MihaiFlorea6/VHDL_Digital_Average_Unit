----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/02/2024 03:14:26 PM
-- Design Name: 
-- Module Name: counter - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity counter is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        length : in STD_LOGIC_VECTOR(2 downto 0);
        secv_noua : out STD_LOGIC
    );
    attribute dont_touch : string;
    attribute dont_touch of counter : entity is "true";
end counter;


architecture Behavioral of counter is 

  signal count : STD_LOGIC_VECTOR(4 downto 0) := (others => '0');
  attribute keep : string;
  attribute keep of count : signal is "true";
  signal target_value : STD_LOGIC_VECTOR(3 downto 0);
  attribute keep of target_value : signal is "true";
begin

    process(clk, reset)
    begin
        if reset = '1' then
            count <= (others => '0');
            secv_noua <= '0';
        elsif rising_edge(clk) then
            case length is
                when "100" => target_value <= "0010";
                when "101" => target_value <= "0011";
                when "110" => target_value <= "0101";
                when "111" => target_value <= "1001";
                when others => target_value <= (others => '0');
            end case;

            if count = target_value then
                count <= (others => '0');
                secv_noua <= '1';
            else
                count <= count + 1;
                secv_noua <= '0';
            end if;
        end if;
    end process;

end Behavioral;
