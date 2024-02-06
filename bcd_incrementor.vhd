----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 06.02.2024 21:34:59
-- Design Name: 
-- Module Name: test_bcd_inc - Behavioral
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

entity test_bcd_inc is
  PORT (
    clk,rst: IN std_logic;
    output: out unsigned(11 downto 0)
    );
 end test_bcd_inc;

architecture Behavioral of test_bcd_inc is

signal cur_state,next_state: unsigned(11 downto 0 );

begin
PROCESS (clk,rst)
    BEGIN
    if rst='1' then 
        cur_state <= (others => '0');
    elsif rising_edge(clk) then
        cur_state <= next_state;
    end if;

  END PROCESS;
   -- counter/next_state logic
  process(cur_state)
  begin
  if cur_state="100110011001" then 
      next_state <= (others => '0');
  elsif cur_state(7 downto 0) = "10011001" then 
      next_state <=  (cur_state(11 downto 8) + 1) &  ("00000000") ;
  elsif cur_state(3 downto 0) = "1001" then
      next_state <= (cur_state(11 downto 8) ) & (cur_state(7 downto 4) + 1) & ("0000");
  else 
      next_state <= cur_state + 1;
  end if; 
  end process;

-- output logic
    output <= cur_state;
end Behavioral;
