library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity cnt_0_9 is
    Port (
        clk : in std_logic;
        enable : in std_logic;
        dir : in std_logic;
        reset : in std_logic;
        q : out std_logic_vector (3 downto 0);
        cout : out std_logic
    
    );
end cnt_0_9;

architecture Behavioral of cnt_0_9 is
signal n: std_logic_vector (3 downto 0):=(others=>'0');
begin
cout<='1' when ((n="1001" and dir='1') or (n="0000" and dir='0')) else '0';
q<=n;

process(clk)
begin
if clk'event and clk='1' then
    if reset='1' then n<="0000";
    else
        if enable='1' then
            if dir='1' then
                if n="1001" then n<="0000";
                else n<=n+1;
                end if;
            else
                if n="0000" then n<="1001";
                else n<=n-1;
                end if;
            end if;
        end if;
    end if;
end if;
end process;
end Behavioral;
