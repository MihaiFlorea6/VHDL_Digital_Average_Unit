----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: bin8bcd - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Converts an 8-bit binary number to a 12-bit BCD
--              representation (3 digits) for 7-segment display.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity bin8bcd is
    port (
        i_bin: in std_logic_vector (7 downto 0);
        o_bcd: out std_logic_vector (11 downto 0)
    );
end bin8bcd;

architecture Behavioral of bin8bcd is
begin
    process(i_bin)
        variable v_temp : unsigned(19 downto 0); -- [0..7] binary, [8..19] BCD bits
    begin
        v_temp := (others => '0');
        v_temp(7 downto 0) := unsigned(i_bin);

        for i in 0 to 7 loop
            -- Check each BCD digit and add 3 if > 4 (Double Dabble)
            if v_temp(11 downto 8) >= 5 then v_temp(11 downto 8) := v_temp(11 downto 8) + 3; end if;
            if v_temp(15 downto 12) >= 5 then v_temp(15 downto 12) := v_temp(15 downto 12) + 3; end if;
            if v_temp(19 downto 16) >= 5 then v_temp(19 downto 16) := v_temp(19 downto 16) + 3; end if;
            
            -- Shift left by 1
            v_temp := shift_left(v_temp, 1);
        end loop;

        o_bcd <= std_logic_vector(v_temp(19 downto 8));
    end process;
end Behavioral;