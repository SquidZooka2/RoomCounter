# RoomCounter
Digital Systems project. Real-time system with photocell sensors

# Room Occupancy Monitoring System

This project implements a **digital room occupancy counter** using VHDL. It simulates a smart room that tracks the number of people entering and exiting via binary sensor signals, and prevents over-occupancy by asserting a `max_capacity` signal when full.

✅ Designed for use with ModelSim and target synthesis on a Xilinx Nexys A7 FPGA board.

---

## 🔧 Features

- Tracks the number of occupants using `enter_sensor` and `exit_sensor`
- Programmable 8-bit maximum occupancy
- Outputs current occupancy and a `max_capacity` flag when full
- Simulates real-world entry with 20 ns pulse-based inputs
- Includes a ModelSim `.do` file to automate testing
- Synthesizable and resource-efficient for FPGA deployment

---

## 📁 File Structure

| File/Folder           | Description                                  |
|-----------------------|----------------------------------------------|
| `project.vhd`         | Top-level entity: `RoomCounter`              |
| `enter_sensor_logic.vhd` | Submodule that determines entry permission |
| `dofile.do`           | ModelSim script to simulate test scenarios   |
| `RoomCounter_tb.vhd`  | (Optional) Testbench to drive simulation     |
| `README.md`           | You're reading it 👋                         |

---

## 🧪 Simulation Instructions (ModelSim)

1. **Compile the design**:

   ```tcl
   vlib work
   vmap work work
   vcom enter_sensor_logic.vhd
   vcom project.vhd
