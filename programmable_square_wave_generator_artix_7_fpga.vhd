----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05.02.2024 08:57:51
-- Design Name: 
-- Module Name: proq_square_wave_gen - Behavioral
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
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity proq_square_wave_gen is
    Port (n,m : in integer;
        clk,reset: in std_logic;
        output: out std_logic);
end proq_square_wave_gen;

architecture Behavioral of proq_square_wave_gen is

signal next_state,cur_state: unsigned(32 downto 0);      -- extra bit to accomodate for the voltage output signal
signal cur_counter, next_counter: unsigned(31 downto 0); -- more intuitive than using indexing
signal cur_v, next_v : std_logic;                                -- more intuitive than using indexing

begin
    -- memory logic
    process(clk,reset)
    begin
        if reset = '1' then
            cur_state <= (others => '0');
            cur_state(32) <= '1';
        elsif rising_edge(clk) then
            cur_state <= next_state;

        end if;
    end process;

    -- next_state logic
    cur_counter <= cur_state(31 downto 0);
    cur_v <= cur_state(32);

    next_counter <= (cur_counter + 1) when (cur_counter /= to_unsigned(m+n-1,32)) else
                    (others => '0');
     
    next_v <= not(cur_v) when (cur_counter = to_unsigned(m-1,32)) else cur_v;

    next_state <= (next_v & next_counter);

    -- output logic
    output <= cur_v;

end Behavioral;
