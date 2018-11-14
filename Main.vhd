library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity Main is
Port ( 
clk : in STD_LOGIC;
btn : in STD_LOGIC_VECTOR (4 downto 0);
sw : in STD_LOGIC_VECTOR(7 downto 0);
sw_aux : in STD_LOGIC_VECTOR(15 downto 13);
DP : out STD_LOGIC;
LED : out STD_LOGIC_VECTOR (15 downto 0);
an : out STD_LOGIC_VECTOR(0 TO 3);
an_aux : out STD_LOGIC_VECTOR(0 TO 3);
seg : out STD_LOGIC_VECTOR(6 DOWNTO 0));
end Main;
architecture Behavioral of Main is

component Mpg is
Port (clk : in STD_LOGIC;
btn : in STD_LOGIC_VECTOR(4 DOWNTO 0);
bt : out STD_LOGIC_VECTOR(4 DOWNTO 0));
end component;

component DivFrec is
Generic ( n : integer);
Port ( clk : in STD_LOGIC;
clkout : out STD_LOGIC);
end component;

component Afisor is
port(
digit0: in std_logic_vector(3 downto 0);
digit1: in std_logic_vector(3 downto 0);
digit2: in std_logic_vector(3 downto 0);
digit3: in std_logic_vector(3 downto 0);
CLK : in std_logic;
seg: out std_logic_vector(0 to 6);
ano : out std_logic_vector(3 downto 0)
);
end component;
signal bt : std_logic_vector(4 downto 0);
signal print : std_logic_vector(15 downto 0);
signal clk1,clk3,greutate,piu,func,modmers,led1,led3 : std_logic;--piu = persoana in usa
signal NrStationare : integer range 0 to 10 := 0;
type coada is array (8 downto 0) of std_logic_vector(2 downto 0);
signal Q : coada;
signal Qcnt : std_logic_vector(3 downto 0) := "1111";
signal EtajCurent : std_logic_vector(2 downto 0) := "000";
signal Qmark : std_logic_vector(7 downto 0) := "00000000";
begin
greutate <= sw_aux(15);
piu <= sw_aux(14);
modmers <= sw_aux(13);
led(7 downto 0) <= Qmark;
led(10 downto 8) <= "000";
led(15) <= greutate;
led(14) <= piu;
led(13) <= '0';
led(12) <= '0';
led(11) <= '0';
process(clk1)
begin
if rising_edge(clk1) then
led1 <= not led1;
end if;
end process;
 
process(clk3)
begin
if rising_edge(clk3) then
led3 <= not led3;
end if;
end process;

func <= (not greutate) and (not piu);

print(3 downto 0) <= "0" & EtajCurent;
--print(7 downto 4) <= '0' & Q(conv_integer(Qcnt));
--print(11 downto 8) <= Qcnt;
--print(15 downto 12) <= X"F";
-- & conv_std_logic_vector(Nrstationare,3);


DP <= '1';

Afisor1 : Afisor
port map(print(15 downto 12),print(7 downto 4),print(11 downto 8),print(3 downto 0),clk,seg,an);
an_aux <= X"F";


Mpg1 : Mpg
port map(clk,btn,bt);

DivFrec1 : DivFrec
generic map(n => 1)
port map(clk,clk1);

DivFrec2 : DivFrec
generic map(n => 3)
port map(clk,clk3);

process (clk)
begin
if rising_edge(clk) then


if bt(0) = '1' then --Coada comenzi
	if (sw(7 downto 0) and (sw(7 downto 0) - 1)) = 0 and (sw(7 downto 0) /= 0) then -- x & (x-1) == 0 <=> V k e N => 2^k == x
		if sw(7) = '1' and Qmark(7) /= '1' then
			Q(0) <= "111";
			Qmark(7) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(6) = '1' and Qmark(6) /= '1' then
			Q(0) <= "110";
			Qmark(6) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(5) = '1' and Qmark(5) /= '1' then
			Q(0) <= "101";
			Qmark(5) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(4) = '1' and Qmark(4) /= '1' then
			Q(0) <= "100";
			Qmark(4) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(3) = '1' and Qmark(3) /= '1' then
			Q(0) <= "011";
			Qmark(3) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(2) = '1' and Qmark(2) /= '1' then
			Q(0) <= "010";
			Qmark(2) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(1) = '1' and Qmark(1) /= '1' then
			Q(0) <= "001";
			Qmark(1) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		elsif sw(0) = '1' and Qmark(0) /= '1' then--nu neaparat necesar de folosit qmark
			Q(0) <= "000";
			Qmark(0) <= '1';
			Qcnt <= Qcnt + 1;
			Q( 7 downto 1 ) <= Q( 6 downto 0 );
		end if;
	end if;
end if;

	if modmers = '0' then
		if( clk1 = '1' and func = '1') then
			if( NrStationare = 5 ) then
				if( Qcnt < "1111" ) then
					if( Q(conv_integer(Qcnt)) > EtajCurent ) then
						EtajCurent <= EtajCurent + 1;
					elsif( Q(conv_integer(Qcnt)) < EtajCurent ) then
						EtajCurent <= EtajCurent - 1;
					else
						Qmark(conv_integer( Q(conv_integer(Qcnt)) ) ) <= '0';
						Qcnt <= Qcnt - 1;
						NrStationare <= 0;
					end if;
				end if;
			else
				NrStationare <= NrStationare + 1;
			end if;
		end if;
	else
		if( clk3 = '1' and func = '1') then
			if( NrStationare = 5 ) then
				if( Qcnt < "1111" ) then
					if( Q(conv_integer(Qcnt)) > EtajCurent ) then
						EtajCurent <= EtajCurent + 1;
					elsif( Q(conv_integer(Qcnt)) < EtajCurent ) then
						EtajCurent <= EtajCurent - 1;
					else
						Qmark(conv_integer( Q(conv_integer(Qcnt)) ) ) <= '0';
						Qcnt <= Qcnt - 1;
						NrStationare <= 0;
					end if;
				end if;
			end if;
		elsif(NrStationare < 5 and clk1 = '1' and func = '1') then
				NrStationare <= NrStationare + 1;
		end if;
	end if;
	
end if;

end process;
 
end Behavioral;