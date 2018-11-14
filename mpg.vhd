library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;
entity mpg is
Port (clk : in STD_LOGIC;
btn : in STD_LOGIC_VECTOR(4 DOWNTO 0);
bt : out STD_LOGIC_VECTOR(4 DOWNTO 0));
end mpg;
architecture Behavioral of mpg is
signal count : std_logic_vector (17 downto 0);
signal d1, d2, d3 : std_logic_vector(4 downto 0);

begin
process (clk)
begin
if rising_edge(clk) then
	count <= count + 1;
	if count = 0 then
		d1<=btn;
	end if;
		d2<=d1;
		d3<=d2;
	end if;
end process;

bt<=d2 and (not d3);
end Behavioral;