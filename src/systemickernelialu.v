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
            8'b00111111: r = ~(a | b);
            8'b01111111: r = a << b[4:0];
            8'b00000101: r = a >> b[4:0];                  // SRL
            8'b10000000: r = $signed(a) >>> b[4:0];       // SRA (Benzersiz opcode)
            8'b10000001: r = {31'b0, ($signed(a) < $signed(b))}; // SLT (Benzersiz opcode)
            8'b10000010: r = {31'b0, (a < b)};            // SLTU (Parantez ve yazım hatası düzeltildi)
            default:     r = 32'b0;
        endcase
    end
endmodule
