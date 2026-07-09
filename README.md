# MOD-12 Counter Verification Using SystemVerilog Testbench

## Overview

This project verifies the functionality of a MOD-12 counter using a SystemVerilog testbench. The testbench applies clock and reset signals, monitors the counter output, and verifies that the counter correctly counts from 0 to 11 before wrapping back to 0.


## Design Specification

* Counter Type: MOD-12 Counter
* Counter Range: 0 to 11
* Clock: Positive-edge triggered
* Reset: Active-high synchronous/asynchronous (based on RTL implementation)

## Testbench Features

* Clock generation
* Reset generation
* DUT instantiation
* Stimulus generation
* Output monitoring using `$monitor`
* Automatic simulation termination using `$finish`

## Inputs

| Signal | Description  |
| ------ | ------------ |
| clk    | Clock signal |
| rst    | Reset signal |

## Outputs

| Signal     | Description    |
| ---------- | -------------- |
| count[3:0] | Counter output |

## Verification Flow

1. Generate a periodic clock.
2. Apply reset to initialize the counter.
3. Release reset.
4. Allow the counter to increment on each positive clock edge.
5. Observe the count sequence from 0 to 11.
6. Verify that the counter wraps back to 0 after reaching 11.
7. End the simulation.

## Expected Counter Sequence


0 → 1 → 2 → 3 → 4 → 5 → 6 → 7 → 8 → 9 → 10 → 11 → 0 → ...


## Expected Result

* Reset initializes the counter to 0.
* Counter increments on every rising edge of the clock.
* After reaching decimal 11, the next clock cycle resets the counter to 0.
* Waveforms confirm correct MOD-12 operation.

## Future Enhancements

* Add self-checking testbench.
* Implement assertions (SVA).
* Add functional coverage.
* Randomize reset timing.
* Integrate into a UVM verification environment.

## Author

Gurram Naga Kushwanth
