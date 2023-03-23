
`define ASSERT(CONDITION, MESSAGE) if ((CONDITION)==1'b1); else begin $display(MESSAGE); ERROR = 1; end

module tb ();

reg clk = 1;
always #1 clk = ~clk;
reg rst;

reg [1:0] f;
reg [3:0] a, b;
wire [3:0] y;

adder adder0 (
  .clk(clk), .rst(rst),
  .f_i(f),
  .a_i(a), .b_i(b),
  .y_o(y)
);

`include "define.vh"

reg ERROR = 0;
initial begin
$dumpfile("dump.vcd"); $dumpvars;
//\\ =========================== \\//

rst = 0;
a = 4'b1111;
b = 4'b0001;
@(negedge clk);

f = adder_unsigned;
@(negedge clk);
`ASSERT(y==4'b0000,"adder_unsigned wrong");

f = adder_1sComplement;
@(negedge clk);
`ASSERT(y==4'b0001,"adder_1sComplement wrong");

f = adder_2sComplement;
@(negedge clk);
`ASSERT(y==4'b0000,"adder_2sComplement");

//\\ =========================== \\//
else $display("Passed!");
$finish();
end

endmodule


`undef ASSERT
