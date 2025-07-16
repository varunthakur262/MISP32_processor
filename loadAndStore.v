module test_mips32;
  reg c1, c2;
  integer i;

  pipe_MIPS32 m(c1, c2);

  initial begin
    c1 = 0; c2 = 0;
    repeat (50) begin
      #5 c1 = 1; #5 c1 = 0;
      #5 c2 = 1; #5 c2 = 0;
    end
  end

  initial begin
    for (i = 0; i < 32; i = i + 1)
      m.Reg[i] = 0;

    m.Mem[0] = 32'h28010078;
    m.Mem[1] = 32'h8c632000;
    m.Mem[2] = 32'h0c220000;
    m.Mem[3] = 32'h0c220000;
    m.Mem[4] = 32'h2842002d;
    m.Mem[5] = 32'h0c631800;
    m.Mem[6] = 32'hac220001;
    m.Mem[7] = 32'hfc000000;

    m.Mem[120] = 85;
  end

  initial begin
    m.PC = 0;
    m.HALTED = 0;
    m.TAKEN_BRANCH = 0;

    #500
    $display("Mem[120]: %d", m.Mem[120]);
    $display("Mem[121]: %d", m.Mem[121]);

    $finish;
  end

  initial begin
    $dumpfile("mips.vcd");
    $dumpvars(0, test_mips32);
  end
endmodule
