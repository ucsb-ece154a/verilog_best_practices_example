
module adder #(
  parameter WIDTH = 4
) (
  input                   clk, rst,
  input             [1:0] f_i,
  input       [WIDTH-1:0] a_i, b_i,
  output reg  [WIDTH-1:0] y_o
);

`include "define.vh"

reg [WIDTH-1:0] y_next;

always @(f_i or a_i or b_i) begin
  case (f_i)
    adder_unsigned:     y_next = a_i + b_i;
    adder_1sComplement: y_next = a_i + b_i + a_i[WIDTH-1] + b_i[WIDTH-1];
    adder_2sComplement: y_next <= a_i + b_i;
    default:
      `ifdef SIM
      $warning("Unknown adder function: %h", f_i);
      `else
      ;
      `endif
  endcase
end

always @ (posedge clk) begin
  if (rst)
    y_o <= 0;
end
always @ (posedge clk) begin
  if (!rst)
    y_o = y_next;
end

endmodule
