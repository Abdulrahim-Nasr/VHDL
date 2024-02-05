----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 31.01.2024 10:24:23
-- Design Name: 
-- Module Name: floating_point_grt - Behavioral
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
USE ieee.numeric_std.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

-- grt: out, v1 > v2
entity floating_point_grt is
 Port (v1,v2 : in std_logic_vector(12 downto 0) ;
 grt: out std_logic);
end floating_point_grt;

architecture Behavioral of floating_point_grt is
begin
    process (v1,v2)
    begin 
        if unsigned(v1(12 downto 12)) > unsigned(v2(12 downto 12)) then 
            grt <= '1';
        elsif unsigned(v1(3 downto 0)) > unsigned(v2(3 downto 0)) then
            grt <= '1';
        elsif unsigned(v1(11 downto 4)) > unsigned(v2(11 downto 4)) then
            grt <= '1';
        else
            grt <= '0';

        end if;
    end process;

end Behavioral;
