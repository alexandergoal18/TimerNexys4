library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.std_logic_unsigned.ALL;

entity EU is
  Port (
        clk: in std_logic;
        enable: in std_logic;
        enable_alarm: in std_logic;
        direction: in std_logic;
        reset: in std_logic;
        adds: in std_logic;
        addm: in std_logic;
        finished: out std_logic;
        finished_alarm: out std_logic;
        AN: out std_logic_vector (0 to 7);
        cat: out std_logic_vector (0 to 6)
        );
end EU;


architecture Behavioral of EU is

component clk1hz is
    Port ( clk100 : in STD_LOGIC;
           clk1hz : out STD_LOGIC);
end component;

component cnt_0_5 is
    Port (
        clk : in std_logic;
        enable : in std_logic;
        dir : in std_logic;
        reset : in std_logic;
        q : out std_logic_vector (2 downto 0);
        cout : out std_logic
    
    );
end component;


component cnt_0_9 is
    Port (
        clk : in std_logic;
        enable : in std_logic;
        dir : in std_logic;
        reset : in std_logic;
        q : out std_logic_vector (3 downto 0);
        cout : out std_logic
    );
end component;

component ssd_display_4_with_included_decoder is
  Port (
        clk: in std_logic;
        st1: in std_logic_vector(3 downto 0);
        st2: in std_logic_vector(3 downto 0);
        st3: in std_logic_vector(3 downto 0);
        st4: in std_logic_vector(3 downto 0);
        anod: out std_logic_vector (0 to 7);
        catod : out std_logic_vector (0 to 6)        
        );
end component;

component dff is
    Port ( D : in STD_LOGIC;
           S : in STD_LOGIC;
           R : in STD_LOGIC;
           clk100 : in std_logic;
           Q : out STD_LOGIC);
end component;

signal clk_slow: std_logic;
signal clk_sl: std_logic;
signal e_count1: std_logic;
signal e_count2: std_logic;
signal e_count3: std_logic;
signal e_count4: std_logic;
signal state1: std_logic_vector (3 downto 0);
signal state2: std_logic_vector (2 downto 0);
signal state2_4: std_logic_vector (3 downto 0);
signal state3: std_logic_vector (3 downto 0);
signal state4: std_logic_vector (3 downto 0);
signal cout1:std_logic;
signal cout2:std_logic;
signal cout3:std_logic;
signal cout4:std_logic;
signal st: std_logic_vector(3 downto 0);
signal enable_alarm_dff: std_logic;
begin

finished<='1' when state1="0000" and state2_4="0000" and state3="0000" and state4="0000" else '0';
state2_4<='0'&state2;
e_count1<=enable or adds;
e_count2<=e_count1 and cout1;
e_count3<=(e_count2 and cout2) or addm;
e_count4<=e_count3 and cout3;

clk1: clk1hz port map(clk,clk_sl);
clk_slow<=clk when reset='1' else clk_sl;
counter_us: cnt_0_9 port map(clk_slow,e_count1,direction,reset,state1,cout1);
counter_zs: cnt_0_5 port map(clk_slow,e_count2,direction,reset,state2,cout2);
counter_um: cnt_0_9 port map(clk_slow,e_count3,direction,reset,state3,cout3);
counter_zm: cnt_0_9 port map(clk_slow,e_count4,direction,reset,state4,cout4); 

dff_for_alarm: dff port map(enable_alarm,'1','1',clk_slow,enable_alarm_dff);
counter_alarm: cnt_0_9 port map(clk_slow,enable_alarm_dff,'1',reset,st,finished_alarm);

display: ssd_display_4_with_included_decoder port map(clk,state1,state2_4,state3,state4,AN,cat);

end Behavioral;
