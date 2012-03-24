
library ieee;
use ieee.std_logic_1164.all;

entity foo_entity is

  port(
    data_i  : in  std_logic_vector(1 downto 0);
    data_o  : out std_logic_vector(3 downto 0)
  );

end foo_entity;

architecture behaviour of foo_entity is

begin

  data_o <= "0001" when ( data_i="00" ) else
            "0010" when ( data_i="01" ) else
            "0100" when ( data_i="10" ) else
            "1000";

end behaviour;

