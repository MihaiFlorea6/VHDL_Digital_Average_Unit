----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 11:44:03 AM
-- Design Name: 
-- Module Name: generator - Behavioral
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

entity generator is
    Port ( control : in STD_LOGIC_vector(2 downto 0);
           reset : in STD_LOGIC;
           clk: in std_logic;
           data_clk: out std_logic;
           numar: out std_logic_vector(7 downto 0)
          );
end generator;

architecture Behavioral of generator is

signal clk_divizat: std_logic;

component div_frecv is
    Port ( clk_placa : in STD_LOGIC;
           clk: out std_logic;
           reset: in std_logic;
           control: std_logic_vector(2 downto 0)
          );       
end component;

component lfsr is
   port( 
         clk: in std_logic;
         control: in std_logic_vector(2 downto 0);
         reset: in std_logic;
         random_num: out std_logic_vector(7 downto 0)
        );
end component;

begin

    C1: div_frecv port map( clk_placa => clk, clk=>clk_divizat, reset => reset, control => control);
    C2: lfsr port map(clk=>clk_divizat , control=>control, random_num=>numar, reset => reset);
    
    data_clk <= clk_divizat;
end Behavioral;
