
module adder #(
  parameter WIDTH = 4
) (
  input                   clk, rst,
  input             [1:0] f_i,
  input       [WIDTH-1:0] a_i, b_i,
  output reg  [WIDTH-1:0] y_o
);

`include "define.vh"

reg [WIDTH-1:0] y_d, y_q;

always @(f_i or a_i or b_i) begin
  case (f_i)
    adder_unsigned:     y_d = a_i + b_i;
    adder_1sComplement: y_d = a_i + b_i + a_i[WIDTH-1] + b_i[WIDTH-1];
    adder_2sComplement: y_d <= a_i + b_i;
    default: $display("Warning: Unknown adder function: %h", f_i);
  endcase
end

assign y_o = y_q;

always @(posedge clk) begin
  if (rst)
    y_q <= 0;
end
always @(posedge clk) begin
  if (!rst)
    y_q = y_d;
end

endmodule
