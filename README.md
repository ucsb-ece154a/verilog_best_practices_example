
# Verilog Best Practices Example

This repository gives an example of how to fix common Verilog design issues. `"adder.v"` has examples of good and bad practices. Note that in simulation with Icarus Verilog, it passes all the tests in `"tb.sv"`. However the design is flawed and does not synthesize with Yosys.

## Good things

* Inputs and outputs have suffixes `_i` and `_o` respectively. (`clk` and `rst` are always assumed to be inputs, so `_i` is not necessary.)
* Parameterized modules allow customization at compile time.
* Separate file for adder definitions so function codes can be used by other modules.
* Flip-flop updates and combinational logic occur in separate procedural blocks.
* The case statement has a default case that, only in simulation, gives a warning on unknown function codes.

## Bad things

* `<=` should only be used in flip-flop logic blocks, `=` should only be used in combinational logic blocks.
* `y_q` is driven in two separate `always` blocks. A net should only be driven by one.
* Arithmetic should only occur between nets of the same bit-width.
* A latch is inferred in the `always @ *` block because `y_d` will not be set on undefined `f_i` values. Latches will result in an error.
* Synthesizable `always` blocks must only either have `@*` or `@(posedge clk)`/`@(negedge clk)`. To create combinational logic, use `always @*`; to update flip-flops, use `always @(posedge clk)`/`always @(negedge clk)`.

## Online Resources

* [DigitalJS Online](https://digitaljs.tilk.eu/) - Online synthesis tool to lint/visualize/test designs
* [Design In EDA Plyground](https://www.edaplayground.com/x/YKVY) - Online tool to run Verilog
* [Verilator Errors/Warnings List](https://verilator.org/guide/latest/warnings.html) - More information on Verilator errors/warnings
