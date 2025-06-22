library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity enter_sensor_logic is
    Port (
        enter_sig         : in  std_logic;
        max_occupancy     : in  unsigned(7 downto 0);
        current_occupancy : in  unsigned(7 downto 0);
        can_enter         : out std_logic
    );
end enter_sensor_logic;

architecture beh of enter_sensor_logic is
begin
    process(enter_sig, max_occupancy, current_occupancy)
    begin
        if enter_sig = '1' and current_occupancy < max_occupancy then
            can_enter <= '1';
        else
            can_enter <= '0';
        end if;
    end process;
end beh;

