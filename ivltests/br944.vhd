library ieee;
use ieee.std_logic_1164.all;

entity e is
  port (
    clk : in  std_logic;
    rst : in  std_logic;
    q   : out std_logic);
end e;

architecture a of e is

  type t is (one, zero);

  signal r : std_logic;

begin

   q <= r;

   process(clk)
   begin
     if rising_edge(clk) then
       if rst = '1' then
         r <= '0';
       else
         r <= not r;
       end if;
     end if;
   end process;
end a;
