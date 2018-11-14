----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 19:46:46 04/20/2018 
-- Design Name: 
-- Module Name: div - Behavioral 
-- Project Name: 
-- Target Devices: 
-- Tool versions: 
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;
-- Uncomment the following library declaration if instantiating
-- any Xilinx primitives in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity DivFrec is
Generic ( n : integer);
Port ( clk : in STD_LOGIC;
clkout : out STD_LOGIC);
end DivFrec;
architecture Behavioral of DivFrec is
--signal cnt : std_logic_vector(29 downto 0);--536_870_912 > 300_000_000
signal temp : integer range 0 to n*50_000_000:=0;
begin

process(clk)
begin
if rising_edge(clk) then
temp <= temp + 1;
end if;

if temp = 0 then
clkout <= '1';
else
clkout <= '0';
end if;


--if (cnt = x"5F5E100") then
-- cnt <= x"000000"&"00";
-- clkout <= '0';
--end if;
end process;

end Behavioral;