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
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

ENTITY right_shift IS
    PORT (
        v_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        v_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        samt : IN STD_LOGIC_VECTOR(2 DOWNTO 0));
END right_shift;

ARCHITECTURE arch OF right_shift IS
    SIGNAL s1, s2 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    -- right shift
    s1 <= "0" & v_in(7 DOWNTO 1) WHEN samt(0) = '1' ELSE
        v_in;
    s2 <= "00" & s1(7 DOWNTO 2) WHEN samt(1) = '1' ELSE
        s1;
    v_out <= "0000" & s2(7 DOWNTO 4) WHEN samt(2) = '1' ELSE
        s2;

END arch;

-- bit reverse
LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;
USE IEEE.STD_LOGIC_ARITH.ALL;
USE IEEE.STD_LOGIC_UNSIGNED.ALL;

ENTITY BitReverser IS
    PORT (
        input_vector : IN STD_LOGIC_VECTOR (7 DOWNTO 0);
        output_vector : OUT STD_LOGIC_VECTOR (7 DOWNTO 0));
END BitReverser;

ARCHITECTURE Behavioral OF BitReverser IS
BEGIN
    PROCESS
    BEGIN
        FOR i IN 0 TO 7 LOOP
            output_vector(i) <= input_vector(7 - i);
        END LOOP;
    END PROCESS;
END Behavioral;

--

LIBRARY IEEE;
USE IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

ENTITY multi_function_barrel_shifter IS
    PORT (
        v_in : IN STD_LOGIC_VECTOR(7 DOWNTO 0);
        lr : IN STD_LOGIC;
        v_out : OUT STD_LOGIC_VECTOR(7 DOWNTO 0);
        samt : IN STD_LOGIC_VECTOR(2 DOWNTO 0));
END multi_function_barrel_shifter;
ARCHITECTURE arch_1 OF multi_function_barrel_shifter IS
    SIGNAL s1, s2, s3, s4, s5, s6 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN
    -- right shift
    s1 <= "0" & v_in(7 DOWNTO 1) WHEN samt(0) = '1' ELSE
        v_in;
    s2 <= "00" & s1(7 DOWNTO 2) WHEN samt(1) = '1' ELSE
        s1;
    s3 <= "0000" & s2(7 DOWNTO 4) WHEN samt(2) = '1' ELSE
        s2;

    -- left shift
    s4 <= v_in(6 DOWNTO 0) & "0" WHEN samt(0) = '1' ELSE
        v_in;
    s5 <= s4(5 DOWNTO 0) & "00" WHEN samt(1) = '1' ELSE
        s4;
    s6 <= s5(3 DOWNTO 0) & "0000" WHEN samt(2) = '1' ELSE
        s5;
    v_out <= s3 WHEN lr = '1' ELSE
        s6;
END arch_1;
ARCHITECTURE arch_2 OF multi_function_barrel_shifter IS
    SIGNAL s1, s2, s3, s4 : STD_LOGIC_VECTOR(7 DOWNTO 0);
BEGIN

    r_shift_unit : ENTITY work.right_shift(arch)
        PORT MAP(
            v_in => v_in,
            samt => samt,
            v_out => s1
        );
    reverse_unit_1 : ENTITY work.BitReverser(Behavioral)
        PORT MAP(
            input_vector => v_in,
            output_vector => s2
        );
    l_shift_unit : ENTITY work.right_shift(arch)
        PORT MAP(
            v_in => s2,
            samt => samt,
            v_out => s3
        );
    reverse_unit_2 : ENTITY work.BitReverser(Behavioral)
        PORT MAP(
            input_vector => s3,
            output_vector => s4
        );

    v_out <= s1 WHEN lr = '1' ELSE
        s4;

END arch_2;