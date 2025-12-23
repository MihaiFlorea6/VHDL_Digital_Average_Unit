# VHDL Digital Averaging Unit 

# Technical Description 
VHDL implementation of a configurable Digital Moving Average Filter designed for FPGA synthesis.
This project developed a compact, two-component hardware system to efficiently calculate the arithmetic mean of a stream of 8-bit input data. 
The system is modular, consisting of a Data Generator (Control Unit) and an Average Filter (Execution Unit).
The system's core function is to implement a configurable filter, allowing the user to select the averaging buffer length for the last 2, 4, 8, or 16 samples via a 3-bit control input (Length).

# Skills
This project demonstrates practical skills in:
-> Digital Filtering: Implementation of the Moving Average algorithm directly in hardware4.
-> Custom Control Logic: Design of a dedicated Data Generator that produces input sequences in various operational modes (e.g., Test Mode, Random/Pseudo-Random Sequences) using a 3-bit Control input.
-> Hardware Description: Utilization of fundamental building blocks (e.g., 8-bit Sumator, LFSR, Counter) in VHDL for efficient RTL design.

# Key Technologies
VHDL, Digital Design, Hardware Synthesis, Moving Average Filter, LFSR.
