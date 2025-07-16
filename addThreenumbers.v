module test_mips32;
  reg c1, c2;
  integer i;

  pipe_MIPS32 m(c1, c2);

  initial begin
    c1 = 0; c2 = 0;
    repeat (20) begin
      #5 c1 = 1; #5 c1 = 0;
      #5 c2 = 1; #5 c2 = 0;
    end
  end

  initial begin
    for (i = 0; i < 32; i = i + 1)
      m.Reg[i] = 0;

    m.Mem[0] = 32'h2801000a;
    m.Mem[1] = 32'h28020014;
    m.Mem[2] = 32'h28030019;
    m.Mem[3] = 32'h0ce77800;
    m.Mem[4] = 32'h00222000;
    m.Mem[5] = 32'h0ce77800;
    m.Mem[6] = 32'h00832800;
    m.Mem[7] = 32'hfc000000;
  end

  initial begin
    m.HALTED = 0;
    m.PC = 0;
    m.TAKEN_BRANCH = 0;

    #280
    for (i = 0; i < 6; i = i + 1)
      $display("R[%d] = %d", i, m.Reg[i]);

    $finish;
  end

  initial begin
    $dumpfile("mips.vcd");
    $dumpvars(0, test_mips32);
  end
endmodule
