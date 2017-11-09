library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity max_gen is
generic (n : natural);
port (x, y : in std_logic_vector(n-1 downto 0);
         z : out std_logic_vector(n-1 downto 0)
         );
end max_gen;

architecture Behavioral of max_gen is
begin

process(x, y)
subtype my_int is integer range 0 to 2**n - 1;
variable x_num, y_num: my_int;
begin
-- converting vectors to numbers

x_num := 0; y_num := 0;
for i in 0 to n-1 loop

if x(i) = '1' then x_num := x_num + 2**i; end if;
if y(i) = '1' then y_num := y_num + 2**i; end if;
end loop;

-- compare number output vector
if x_num > y_num then z <= x; else z <= y; end if;
end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity max3 is
port (p, q, r : in std_logic_vector(2 downto 0);
            z : out std_logic_vector(2 downto 0)
      );
end max3;

architetcture struc of max3 is
component max_gen
generic (n : natural);
port( x, y : in std_logic_vector(n-1 downto 0);
         z : out std_logic_vector(n-1 downto 0)
     );
end component;
signal w: std_logic_vector(2 downto 0);
begin
-- bubble max to output
u1: max_gen generic map(3) port map
    (x => p, y => q, z => w);
u2: max_gen generic map(3) port map
    (x => w, y => r, z => z);
 end struc;
 
    
