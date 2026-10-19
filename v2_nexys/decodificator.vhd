library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity decoder is
 Port ( n : in std_logic_vector(3 downto 0);
        seg: out std_logic_vector(0 to 6)
        );
               
end decoder;

architecture Behavioral of decoder is
begin
seg<="0000001" when n="0000" else
     "1001111" when n="0001" else          
     "0010010" when n="0010" else          
     "0000110" when n="0011" else          
     "1001100" when n="0100" else          
     "0100100" when n="0101" else          
     "0100000" when n="0110" else          
     "0001111" when n="0111" else          
     "0000000" when n="1000" else          
     "0000100" when n="1001" else          
     "1111111";          
end Behavioral;