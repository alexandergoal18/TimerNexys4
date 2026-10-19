library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_unsigned.ALL;

entity debouncer_special is
    Port ( btn : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           btn_db : out STD_LOGIC);
end debouncer_special;

architecture Behavioral of debouncer_special is

component dff is
    Port ( D : in STD_LOGIC;
           S : in STD_LOGIC;
           R : in STD_LOGIC;
           clk100 : in std_logic;
           Q : out STD_LOGIC);
end component;
--signal clk_slow: std_logic;
--signal clk: std_logic;
--signal cnt: std_logic_vector(17 downto 0):=(others=>'0');
--signal n1,n2,n3,n4,n5: std_logic;
--begin

--process(clk100mhz)
--begin
--    if rising_edge(clk100mhz) then
--        cnt<=cnt+1;
--    end if;
--end process;

--clk_slow<=cnt(17);
--clk<=clk100mhz;
----d1: dff port map(btn,'1','1',clk_slow,n1);
----d2: dff port map(n1,'1','1',clk_slow,n2);
----d3: dff port map(n2,'1','1',clk_slow,n3);
----d4: dff port map(n3,'1','1',clk_slow,n4);
----d5: dff port map(n4,'1','1',clk_slow,n5);


--d1: dff port map(btn,'1','1',clk,n1);
--d2: dff port map(n1,'1','1',clk,n2);
--d3: dff port map(n2,'1','1',clk,n3);
--d4: dff port map(n3,'1','1',clk,n4);
--d5: dff port map(n4,'1','1',clk,n5);

--btn_db<=n1 and n2 and n3 and n4 and not n5;
--signal n1,n2,n3,n4,n5,n6,n7,n8,n9,n10,n11:std_logic;
--signal q: std_logic_vector(0 to 100);
--begin
--d1: dff port map(btn,'1','1',clk100mhz,q(0));
--generate_dff: for i in 1 to 99 generate dff_instance: dff port map(q(i-1),'1','1',clk100mhz,q(i));
--end generate generate_dff;
--d100: dff port map(q(99),'1','1',clk100mhz,q(100));
--btn_db<='1' when q=
--"11111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111111110"
-- else '0';
----c1: dff port map (btn,'1','1',clk100mhz,n1);
----c2: dff port map (n1,'1','1',clk100mhz,n2);
----c3: dff port map (n2,'1','1',clk100mhz,n3);
----c4: dff port map (n3,'1','1',clk100mhz,n4);
----c5: dff port map (n4,'1','1',clk100mhz,n5);
----c6: dff port map (n5,'1','1',clk100mhz,n6);
----c7: dff port map (n6,'1','1',clk100mhz,n7);
----c8: dff port map (n7,'1','1',clk100mhz,n8);
----c9: dff port map (n8,'1','1',clk100mhz,n9);
----c10: dff port map (n9,'1','1',clk100mhz,n10);
----c11: dff port map (n10,'1','1',clk100mhz,n11);
----btn_db<=n1 and n2 and n3 and n4 and n5 and n6 and n7 and n8 and n9 and n10 and not n11;
----btn_db<=n1 and n2 and not n3;

--signal q: std_logic_vector(0 to 10000);
--signal verif: std_logic_vector(0 to 9999):=(others=>'1');
--begin
--d1: dff port map(btn,'1','1',clk100mhz,q(0));
--generate_dff: for i in 1 to 9999 generate dff_instance: dff port map(q(i-1),'1','1',clk100mhz,q(i));
--end generate generate_dff;
--d100: dff port map(q(9999),'1','1',clk100mhz,q(10000));
--btn_db <= '1' when q(10000) = '0' and q(0 to 9999) = verif else '0';


signal q: std_logic_vector (17 downto 0):=(others=>'0');
signal state: std_logic:='0';
signal clk: std_logic;
begin
clk<=clk100mhz;
btn_db<=q(17);
process(clk)
begin
    if rising_edge(clk) then
        if state='1' then q<=(others=>'0');
        elsif btn='1' and state='0' then
            q<=q+1;
        end if;
    end if;
end process;



process(q(17),btn)
begin
    if q(17)='1' and btn='1' then state<='1';
    elsif state='1' and btn='0' then state<='0';
    end if;
end process;

end Behavioral;
