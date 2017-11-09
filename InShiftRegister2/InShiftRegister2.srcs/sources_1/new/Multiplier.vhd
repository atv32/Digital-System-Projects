library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use ieee.std_logic_arith.all,
ieee.std_logic_unsigned.all,
ieee.std_logic_signed.all;

entity Multiplier is
generic(n: natural);
Port (x, y: in std_logic_vector(n-1 downto 0);
      z: out std_logic_vector(2*n - 1 downto 0);
      sel: in std_logic );
end Multiplier;

architecture Behavioral of Multiplier is
begin

process(x,y,sel)
begin
if sel = '0' then
    z <= unsigned(x) * unsigned(y);
elsif sel = '1' then
    z <= signed(x) * signed(y);
else null;
end if;
end process;

end Behavioral;

-- test
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity Multiplier_Tb is
Port (x,y: in std_logic_vector(3 downto 0);
      z: out std_logic_vector(7 downto 0);
      sel: in std_logic);
end Multiplier_Tb;

architecture struc of Multiplier_Tb is

component Multiplier
generic (n: natural);
Port (x,y: in std_logic_vector(n-1 downto 0);
      z: out std_logic_vector(2*n - 1 downto 0);
      sel: in std_logic );
end component;

begin

DUT: Multiplier
generic map (4)
port map (x,y,z,sel);

end struc;