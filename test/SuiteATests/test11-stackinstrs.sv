// test11-stackinstrs.sv
// basic regression test
// tbarr at cs dot hmc dot edu

`timescale 1 ns / 1 ps

module optest;
  reg ph1, ph2, resetb;
  
  wire [7:0] data;
  
  top top(ph1, ph2, resetb);
  
  always begin
    ph1 <= 1; #8; ph1 <= 0; #12;
  end
  always begin
    ph2 <= 0; #10; ph2 <= 1; #8; ph2 <= 0; #2;
  end
  
  initial begin
    // for VCD file
    $dumpfile("test/VCD/outSuiteA-test00.vcd");
    $dumpvars;

    // init ROM
    top.mem.ROM[4093] = 8'hf0;
    top.mem.ROM[4092] = 8'h00;
    
    // path relative to this file.
    $readmemh("test/roms/SuiteA/test11-stackinstrs.rom", top.mem.ROM);
    
    // start test
    resetb = 0;
    #100;
    resetb = 1;
    #1200;
    assert (top.mem.RAM[48] == 8'h29) $display ("PASSED Test 11 - stack instructions");
      else $error("FAILED Test 11 - stack instructions");
    $dumpflush;
    $stop;
  end
endmodule
