----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2017 09:51:37 PM
-- Design Name: 
-- Module Name: shift_reg_ld_en - Behavioral
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

entity reg_shift_both_ends is
generic(n : natural);
port (  x : in std_logic_vector(n-1 downto 0);
     y, z : out std_logic;
        w : out std_logic_vector(n-1 downto 0);
ld_en, ck : in std_logic
);
end reg_shift_both_ends;

architecture Behavioral of reg_shift_both_ends is
signal temp: std_logic_vector(n-1 downto 0);
begin

y <= temp(n-1); z <= temp(0);
w <= temp;

process(ck)
begin
if ck='1' and ck'event then
    if ld_en='1' then
        temp <= x;
    else
    for i in n-1 downto n/2+1 loop
        temp(i) <= temp(i-1);
        temp(n-1-i) <= temp(n-i);
    end loop;
    end if;
end if;
end process;
end Behavioral;

-- test

library ieee;
use ieee.std_logic_1164.all;

entity reg_sh_both_ends_tb is
port ( x : in std_logic_vector(9 downto 0);
       w : out std_logic_vector(9 downto 0);
    y, z : out std_logic;
ck, ld, btn0, btn1 : in std_logic);
end reg_sh_both_ends_tb;

architecture struc of reg_sh_both_ends_tb is

component reg_shift_both_ends
generic( n : natural);
port( x : in std_logic_vector(n-1 downto 0);
   y, z : out std_logic;
      w : out std_logic_vector(n-1 downto 0);
ld_en, ck: in std_logic
);
end component;

signal en: std_logic;

begin
DUT: reg_shift_both_ends generic map(10)
port map(x,y,z,w,ld,en);

-- single step, debounce (db)
-- btn0 to enter and btn1 to reset

process(ck)
type db_state is (not_rdy, rdy, pulse);
variable db_ns: db_state;
begin
if ck='1' and ck'event then
    case db_ns is
        when not_rdy => en <= '0';
        if btn1 = '1' then db_ns := rdy; end if;
        when rdy => en <= '0';
        if btn0 = '1' then db_ns := pulse; end if;
        when pulse => en <= '1';
        db_ns := not_rdy;
        when others => null;
    end case;
end if;
end process;

end struc; 

