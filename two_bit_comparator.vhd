----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 28.01.2024 08:52:44
-- Design Name: 
-- Module Name: twobitcomp - Behavioral
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

entity eq1 is
    Port (i0,i1: in bit ;
          eq : out bit);
end eq1;

architecture gatelevel of eq1 is
begin 
eq <= (i0 and i1) or (not(i0) and not(i1));

end gatelevel;

entity eq2 is
    Port (a,b : in bit_vector(1 downto 0) ;
          aeqb : out bit);
end eq2;

architecture struct_arch of eq2 is
signal e0,e1: bit;
begin 
eq_0_bit_unit: entity work.eq1(gatelevel) port map(i0 => a(0),i1=>b(0),eq=>e0) ;
eq_1_bit_unit: entity work.eq1(gatelevel) port map(i0 => a(1),i1=>b(1),eq=>e1) ;
aeqb <= e0 and e1;
end struct_arch;



