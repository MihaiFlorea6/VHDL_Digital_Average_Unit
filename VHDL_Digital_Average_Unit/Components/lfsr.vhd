----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06/01/2024 09:20:19 AM
-- Design Name: 
-- Module Name: lfsr - arh_lfsr
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



entity lfsr is
   port( 
         clk: in std_logic;
         control: in std_logic_vector(2 downto 0);
         reset: in std_logic;
         random_num: out std_logic_vector(7 downto 0)
        );
end lfsr;

architecture Behavioral of lfsr is
begin
   
  process(clk, control, reset)
  
  variable rand_temp : std_logic_vector (7 downto 0) := (others=>'1');
  variable temp : std_logic := '0';	
  variable temp2 : std_logic := '0';	

begin  								
   if reset= '0' then
    if(rising_edge(clk)) then      
	  if (control = "110" ) then
          
          temp := rand_temp(2) xor rand_temp(3);
          rand_temp(7 downto 4) := (others=>'0');	
          rand_temp(3 downto 1) := rand_temp(2 downto 0);
          rand_temp(0):= temp;
	  	
		elsif (control = "111" ) then

		  temp := rand_temp(2) xor rand_temp(3);
          temp2 := rand_temp(4) xor rand_temp(6);
          rand_temp(7 downto 5) := rand_temp(6 downto 4);
          rand_temp(4) := temp;		
          rand_temp(3 downto 1) := rand_temp(2 downto 0 );
          rand_temp(0):= temp2;

		elsif (control = "000" ) then  
		  temp := rand_temp(2) xor rand_temp(3);
                  temp2 := rand_temp(4) xor rand_temp(6);
                  rand_temp(7 downto 5) := rand_temp(6 downto 4);
                  rand_temp(4) := temp;        
                  rand_temp(3 downto 1) := rand_temp(2 downto 0 );
                  rand_temp(0):= temp2;

		elsif (control = "001" ) then  

		    temp := rand_temp(7) xor rand_temp(6);
            rand_temp(7 downto 1) := rand_temp(6 downto 0);
            rand_temp(0) := temp;	
        
        elsif (control = "100" ) then rand_temp := "10101010";
        
        elsif (control = "101" ) then rand_temp := "01010101";
                    	
        elsif (control = "010" ) then 
        if rand_temp(3 downto 0) = "1111" then rand_temp(3 downto 0) := "0001"; end if;   
        rand_temp(7 downto 4) :="0000";            
        temp := rand_temp(3) xor rand_temp(2);
        
        rand_temp(3 downto 1) := rand_temp(2 downto 0);
        rand_temp(0) := temp;  
        if rand_temp(3 downto 0) = "1101" then rand_temp(3 downto 0) := "0001"; end if;    
         
        elsif (control = "011" ) then  
        if rand_temp(3 downto 0) = "1111" then rand_temp(3 downto 0) := "0010"; end if;     
        rand_temp(7 downto 4) :="0000";                              
        temp := rand_temp(1) xor rand_temp(0);
        
        rand_temp(3 downto 1) := rand_temp(2 downto 0);
        rand_temp(0) := temp; 
        if rand_temp(3 downto 0) = "1011" then rand_temp(3 downto 0) := "0011"; end if;
        if rand_temp(3 downto 0) = "1101" then rand_temp(3 downto 0) := "0100"; end if;
        if rand_temp(3 downto 0) = "0000" then rand_temp(3 downto 0) := "0010"; end if;
        
		end if;
	end if;	
	
   else 
     rand_temp := (others=>'1'); 
   end if;
   
random_num <= rand_temp;	
end process;	   
end Behavioral;
