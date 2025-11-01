----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 03:22:19 PM
-- Design Name: 
-- Module Name: sumator_complet - Behavioral
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

entity sumator_complet is
    Port ( a,b, cin : in STD_LOGIC;
           co, s : out STD_LOGIC);
end sumator_complet;

architecture arh_sumcom of sumator_complet is
begin

     s <= a xor b xor cin;
     co <= (a and b) or (a and cin) or (b and cin);

end arh_sumcom;
