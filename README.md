# Project Synchronous FIFO in Verilog

A simple and efficient **Synchronous FIFO (First-In First-Out)** buffer implemented in Verilog. This design is commonly used in digital systems to safely pass data between modules that share the same clock domain.

## Features

- Parameterized data width and FIFO depth
- Synchronous read and write operations
- Status flags: full, empty
- Internal pointer and memory management
- Testbench included

## How It Works

Data is written on wr_en and read on rd_en, both synchronous to clk.
Internally uses two 5-bit pointers (wr_ptr, rd_ptr) to manage circular buffer.
full is asserted when buffer is completely filled.
empty is asserted when there is no data to read.

## Simulation
EDA Playground
- online
Icarus Verilog 
- iverilog -o sim.vvp Sync_FIFO.v Sync_FIFO_tb.v
- vvp sim.vvp
- gtkwave waveform.vcd

## Waveform
![image](https://github.com/user-attachments/assets/b191c382-40d1-427a-8804-0d61eeee7118)

## Learning Outcomes
- Understood how a FIFO works using pointers and memory.
- Gained hands-on experience with Verilog coding.
- Learned to simulate and test hardware designs.
- Implemented full and empty logic safely.

