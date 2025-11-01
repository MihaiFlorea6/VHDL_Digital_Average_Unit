----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 09:25:47 AM
-- Design Name: 
-- Module Name: divizor - Behavioral
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
USE ieee.std_logic_unsigned.all ;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity div_frecv is
    Port ( clk_placa : in STD_LOGIC;
           clk: out std_logic;
           reset: in std_logic;
           control:in std_logic_vector(2 downto 0)
          );
          
end div_frecv;

architecture arh_div_frecv of div_frecv is
 signal clk1, clk2: std_logic;
begin

  process(clk_placa, reset) 
  
  variable M : std_logic_vector(29 downto 0) := (others => '0');
  begin
  if reset = '0' then 
   if(clk_placa = '1' and clk_placa'event) then
       M := M + 1;
   end if;
   else 
     M:= (others => '0');
     end if;
   
   clk1 <= M(27);
   clk2 <= M(29);
  end process;
  
    
    process(control, clk1, clk2)
    begin
       if control = "001" then clk <= clk2;
       else clk <= clk1;
      end if; 
    end process;

end arh_div_frecv;