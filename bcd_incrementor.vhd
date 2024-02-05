----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2024 21:05:07
-- Design Name: 
-- Module Name: multi_function_barrel_shifter - Behavioral
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
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
USE ieee.numeric_std.ALL;

ENTITY bcd_inc IS
  PORT (
    clk,rst: IN std_logic
    );
END bcd_inc;

ARCHITECTURE Behavioral OF bcd_inc IS
signal bcd_temp: std_logic_vector(11 downto 0 ):= "000000000000";

BEGIN
  PROCESS (clk,rst)
    BEGIN
    if rst='1' then 
        bcd_temp <= "000000000000";
    elsif rising_edge(clk) then
        if bcd_temp="100110011001" then 
            bcd_temp <="000000000000";
        elsif bcd_temp(7 downto 0) = "10011001" then 
            bcd_temp(7 downto 0) <= "00000000";
            bcd_temp(11 downto 8) <= std_logic_vector(unsigned(bcd_temp(11 downto 8)) + 1);
        elsif bcd_temp(3 downto 0) = "1001" then
            bcd_temp(3 downto 0) <= "0000";
            bcd_temp(7 downto 4) <= std_logic_vector(unsigned(bcd_temp(7 downto 4)) + 1);
        end if;
    end if;

  END PROCESS;
END Behavioral;