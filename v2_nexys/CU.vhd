----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/05/2025 12:49:51 PM
-- Design Name: 
-- Module Name: CU - Behavioral
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

entity CU is
    Port (
            clk: in std_logic;
            m: in std_logic;
            s: in std_logic;
            start_stop: in std_logic;
            finished_counting: in std_logic;
            finished_alarm: in std_logic;
            enable: out std_logic;
            enable_alarm: out std_logic;
            direction: out std_logic;
            add_m: out std_logic;
            add_s: out std_logic;
            reset: out std_logic;
            alarm: out std_logic
            
         );
end CU;

architecture Behavioral of CU is



component debouncer_special is
    Port ( btn : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           btn_db : out STD_LOGIC);
end component;

component debouncer is
    Port ( btn : in STD_LOGIC;
           clk100mhz : in STD_LOGIC;
           btn_db : out STD_LOGIC);
end component;

signal state: std_logic_vector (2 downto 0):= (others=>'0');
signal ss: std_logic;
signal sdb: std_logic;
signal mdb: std_logic;
signal resett: std_logic :='0';
signal clk_slow: std_logic;
signal dec: std_logic_vector (0 to 1);
signal nextstate: std_logic_vector (2 downto 0):=(others=>'0');
signal reset_state: std_logic :='0';
signal reset_and: std_logic :='0';
signal reset_or: std_logic :='0';
begin

----------------------------------------------------------------------------------------------------------
--variables and gates
--n<=state;

db1: debouncer port map(btn=>s,clk100mhz=>clk,btn_db=>sdb);
db2: debouncer port map(btn=>m,clk100mhz=>clk,btn_db=>mdb);
db_special1: debouncer_special port map(btn=>start_stop,clk100mhz=>clk,btn_db=>ss);

process(clk)
begin
if rising_edge(clk) then
    if reset_state='0' and reset_and='1' then reset_state<='1';
    elsif reset_state='1' and reset_or='0' then reset_state<='0';
    end if; 
end if;
end process;
reset_and<=mdb and sdb;
reset_or<=mdb or sdb;
resett<=reset_state;
dec<=mdb & sdb;
reset<=resett;
add_m<='1' when mdb='1' and state /= "100" else '0';
add_s<='1' when sdb='1' and state /= "100" else '0';
enable<='1' when (state="001" or state="011") else '0';
direction<='0' when state="011" else '1';
enable_alarm<= '1' when state="100" else '0';
alarm<='1' when state="100" else '0';


---------------------------------------------------------------------------------------------------------
--process for states
--process(state,resett,finished_alarm,finished_counting,dec,ss)
process(state,finished_alarm,finished_counting,ss,dec,clk)
begin
    --if  resett='1' then nextstate<="000";
    if   state="100"  and finished_alarm='0' then NULL;
    elsif finished_alarm='1' then nextstate<="000";
    elsif   state="011" and finished_counting='1' then nextstate<="100";
    else
        if dec="10" then  nextstate<="010";
        elsif dec="01" then  nextstate<="010";
        elsif dec="00" then 
                if ss='1' then 
                    if    state="000" then nextstate<="001";
                    elsif state="001" then nextstate<="000";
                    elsif state="010" then nextstate<="011";
                    elsif state="011" then nextstate<="010";
                    end if;
                elsif ss='0' then nextstate<=state;                
                end if;
        end if;
    end if;            
end process;

process(clk)
begin
if rising_edge(clk) then
    if resett='1' then state<="000";

    else state<=nextstate;
    end if;
end if;
end process;

end Behavioral;
