# UART Communication System in Verilog

A basic UART (Universal Asynchronous Receiver/Transmitter) communication system designed and simulated using Verilog HDL.

## Overview

This project implements UART serial communication using Verilog HDL. The design consists of a baud-rate generator, UART transmitter, UART receiver, and a top-level module integrating the complete system.

The project was developed to understand RTL design, serial communication, FSM-based control, counters, shift registers, and UART frame structure.

## Features

- UART Transmitter (TX)
- UART Receiver (RX)
- Baud-rate generator
- 8-bit data transmission
- Start and stop bit handling
- Serial-to-parallel conversion
- Parallel-to-serial conversion
- FSM-based control
- Verilog testbench for simulation
- Designed and simulated using Xilinx Vivado

## UART Frame

The project uses an 8N1 UART frame:

```text
Idle | Start | D0 D1 D2 D3 D4 D5 D6 D7 | Stop
  1  |   0   |        8-bit Data        |  1
The UART frame contains:

1 Start bit
8 Data bits
1 Stop bit
No parity bit
Project Structure
UART/
│
├── rtl/
│   ├── baud_rate_gen.v
│   ├── uart_tx.v
│   ├── uart_rx.v
│   └── uart_top.v
│
├── tb/
│   └── uart_tb.v
│
└── README.md
Tools Used-
Verilog HDL
Xilinx Vivado
RTL Simulation
Testbench Verification

Concepts Practiced-
RTL Design
Finite State Machines (FSM)
Counters
Shift Registers
Baud-rate generation
Serial communication
Sequential logic

Testbench development-
Simulation and waveform analysis
Future Improvements
Configurable baud rate
Parity-bit support
Multiple stop-bit configurations
FIFO buffering
FPGA hardware implementation
Self-checking testbench

Author-

Vaibhav Zantye
