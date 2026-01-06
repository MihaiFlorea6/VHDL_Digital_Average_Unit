----------------------------------------------------------------------------------
-- Company: TUCN - Digital Systems Design Project
-- Engineer: Mihai Florea
-- 
-- Design Name: filter - Behavioral
-- Project Name: DIGITAL AVERAGE UNIT
-- Target Devices: Nexys A7-100T
-- Tool Versions: Vivado™ Design Suite 2025.1
-- Description: Accumulate input data and coordinates display.
--              Uses Clock Enable for synchronous operation.
----------------------------------------------------------------------------------

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity filter is
    port ( 
        i_clk_nexys: in std_logic;
        i_clk_ce: in std_logic; 
        i_reset: in std_logic; 
        i_length: in std_logic_vector(2 downto 0);
        i_data: in std_logic_vector(7 downto 0);
        o_an: out std_logic_vector(7 downto 0);
        o_seg: out std_logic_vector(6 downto 0)   
    );
end filter;

architecture Behavioral of filter is
    signal r_accumulator: unsigned(11 downto 0) := (others => '0');
    signal w_average: std_logic_vector(7 downto 0);
    signal w_bcd_avg: std_logic_vector(11 downto 0);
    signal w_bcd_in: std_logic_vector(11 downto 0);
    signal w_new_seq: std_logic;
    signal w_digits: std_logic_vector(31 downto 0);
begin

    -- Counter instance to signal sequence end 
        INST_SEQ_CNT: entity work.counter
            port map (
                i_clk => i_clk_nexys,
                i_reset => i_reset,
                i_length => i_length,
                o_new_seq => w_new_seq
            );
    
        -- Accumulation Logic 
        process(i_clk_nexys)
        begin
            if rising_edge(i_clk_nexys) then
                if i_reset = '1' or w_new_seq = '1' then
                    r_accumulator <= (others => '0');
                elsif i_clk_ce = '1' then
                    -- Direct addition using numeric_std
                    r_accumulator <= r_accumulator + unsigned(i_data);
                end if;
            end if;
        end process;
    
        -- Average calculation unit
        INST_MEDIA: entity work.average
            port map (
                i_clk => i_clk_nexys,
                i_sum => std_logic_vector(r_accumulator(7 downto 0)),
                i_length => i_length,
                o_average => w_average
            );
    
        -- Binary to BCD Conversion
        INST_BCD_AVG: entity work.bin8bcd port map(i_bin => w_average, o_bcd => w_bcd_avg);
        INST_BCD_IN : entity work.bin8bcd port map(i_bin => i_data, o_bcd => w_bcd_in);
    
        -- Pack digits for SSD: [Avg Digit 2-0] [Empty] [In Digit 2-0] [Empty]
        w_digits <= x"0" & w_bcd_in & x"0" & w_bcd_avg;
    
        -- Display Controller instance [cite: 343]
        INST_SSD: entity work.ssd
            port map (
                i_clk => i_clk_nexys,
                i_digits => w_digits,
                o_an => o_an,
                o_seg => o_seg
            );
   
end Behavioral;