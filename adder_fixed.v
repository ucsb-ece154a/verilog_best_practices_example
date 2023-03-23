
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

always @* begin
  y_d = {WIDTH{1'bx}};
  case (f_i)
    adder_unsigned:     y_d = a_i + b_i;
    adder_1sComplement: y_d = a_i + b_i + {{(WIDTH-1){1'b0}}, a_i[WIDTH-1]} + {{(WIDTH-1){1'b0}}, b_i[WIDTH-1]};
    adder_2sComplement: y_d = a_i + b_i;
    default: $display("Warning: Unknown adder function: %h", f_i);
  endcase
end

assign y_o = y_q;

always @(posedge clk) begin
  if (rst)
    y_q <= 0;
  else
    y_q <= y_d;
end

endmodule
