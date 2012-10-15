--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 27.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
USE ieee.numeric_std.all;

entity dummy is
    port (o1: out std_logic_vector(7 downto 0);
          o2: out std_logic_vector(7 downto 0);
          o3: out std_logic_vector(7 downto 0)
    );
end;

architecture behaviour of dummy is
begin
    o1 <= (others => '0');
    o2 <= (3 => '1', others => '0');
    o3 <= (7=>'1', 6|5|4|3|2|1|0 => '0', others => '1'); --tricky

end;
