----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 30.01.2024 06:46:55
-- Design Name: 
-- Module Name: dual_priority_enc - Behavioral
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

-- 12-bit active-low decoder
LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- use ieee.numeric_bit.ALL;
USE ieee.numeric_std.ALL;

ENTITY OneHotDecoder IS
  PORT (
    address : IN STD_LOGIC_VECTOR (3 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR (11 DOWNTO 0));
END OneHotDecoder;

ARCHITECTURE Behavioral OF OneHotDecoder IS
BEGIN
  PROCESS (address)
  BEGIN
    output <= (OTHERS => '1'); -- Initialize all bits to '1'
    output(to_integer(unsigned(address))) <= '0'; -- Set the selected bit to '0'
  END PROCESS;
END Behavioral;
-- 12-bit encoder 

LIBRARY ieee;
USE ieee.std_logic_1164.ALL;
-- use ieee.numeric_bit.ALL;
USE ieee.numeric_std.ALL;

ENTITY prio_encoder_twelve_bit IS
  PORT (
    input : IN STD_LOGIC_VECTOR (11 DOWNTO 0);
    output : OUT STD_LOGIC_VECTOR (3 DOWNTO 0));
END prio_encoder_twelve_bit;

ARCHITECTURE arch OF prio_encoder_twelve_bit IS
BEGIN
  output(3) <= (input(11) OR input(10) OR input(9) OR input(8)) AND (NOT(input(0))); -- added the not in(0) to avoid the compilation error later
  output(2) <= input(7) OR input(6) OR input(5) OR input(4);
  output(1) <= input(11) OR input(10) OR input(7) OR input(6) OR input(3) OR input(2);
  output(0) <= input(11) OR input(9) OR input(7) OR input(5) OR input(3) OR input(1);

END arch;
-- dual priority encoder
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY dual_priority_enc IS
  PORT (
    y1 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    y2 : OUT STD_LOGIC_VECTOR (3 DOWNTO 0);
    x : IN STD_LOGIC_VECTOR(11 DOWNTO 0));

END dual_priority_enc;

ARCHITECTURE struct OF dual_priority_enc IS
  SIGNAL s0 : STD_LOGIC_VECTOR(3 DOWNTO 0);
  SIGNAL s1, s2 : STD_LOGIC_VECTOR(11 DOWNTO 0);
BEGIN
  component_0 : ENTITY work.prio_encoder_twelve_bit(arch)
    PORT MAP(
      input => x,
      output => s0);
  y1 <= s0;

  component_1 : ENTITY work.OneHotDecoder(Behavioral)
    PORT MAP(
      address => s0,
      output => s1);
  s2 <= x AND s1;

  component_2 : ENTITY work.prio_encoder_twelve_bit(arch)
    PORT MAP(
      input => s2,
      output => y2);

END struct;