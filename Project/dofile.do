vsim RoomCounter
view wave

# Inputs
add wave clk
add wave reset
add wave enter_sensor
add wave exit_sensor
add wave max_occupancy

# Outputs
add wave current_occupancy
add wave max_capacity

# Initialize signals (reset on)
force clk 0 0ns, 1 2ns -repeat 4ns

force reset 1
force enter_sensor 0
force exit_sensor 0
force max_occupancy 00000000

run 10 ns
force reset 0
force max_occupancy 00000011

# --- Testing Edge Case --- (exit sensor is on when no one is in the room)
force exit_sensor 1
run 10 ns
force exit_sensor 0
run 10 ns


# --- Person 1 enters --- (+1 person test long enter_sensor signal)
force enter_sensor 1
run 20 ns
force enter_sensor 0
run 5 ns

# --- Person 2 enters --- (+1 person)
force enter_sensor 1
run 5 ns
force enter_sensor 0
run 5 ns

# --- Person 3 enters --- (+1 person)
force enter_sensor 1
run 5 ns
force enter_sensor 0
run 5 ns

# --- Try to let 4th person in (room full) ---
force enter_sensor 1
run 10 ns
force enter_sensor 0
run 5 ns

# --- One person exits ---
force exit_sensor 1
run 5 ns
force exit_sensor 0
run 5 ns

# --- Try letting 4th person in again (should work now) ---
force enter_sensor 1
run 5 ns
force enter_sensor 0
run 30 ns

# End simulation
