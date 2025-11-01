----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/03/2024 11:31:26 PM
-- Design Name: 
-- Module Name: calculator_medie_secventa de numere - Behavioral
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

entity calculator_medie_secventa_de_numere is
    Port ( 
            control : in STD_LOGIC_VECTOR(2 downto 0);
           length : in STD_LOGIC_VECTOR(2 downto 0);
           clk_placa : in STD_LOGIC;
           reset : in STD_LOGIC;
           an: out std_logic_vector(7 downto 0);
           seg: out std_logic_vector(6 downto 0)
           );
end calculator_medie_secventa_de_numere;

architecture Behavioral of calculator_medie_secventa_de_numere is
  
  signal num_gen : std_logic_vector(7 downto 0);
  signal data_clk: std_logic;
  signal reset_sig: std_logic;
  signal data :  STD_LOGIC_VECTOR(7 downto 0);
  signal medie :  STD_LOGIC_VECTOR(7 downto 0);
  
component filter is
    Port ( 
           length : in STD_LOGIC_VECTOR(2 downto 0);
           reset: in std_logic;
           clk_placa: in std_logic;
           clk_in: in std_logic;
           data_in: in std_logic_vector(7 downto 0);
           an: out std_logic_vector(7 downto 0);
           seg: out std_logic_vector(6 downto 0)
          );
    
end component;

component generator is
    Port ( control : in STD_LOGIC_vector(2 downto 0);
           reset : in STD_LOGIC;
           clk: in std_logic;
           data_clk: out std_logic;
           numar: out std_logic_vector(7 downto 0)
          );
end component;

component debouncer is
    Port ( 
           btn : in  STD_LOGIC;
           clk : in  STD_LOGIC;
           enable : out  STD_LOGIC
          );
end component;

begin
   
   C1: generator port map(control => control, reset => reset_sig, clk=> clk_placa, data_clk => data_clk, numar => num_gen);
   C2: filter port map(length => length, reset => reset_sig, clk_in => data_clk, clk_placa => clk_placa, data_in => num_gen, an => an, seg=> seg);
   C3: debouncer port map( btn => reset, clk => clk_placa, enable=> reset_sig);
 
end Behavioral;