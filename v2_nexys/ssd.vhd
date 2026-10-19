
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;



entity display_4_ssd is
    Port (
        clk: in std_logic;
        ssd1: in std_logic_vector (0 to 6);
        ssd2: in std_logic_vector (0 to 6);
        ssd3: in std_logic_vector (0 to 6);
        ssd4: in std_logic_vector (0 to 6);
        AN: out std_logic_vector (0 to 3);
        seg : out std_logic_vector (0 to 6)
        );
end display_4_ssd;

architecture Behavioral of display_4_ssd is
signal N: std_logic_vector(27 downto 0):=(others=>'0');
signal ant: std_logic_vector (0 to 3);

begin

process(clk)
begin
    if clk'event and clk='1' then
        N<=N+1;
    end if;
end process;

AN<= ant;
ant<="0111" when N(17)='0' and N(16)='0' ELSE
    "1011" when N(17)='0' and N(16)='1' ELSE
    "1101" when N(17)='1' and N(16)='0' else
    "1110";

seg<=ssd1  when  ant="0111" 
                 ELSE
     ssd2  when  ant="1011"
                 ELSE
     ssd3  when  ant="1101"
                 ELSE
     ssd4;
    
end Behavioral;
