library IEEE;
use IEEE.std_logic_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity RoomCounter is
    port(	
        clk, reset, enter_sensor, exit_sensor : in std_logic;
        max_occupancy                         : in std_logic_vector(7 downto 0);
        current_occupancy                     : out std_logic_vector(7 downto 0);
        max_capacity                          : out std_logic
    );
end RoomCounter;

architecture beh of RoomCounter is

    -- Enter_sensor logic
    component enter_sensor_logic
        port (
            enter_sig         : in  std_logic;
            max_occupancy     : in  unsigned(7 downto 0);
            current_occupancy : in  unsigned(7 downto 0);
            can_enter         : out std_logic
        );
    end component;

    -- Internal signals
    signal occupancy_count : unsigned(7 downto 0);
    signal occupancy_next  : unsigned(7 downto 0);

    signal entering        : std_logic;  -- output of sensor logic
    signal entering_prev   : std_logic := '0';
    signal entered         : std_logic;

    signal exit_prev       : std_logic := '0';
    signal exited          : std_logic;

begin

    -- Instantiate enter_sensor_logic component
    u_enter_sensor: enter_sensor_logic
        port map (
            enter_sig         => enter_sensor,
            max_occupancy     => unsigned(max_occupancy),
            current_occupancy => occupancy_count,
            can_enter         => entering
        );

    -- Flip-flop to store previous entering and exiting signal
    process(clk, reset)
    begin
        if reset = '1' then
            entering_prev <= '0';
            exit_prev     <= '0';
        elsif rising_edge(clk) then
            entering_prev <= entering;
            exit_prev     <= exit_sensor;
        end if;
    end process;

    -- Rising edge detection
    entered <= entering and not entering_prev;
    exited  <= exit_sensor and not exit_prev;

    -- Occupancy update logic
    occupancy_next <= occupancy_count + 1 when entered = '1' and occupancy_count < 255 else
                      occupancy_count - 1 when exited = '1' and occupancy_count > 0 else
                      occupancy_count;

    -- DFF to store occupancy count
    process(clk, reset)
    begin
        if reset = '1' then
            occupancy_count <= (others => '0');
        elsif rising_edge(clk) then
            occupancy_count <= occupancy_next;
        end if;
    end process;

    -- Output assignments
    current_occupancy <= std_logic_vector(occupancy_count);
    max_capacity      <= '1' when occupancy_count = unsigned(max_occupancy) else '0';

end beh;

