----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 04:10:51 PM
-- Design Name: 
-- Module Name: media - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity media is
    Port ( sum_in : in STD_LOGIC_VECTOR(7 downto 0);
           lenght : in STD_LOGIC_VECTOR(2 downto 0);
           clk : in STD_LOGIC;
           average : out STD_LOGIC_VECTOR(7 downto 0));
end media;

architecture Behavioral of media is

signal medie : std_logic_vector(7 downto 0);
attribute keep : string;
attribute keep of medie : signal is "true";

begin
   
   process(sum_in, lenght, clk, medie)
   begin
     
    if rising_edge(clk) then
      if lenght = "000" then medie <= sum_in;
      elsif lenght = "100" then medie <= "0" & sum_in(7 downto 1);
      elsif lenght = "101" then medie <= "00" & sum_in(7 downto 2);
      elsif lenght = "110" then medie <= "000" & sum_in(7 downto 3);
      elsif lenght = "111" then medie <= "0000" & sum_in(7 downto 4);
      end if;
    end if;
    average <= medie;
   end process;

end Behavioral;
