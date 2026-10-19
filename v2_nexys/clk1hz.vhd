----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 03/17/2025 12:32:45 PM
-- Design Name: 
-- Module Name: clk1hz - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity clk1hz is
    Port ( clk100 : in STD_LOGIC;
           clk1hz : out STD_LOGIC);
end clk1hz;

architecture Behavioral of clk1hz is
signal n : std_logic_vector (26 downto 0):="000000000000000000000000001";
begin            --"101111101011110000100000000"
                 --"101111101011110000011111111"
                 --"101111101011110000011111111"
clk1hz<='1' when n="101111101011110000100000000" else '0';
process(clk100)
begin
    if rising_edge(clk100) then
        if   n="101111101011110000100000000" then
            n<="000000000000000000000000001";
        else 
            n<=n+1;
        end if;
    end if;    
end process;

end Behavioral;
