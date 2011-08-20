--
-- Author: Pawel Szostek (pawel.szostek@cern.ch)
-- Date: 28.07.2011

LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity mask is
    port (input : in std_logic_vector(15 downto 0);
          mask  : in std_logic_vector(15 downto 0);
          output : out std_logic_vector(15 downto 0)
    );
end;

architecture behaviour of mask is
begin
    L: process(input)
        variable tmp : std_logic_vector(15 downto 0);
    begin
        tmp := input;
        tmp := tmp and mask; 
        output <= tmp;
    end process;
end;
