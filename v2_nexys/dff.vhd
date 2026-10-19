----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2025 12:48:16 PM
-- Design Name: 
-- Module Name: dff - Behavioral
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

entity dff is
    Port ( D : in STD_LOGIC;
           S : in STD_LOGIC;
           R : in STD_LOGIC;
           clk100 : in std_logic;
           Q : out STD_LOGIC);
end dff;

architecture Behavioral of dff is
        
begin
--c1: clk1hz port map (clk100=>clk100,clk1hz=>clk);
process(clk100)
begin
    if clk100'event and clk100 = '1' then 
        if S='0' then Q<='1';
        elsif R='0' then Q<='0';
        else  Q<=D;
        end if;
    end if;
end process;

end Behavioral;
