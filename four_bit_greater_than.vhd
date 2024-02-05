library ieee;
use ieee.std_logic_1164.all;


--eq_2 unit from ch1

entity eq1 is
    Port (i0,i1: in std_logic ;
          eq : out std_logic);
end eq1;

architecture gate_level of eq1 is
begin 
eq <= (i0 and i1) or (not(i0) and not(i1));

end gate_level;

library ieee;
use ieee.std_logic_1164.all;

entity eq2 is
    Port (a, b : in std_logic_vector(1 downto 0);
          aeqb : out std_logic);
end eq2;

architecture struct_arch of eq2 is
    signal e0, e1: std_logic;
begin 
    eq_0_bit_unit: entity work.eq1(gate_level) port map(i0 => a(0), i1 => b(0), eq => e0);
    eq_1_bit_unit: entity work.eq1(gate_level) port map(i0 => a(1), i1 => b(1), eq => e1);
    aeqb <= e0 and e1;
end struct_arch;



--a_greater_b 2-bit unit gate_level implementation


library ieee;
use ieee.std_logic_1164.all;

entity agreaterb2 is
    Port (a,b : in std_logic_vector(1 downto 0) ;
          agreaterb : out std_logic);
end agreaterb2;

architecture gate_level of agreaterb2 is
begin 

agreaterb <= (a(1)and(not b(1))) or (a(0) and not(b(0)) and not(b(1))) or (not(b(0)) and a(0) and a(1))  ;
end gate_level;



--task 2.6.1 a_greater_b 4-bit unit implementation


library ieee;
use ieee.std_logic_1164.all;

entity agreaterb4 is
    Port (a,b : in std_logic_vector(3 downto 0) ;
          agreaterb : out std_logic);
end agreaterb4;

architecture arch of agreaterb4 is
signal e0,e1,e2: std_logic;
begin 
e0_unit: entity work.agreaterb2(gate_level) port map(a => a(3 downto 2),b=>b(3 downto 2),agreaterb=>e0) ;
e1_unit: entity work.eq2(struct_arch) port map(a => a(3 downto 2),b=>b(3 downto 2),aeqb=>e1) ;
e2_unit: entity work.agreaterb2(gate_level) port map(a => a(1 downto 0),b=>b(1 downto 0),agreaterb=>e2) ;


agreaterb <= e0 or (e1 and e2)  ;
end arch;



















