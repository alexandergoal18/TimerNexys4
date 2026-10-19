----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 05/13/2025 02:17:01 PM
-- Design Name: 
-- Module Name: high - Behavioral
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

entity high is
    Port (
        m:in std_logic;
        s:in std_logic;
        clk:in std_logic;
        start_stop:in std_logic;
        alarm:out std_logic;
        an:out std_logic_vector (0 to 7);
        cat:out std_logic_vector (0 to 6)
    );
end high;

architecture Behavioral of high is

component EU is
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
end component;

component CU is
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
end component;
signal enable: std_logic;
signal enable_alarm: std_logic;
signal direction: std_logic;
signal reset: std_logic;
signal addm: std_logic;
signal adds: std_logic;
signal finished: std_logic;
signal finished_counting: std_logic;
signal finished_alarm: std_logic;
signal anod: std_logic_vector(0 to 7);

begin
an<=anod;
l1: EU port map (clk,enable,enable_alarm,direction,reset,adds,addm,finished_counting,finished_alarm,anod,cat);
l2: CU port map (clk,m,s,start_stop,finished_counting,finished_alarm,enable,enable_alarm,direction,addm,adds,reset,alarm);
end Behavioral;
