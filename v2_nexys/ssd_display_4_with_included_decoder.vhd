library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
entity ssd_display_4_with_included_decoder is
  Port (
        clk: in std_logic;
        st1: in std_logic_vector(3 downto 0);
        st2: in std_logic_vector(3 downto 0);
        st3: in std_logic_vector(3 downto 0);
        st4: in std_logic_vector(3 downto 0);
        anod: out std_logic_vector (0 to 7);
        catod : out std_logic_vector (0 to 6)        
        );
end ssd_display_4_with_included_decoder;

architecture Behavioral of ssd_display_4_with_included_decoder is

component decoder is
 Port ( n : in std_logic_vector(3 downto 0);
        seg: out std_logic_vector(0 to 6)
        );
               
end component;

component display_4_ssd is
    Port (
        clk: in std_logic;
        ssd1: in std_logic_vector (0 to 6);
        ssd2: in std_logic_vector (0 to 6);
        ssd3: in std_logic_vector (0 to 6);
        ssd4: in std_logic_vector (0 to 6);
        AN: out std_logic_vector (0 to 3);
        seg : out std_logic_vector (0 to 6)
        );
end component;

signal seg1: std_logic_vector(0 to 6);
signal seg2: std_logic_vector(0 to 6);
signal seg3: std_logic_vector(0 to 6);
signal seg4: std_logic_vector(0 to 6);
signal ant:  std_logic_vector(0 to 3);
begin

d1: decoder port map(st1,seg1);
d2: decoder port map(st2,seg2);
d3: decoder port map(st3,seg3);
d4: decoder port map(st4,seg4);

ssd: display_4_ssd port map(clk,seg1,seg2,seg3,seg4,ant,catod);
anod<="1111"&ant;
end Behavioral;
