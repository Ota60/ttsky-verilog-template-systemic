module systemickernel_i_alu (
    input [31:0] a,
    input [31:0] b,
    input [7:0]  opcode,
    output reg [31:0] r
);
    always @* begin
        r = 32'b0;
        case (opcode) 
            8'b00000000: r = 32'b0;
            8'b00000001: r = a + b;
            8'b00000011: r = a - b;
            8'b00000111: r = a & b;
            8'b00001111: r = a | b;
            8'b00011111: r = a ^ b;
            8'b00111111: r = ~(a | b); // Örnek mantıksal işlem
            8'b01111111: r = a << b[4:0];
            8'b00000101: r = a >> b[4:0];                  // SRL için net opcode
            8'b011111111: r = $signed(a) >>> b[4:0];       // SRA
            8'b001111111: r = {31'b0, ($signed(a) < $signed(b))}; // 1 biti 32 bite genişlettik (SLT)
            8'b000111111: r = {31'b0, (a < b);            // 1 biti 32 bite genişlettik (SLTU)
            default:     r = 32'b0;
        endcase
    end
endmodule
