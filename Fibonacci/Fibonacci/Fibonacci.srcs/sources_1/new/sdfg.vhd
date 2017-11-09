library ieee;
use ieee.std_logic_1164.all,
ieee.std_logic_unsigned.all,
ieee.std_logic_arith.all;

entity Fibonacci_Gen is
    generic (n : natural := 8);
    port( ck, reset: in std_logic;
	z: out std_logic_vector(n-1 downto 0));
end Fibonacci_Gen;

architecture beh of Fibonacci_Gen is
signal temp1, temp2 :
	std_logic_vector(n - 1 downto 0);
begin

process(ck)
    begin
	if ck='1' and ck'event then
	    if reset='1' then
		temp1 <= (0 =>'1', others => '0');
		temp2 <= (0 =>'1', others => '0');
	     else
		temp1 <= temp1 + temp2;
		temp2 <= temp1;
		end if;
	      end if;
	end process;
z <= temp1;

end beh;