# ⚙️ Basic Synchronous FIFO in Verilog

This repository contains a simple, synthesizable Verilog implementation of a **Synchronous** First-In, First-Out (FIFO) memory buffer. It's designed to be a clear and minimal example, perfect for learning fundamental digital design concepts like data buffering and flow control.

---
## ✅ Key Features

* **Single Clock Operation**: Uses one clock for both read and write operations.
* **Synthesizable Verilog**: Written in a synthesizable subset of Verilog, ready for FPGA or ASIC implementation.
* **Counter-Based Logic**: Uses a simple counter to track occupancy, making the full/empty logic straightforward and robust.
* **Minimalist Design**: Non-parameterized and compact for maximum clarity.
* **Testbench Included**: Comes with a basic testbench to verify functionality.

---
## 🛠️ How It Works

The synchronous FIFO manages data flow using a single clock source. Its operation is based on a few key components:

1.  **Memory (`mem`)**: A register array that serves as the storage buffer for the data.
2.  **Pointers (`wptr`, `rptr`)**: A write pointer and a read pointer track the next available location to write to and the current location to read from, respectively.
3.  **Counter (`count`)**: A simple counter tracks the number of items currently stored in the FIFO. This is the core of the control logic.
    * The `empty` signal is asserted when `count` is 0.
    * The `full` signal is asserted when `count` equals the total depth of the FIFO.

The logic, contained within a single `always @(posedge clk)` block, handles the three primary scenarios for every clock cycle: a write, a read, or a simultaneous read and write.

---
## 🔌 Module Interface

| Port    | Direction | Width | Description                             |
| :------ | :-------- | :---- | :-------------------------------------- |
| `clk`   | Input     | 1     | System Clock                            |
| `rst_n` | Input     | 1     | Active-Low Asynchronous Reset           |
| `winc`  | Input     | 1     | Write Increment / Enable signal         |
| `wdata` | Input     | 8     | 8-bit Data to be written into the FIFO  |
| `rinc`  | Input     | 1     | Read Increment / Enable signal          |
| `rdata` | Output    | 8     | 8-bit Data read from the FIFO           |
| `full`  | Output    | 1     | Flag indicating the FIFO is full        |
| `empty` | Output    | 1     | Flag indicating the FIFO is empty       |

---
## 🚀 Simulation

To test the design, you can use any standard Verilog simulator. The included `tb_sync_fifo.v` file will drive the inputs and verify the outputs.

### Example with Icarus Verilog:

1.  **Compile the source files:**
    ```bash
    iverilog -o sim_output.vvp sync_fifo.v tb_sync_fifo.v
    ```

2.  **Run the compiled simulation:**
    ```bash
    vvp sim_output.vvp
    ```

The terminal will display the output from the testbench, showing the results of the write and read operations.
