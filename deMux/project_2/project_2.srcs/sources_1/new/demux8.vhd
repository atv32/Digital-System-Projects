library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity demux8 is
  Port (x : in std_logic;
        z : out std_logic_vector(7 downto 0);
        sel : in std_logic_vector(2 downto 0)
        );
end demux8;

architecture struc of demux8 is
component demux_gen
generic (m : natural);
Port (x : in std_logic;
      z : out std_logic_vector(2**m - 1 downto 0);
      sel : in std_logic_vector(m-1 downto 0)
        ); 
end component;
signal w: std_logic_vector(1 downto 0);
signal s: std_logic_vector(0 downto 0);
begin
s(0) <= sel(2);
U1 : demux_gen generic map(1) port map
(x => x, z => w, sel => s);
U2 : demux_gen generic map(2) port map
(x => w(0), z => z(3 downto 0), sel => sel(1 downto 0));
U3 : demux_gen generic map(2) port map
(x => w(1), z => z(7 downto 4), sel => sel(1 downto 0));
end struc;