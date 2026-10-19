# FPGA Timer in VHDL — Nexys4 DDR

A configurable digital timer implemented in **VHDL** for the **Digilent Nexys4 DDR** FPGA development board. The project supports counting up, setting a countdown duration, starting and stopping the timer, resetting it, and signalling countdown completion through an onboard LED. The remaining or elapsed time is shown on the board's multiplexed seven-segment display.

## Features

- **Count-up and countdown operation** with minute-and-second digits.
- **Adjustable timer:** set minutes and seconds using onboard pushbuttons.
- **Start/stop control** for running and pausing the timer.
- **Reset control** using the minute and second buttons together.
- **Four-digit, seven-segment time display** in `MM:SS` format (without a dedicated colon output).
- **One-second timebase** derived from the board's 100 MHz clock.
- **Button conditioning** and separate control/datapath VHDL modules.
- **Completion indication** on LED15, with an alarm state that automatically clears.

## Hardware and Tools

- Digilent **Nexys4 DDR** board (Xilinx Artix-7 **XC7A100T-CSG324-1**)
- USB cable for programming the board
- **AMD/Xilinx Vivado** (project generated using **Vivado 2024.2**)

## Board Controls

| Function | Board control | FPGA pin |
| --- | --- | --- |
| Increase minutes | **BTNU** (`m`) | M18 |
| Increase seconds | **BTNL** (`s`) | P17 |
| Start / stop | **BTNC** (`start_stop`) | N17 |
| Reset | **BTNU + BTNL together** | M18 + P17 |
| Countdown-complete alarm | **LED15** (`alarm`) | V11 |
| System clock | **100 MHz clock** (`clk`) | E3 |
| Time display | Four digits of the eight-digit seven-segment display | Defined in `Nexys-4-DDR-Master.xdc` |

> The reset is implemented by detecting a simultaneous press of the minute and second inputs; there is no separate reset input in the top-level design.

## How to Use

1. Program the Nexys4 DDR with the design.
2. Use **BTNU** to increase the minute setting or **BTNL** to increase the second setting.
3. Press **BTNC** to start the countdown; press it again to pause or stop it.
4. Resume the countdown with **BTNC**.
5. When the countdown reaches zero, **LED15** turns on to indicate completion. The control logic subsequently clears the alarm and returns to its initial state.
6. Press **BTNU and BTNL simultaneously** to reset the timer.

**Count-up mode:** Pressing start/stop from the initial zero state starts an upward-running timer. Setting the time with the minute/second buttons enters the countdown setup path; start/stop then runs the countdown. The control unit manages these operating modes.

## Project Structure

| File | Purpose |
| --- | --- |
| `high.vhd` | Top-level module connecting the control unit and execution unit |
| `CU.vhd` | Control unit: operating states, button inputs, start/stop, reset, and alarm |
| `EU_v1.vhd` | Execution unit (`EU`): time counters, display, clock handling, and alarm counter |
| `clk1hz.vhd` | Generates the slow timing pulse from the 100 MHz clock |
| `cnt_0_9.vhd` | Up/down decade counter (0–9) |
| `counter_de_la_0_la_5.vhd` | Up/down counter (0–5) for tens of seconds |
| `ssd_display_4_with_included_decoder.vhd` | Multiplexes and drives four seven-segment digits |
| `decodificator.vhd` | Digit-to-seven-segment decoder |
| `ssd.vhd` | Seven-segment display support |
| `dbouncer.vhd` | Button debouncing logic |
| `debouncer_special.vhd` | Button conditioning for start/stop |
| `dff.vhd` | Flip-flop component |
| `Nexys-4-DDR-Master.xdc` | FPGA pin assignments and board constraints |
| `v2_nexys.xpr` | Vivado project file |

### Design Overview

```text
                 +-------------------------+
BTNU / BTNL ---->|                         |
BTNC ----------->|  CU (Control Unit)      |----> Alarm LED15
                 |  State/control logic    |
                 +------------+------------+
                              |
                              | control signals
                              v
100 MHz clock ---> +-------------------------+
                   |  EU (Execution Unit)    |
                   |  Clock divider          |
                   |  Up/down time counters  |
                   |  Display driver         |
                   +------------+------------+
                                |
                                v
                      Seven-segment display
```

The execution unit combines four time digits: two second digits and two minute digits. The control unit selects whether counting is enabled, which direction to count, and when the alarm is active.

## Build and Program

1. Clone or download this repository.
2. Open **Vivado** and load `v2_nexys.xpr`.
3. Ensure the FPGA part is **`xc7a100tcsg324-1`** and the top module is **`high`**.
4. Check that all `.vhd` source files and `Nexys-4-DDR-Master.xdc` are included in the project.
5. Run **Synthesis**, then **Implementation**, and **Generate Bitstream**.
6. Connect and power the Nexys4 DDR board.
7. Open **Hardware Manager**, connect to the target, and **Program Device** with the generated bitstream.

If the included project uses paths from another computer, re-add the VHDL and XDC files to a new Vivado RTL project targeting the same FPGA part, and set `high` as the top module.

## Notes

- The display driver uses four of the board's eight seven-segment digits.
- The timing logic assumes the Nexys4 DDR's onboard **100 MHz** clock.
- The alarm indication is **temporary**, not latched permanently, according to the `CU` and `EU` logic.
- This README describes the provided source files and pin constraints. Hardware timing accuracy and button behavior should be validated on the physical board.

## Repository Tip

For a cleaner GitHub repository, keep the `.vhd`, `.xdc`, and `.xpr` files, and consider excluding Vivado-generated directories such as `.Xil/`, `v2_nexys.cache/`, `v2_nexys.runs/`, `v2_nexys.hw/`, and `v2_nexys.ip_user_files/`. Generated bitstreams can be shared separately if desired.
