----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date:    15:35:29 04/18/2022 
-- Design Name: 
-- Module Name:    ssd - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity ssd is
    Port ( 
           digit0 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit1 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit2 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit3 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit4 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit5 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit6 : in  STD_LOGIC_VECTOR (3 downto 0);
           digit7 : in  STD_LOGIC_VECTOR (3 downto 0);
           clk : in  STD_LOGIC;
           anod : out  STD_LOGIC_VECTOR (7 downto 0);
           catod : out  STD_LOGIC_VECTOR (6 downto 0));
end ssd;

architecture Behavioral of ssd is

 signal counter:std_logic_vector(15 downto 0);
 signal rez_mux:std_logic_vector(3 downto 0);
begin

process(clk)
begin
 if clk'event and clk='1'  then  --- rising_edge(clk)

	--counter++
	counter<=counter + 1;
 end if;

end process;


--selectie anod

process(counter)
begin
	case( counter (15 downto 13) ) is 
		when "000"=>anod<="11111110";
		when "001"=>anod<="11111101";
		when "010"=>anod<="11111011";
		when "011"=>anod<="11110111";
        when "100"=>anod<="11101111";
        when "101"=>anod<="11011011";
        when "110"=>anod<="10111111";
        when "111"=>anod<="01111111";
       when others=>anod<="11111111";
	end case;
end process;


process(counter,digit0,digit1,digit2,digit3,digit4,digit5,digit6,digit7)
begin
	case (counter (15 downto 13)) is 
		when "000"=>rez_mux<=digit0;
		when "001"=>rez_mux<=digit1;
		when "010"=>rez_mux<=digit2;
		when "011"=>rez_mux<=digit3;
		when "100"=>rez_mux<=digit4;
		when "101"=>rez_mux<=digit5;
		when "110"=>rez_mux<=digit6;
		when others=>rez_mux<=digit7;
	end case;
end process;


process(rez_mux)
begin
	case rez_mux is
        when "0000" => catod<="1000000";
            when "0001" => catod<="1111001";
            when "0010" => catod<="0100100";
            when "0011" => catod<="0110000";
    
            when "0100" => catod<="0011001";
            when "0101" => catod<="0010010";
            when "0110" => catod<="0000010";
            when "0111" => catod<="1111000";
    
            when "1000" => catod<="0000000";
            when "1001" => catod<="0010000";
            when others => catod<="0111111";

	end case;
end process;

end Behavioral;