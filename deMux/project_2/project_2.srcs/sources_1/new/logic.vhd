library IEEE;
use IEEE.STD_LOGIC_1164.ALL;


entity demux_gen is
    generic (m : natural);
    Port (  x : in std_logic;
            z : out std_logic_vector(2**m - 1 downto 0);
            sel : in std_logic_vector(m-1 downto 0)
             );
end demux_gen;

architecture Behavioral of demux_gen is

begin
process(x ,sel)
subtype my_int is integer range 0 to 2**m - 1;
variable j : my_int;
begin

j := 0;
for i in 0 to m-1 loop
    if sel(i) = '1' then
        j := j + 2**i;
    end if;
end loop;

for i in 0 to 2**m - 1 loop
    if i=j then 
        z(i) <= x; else
        z(i) <= '0';
    end if;
end loop;

end process;
end Behavioral;
