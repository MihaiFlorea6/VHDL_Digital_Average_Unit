----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: average - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: 8-digit Seven Segment Display multiplexer.
--              Refreshes segment using an internal counter.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity ssd is
    port ( 
        i_clk: in std_logic;
        i_digits: in std_logic_vector(31 downto 0); --Packed 8 digits x 4 bits
        o_an: out std_logic_vector(7 downto 0);
        o_seg: out std_logic_vector(6 downto 0)
    );         
end ssd;

architecture Behavioral of ssd is
    -- 17-bit counter for refresh rate (~760HZ refresh at 100MHz)
    signal r_cnt: unsigned(16 downto 0) := (others => '0');
    signal w_sel: integer range 0 to 7;
    signal r_hex: std_logic_vector(3 downto 0);
begin
-- Refresh counter 
    process(i_clk)
    begin
        if rising_edge(i_clk) then
            r_cnt <= r_cnt + 1;
        end if;
    end process;

    -- Multiplexer logic for digit selection
    w_sel <= to_integer(r_cnt(16 downto 14));

    process(w_sel, i_digits)
    begin
        r_hex <= i_digits((w_sel*4 + 3) downto (w_sel*4));
        
        -- Anode activation (Active Low)
        o_an <= (others => '1');
        o_an(w_sel) <= '0';
    end process;

    -- BCD to 7-segment decoder 
    process(r_hex)
    begin
        case r_hex is
            when x"0" => o_seg <= "1000000";
            when x"1" => o_seg <= "1111001";
            when x"2" => o_seg <= "0100100";
            when x"3" => o_seg <= "0110000";
            when x"4" => o_seg <= "0011001";
            when x"5" => o_seg <= "0010010";
            when x"6" => o_seg <= "0000010";
            when x"7" => o_seg <= "1111000";
            when x"8" => o_seg <= "0000000";
            when x"9" => o_seg <= "0010000";
            when others => o_seg <= "0111111";
        end case;
    end process;   
end Behavioral;