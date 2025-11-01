----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 03:13:44 PM
-- Design Name: 
-- Module Name: sum8bit - arh_of_sum8bit
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

entity sum8bit is
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
           B : in STD_LOGIC_VECTOR(7 downto 0);
           S : out STD_LOGIC_VECTOR(7 downto 0);
           cout: out std_logic
           );
end sum8bit;

architecture arh_of_sum8bit of sum8bit is

signal cary : std_logic_vector(6 downto 0); 
signal fin : std_logic := '0';
component sumator_complet is
    Port ( a,b, cin : in STD_LOGIC;
           co, s : out STD_LOGIC);
end component;

begin
   
   SUM1: sumator_complet port map(a => A(0), b => B(0), cin=> fin,     co=>cary(0), s => S(0));
   SUM2: sumator_complet port map(a => A(1), b => B(1), cin=> cary(0), co=>cary(1), s => S(1));
   SUM3: sumator_complet port map(a => A(2), b => B(2), cin=> cary(1), co=>cary(2), s => S(2));
   SUM4: sumator_complet port map(a => A(3), b => B(3), cin=> cary(2), co=>cary(3), s => S(3));
   SUM5: sumator_complet port map(a => A(4), b => B(4), cin=> cary(3), co=>cary(4), s => S(4));
   SUM6: sumator_complet port map(a => A(5), b => B(5), cin=> cary(4), co=>cary(5), s => S(5));
   SUM7: sumator_complet port map(a => A(6), b => B(6), cin=> cary(5), co=>cary(6), s => S(6));
   SUM8: sumator_complet port map(a => A(7), b => B(7), cin=> cary(6), co=>cout   , s => S(7));
   

end arh_of_sum8bit;
