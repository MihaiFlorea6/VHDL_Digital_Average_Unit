----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 03:39:35 PM
-- Design Name: 
-- Module Name: reg8bit - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity reg8bit is
    Port ( 
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        length : in std_logic_vector(2 downto 0);
        data_in : in STD_LOGIC_VECTOR(7 downto 0);
        data_out : out STD_LOGIC_VECTOR(7 downto 0)
    );
end reg8bit;

architecture Behavioral of reg8bit is
    signal reg : STD_LOGIC_VECTOR(7 downto 0);
    attribute keep : string;
    attribute keep of reg : signal is "true";
    signal res: std_logic;
    
    
    component counter is
        Port (
            clk : in STD_LOGIC;
            reset : in STD_LOGIC;
            length : in STD_LOGIC_VECTOR(2 downto 0);
            secv_noua : out STD_LOGIC
        );
    end component;
    
begin
    
    C1:counter port map(clk => clk, reset => reset, length => length, secv_noua => res);

    process(clk, reset, length, data_in)
    begin
        if reset = '1' then
            reg <= (others => '0');
       
        elsif rising_edge(clk) then  
           if res ='1' then
           reg <= (others => '0');
           else 
           reg <= data_in;
           end if;
       end if;
    end process;
    
    data_out <= reg;
    
end Behavioral;
