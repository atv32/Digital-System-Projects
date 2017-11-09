----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2017 11:06:26 PM
-- Design Name: 
-- Module Name: weight_cmp - Behavioral
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

entity weight_cmp is
generic(n: natural);

Port ( x : in std_logic_vector(n-1 downto 0);
       y : in std_logic_vector(n-1 downto 0);
       z : out std_logic_vector(n-1 downto 0)
       );
end weight_cmp;

architecture Behavioral of weight_cmp is
begin
process(x, y)
subtype my_int is integer range 0 to n;
variable countx, county: my_int;
begin
countx := 0; county := 0;
for i in n-1 downto 0 loop
    if x(i)='1' then countx := countx + 1;
    end if;
    if y(i)='1' then county := county + 1;
    end if;
end loop;
if countx > county then z <= x;
else z <= y;
end if;
end process;

end Behavioral;

library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity weight_cmp_tb is
port (x : in std_logic_vector(3 downto 0);
      y : in std_logic_vector(3 downto 0);
      z : out std_logic_vector(3 downto 0)
      );
end weight_cmp_tb;

architecture struc of weight_cmp_tb is
component weight_cmp
generic(n: natural);
port (x : in std_logic_vector(n-1 downto 0);
      y : in std_logic_vector(n-1 downto 0);
      z : out std_logic_vector(n-1 downto 0)
      );
end component;
begin
DUT: weight_cmp generic map(4)
port map(x, y, z);
end struc;