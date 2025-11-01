----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 03:44:04 PM
-- Design Name: 
-- Module Name: filter - Behavioral
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

entity filter is
    Port ( 
           length : in STD_LOGIC_VECTOR(2 downto 0);
           reset: in std_logic;
           clk_placa: in std_logic;
           clk_in: in std_logic;
           data_in: in std_logic_vector(7 downto 0);
           an: out std_logic_vector(7 downto 0);
           seg: out std_logic_vector(6 downto 0)
          );
    
end filter;

architecture Behavioral of filter is

signal suma: std_logic_vector(7 downto 0);
signal media_fin: std_logic_vector(7 downto 0);
signal Bsig: std_logic_vector(7 downto 0) := "00000000";
signal co: std_logic;
signal actualizeaza : std_logic:= '0';
signal bcd1: std_logic_vector(11 downto 0);
signal bcd2: std_logic_vector(11 downto 0);
signal zero: std_logic_vector(3 downto 0):= "0000";

component sum8bit is
    Port ( A : in STD_LOGIC_VECTOR(7 downto 0);
           B : in STD_LOGIC_VECTOR(7 downto 0);
           S : out STD_LOGIC_VECTOR(7 downto 0);
           cout: out std_logic
           );
end component;
 
component reg8bit is
    Port ( 
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            length : in std_logic_vector(2 downto 0);
            data_in : in STD_LOGIC_VECTOR(7 downto 0);
            data_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end component;     

component media is
    Port ( sum_in : in STD_LOGIC_VECTOR(7 downto 0);
           lenght : in STD_LOGIC_VECTOR(2 downto 0);
           clk : in STD_LOGIC;
           average : out STD_LOGIC_VECTOR(7 downto 0));
end component;

component bin8bcd is
    port (
        bin:    in  std_logic_vector (7 downto 0);
        bcd:    out std_logic_vector (11 downto 0)
    );
end component;

component ssd is
    Port ( digit0 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit4 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit5 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit6 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit7 : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           anod : out  STD_LOGIC_VECTOR (7 downto 0);
           catod : out  STD_LOGIC_VECTOR (6 downto 0)
          );
end component;

begin

       C1: sum8bit port map(A => data_in, B=> Bsig, S => suma, cout=> co); 
       C2: reg8bit port map(data_in => suma, data_out => Bsig, reset => reset, clk=> clk_in, length => length);
       
       C3: media port map(sum_in => suma, lenght => length, clk => clk_in, average => media_fin);
       C4: bin8bcd port map( bin => media_fin , bcd=>bcd1);
       C5: bin8bcd port map( bin => data_in , bcd=>bcd2);
       
       C6: ssd port map( digit0=> bcd1(3 downto 0), digit1 =>bcd1(7 downto 4), digit2 => bcd1(11 downto 8), digit3 => zero,
          digit4 => bcd2(3 downto 0), digit5 => bcd2(7 downto 4), digit6=> bcd2(11 downto 8), digit7 => zero, clk => clk_placa,
          anod=> an, catod => seg);
       
      
       
end Behavioral;
