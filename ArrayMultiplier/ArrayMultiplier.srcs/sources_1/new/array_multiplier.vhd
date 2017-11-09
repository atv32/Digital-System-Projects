library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multiplier is
  Port (x, y : in std_logic_vector(3 downto 0);
        p: out std_logic_vector(7 downto 0) );
end array_multiplier;

architecture struc of array_multiplier is

type twoD is array (natural range <>, natural range <>) of std_logic;
signal xi, yi, psi, ci : twoD(3 downto 0, 3 downto 0);
component pe
    port (xi, yi, psi, ci : in std_logic;
          xo, yo, pso, co : out std_logic);
end component;

signal GND : std_logic;
begin
GND <= '0';
INTX: for j in 0 to 3 generate
       xi(0,j) <= x(j); psi(0,j) <= GND;
        end generate INTX;
INTY: for i in 0 to 3 generate
    yi(i,0) <= y(i); ci(i,0) <= GND;
        end generate INTY;
G1: for i in 0 to 3 generate
G2: for j in 0 to 3 generate
G3: if j = 0 and i < 3 generate
    ELM: pe port map(xi(i,j), yi(i,j), psi(i,j), ci(i,j),
    xi(i+1,j), yi(i,j+1), p(i), ci(i,j+1));
    end generate G3;
G4: if j > 0 and j < 3 and i < 3 generate
    ELM: pe port map(xi(i,j), yi(i,j), psi(i,j), ci(i,j),
    xi(i+1,j), yi(i,j+1), psi(i+1, j-1), ci(i,j+1));
    end generate G4;
G5: if j = 3 and i < 3 generate
    ELM: pe port map(xi(i,j), yi(i,j), psi(i,j), ci(i,j),
    xi(i+1,j), open, psi(i+1, j-1), psi(i+1,j));
        end generate G5;
G6: if j < 3 and i = 3 generate
    ELM: pe port map(xi(i,j), yi(i,j), psi(i,j), ci(i,j),
    open, yi(i, j+1), p(i+j), ci(i, j+1));
        end generate G6;
G7: if j = 3 and i = 3 generate
    ELM: pe port map(xi(i,j), yi(i,j), psi(i,j), ci(i,j),
    open, open, p(i+j+1));
        end generate G7;
end generate G2;
end Generate G1;
end struc;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity pe is
port(xi, yi , psi, ci : in std_logic;
    xo, yo, pso, co : out std_logic);
end pe;

architecture dataflow of pe is
signal w : std_logic;
begin
xo <= xi; yo <= yi; pso <= w xor ci xor psi;
co <= (psi and w) or (w and ci) or (ci and psi);
w <= xi and yi;

end dataflow;