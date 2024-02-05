----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2024 22:18:06
-- Design Name: 
-- Module Name: param_barrel_shifter - Behavioral
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
entity right_shift is
generic(N: integer :=3);
 Port ( v_in: in std_logic_vector(2**N-1 downto 0);
        v_out: out std_logic_vector(2**N-1 downto 0);
        samt: in std_logic_vector(N-1 downto 0));
end right_shift;

architecture arch of right_shift is
	type     MEM_TYPE is array(0 to 2**CHANNEL_WIDTH - 1, 0 to MEM_DEPTH - 1) of std_logic_vector(DATA_WIDTH - 1 downto 0);



    signal s1,s2: std_logic_vector(7 downto 0);
begin
    -- right shift
    s1 <= "0"&v_in(7 downto 1) when samt(0) = '1' else v_in;
    s2 <= "00"&s1(7 downto 2) when samt(1) = '1' else s1;
    v_out <= "0000"&s2(7 downto 4) when samt(2) = '1' else s2;
   


end arch;
