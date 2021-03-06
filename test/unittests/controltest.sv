// controltest.sv
// tests development memory system
// tbarr at cs dot hmc dot edu

`timescale 1 ns / 1 ps

module controltest;
  logic ph1, ph2, reset;
  logic [7:0] data_in, p;
  logic [36:0] controls;
  
  control control(data_in, p, ph1, ph2, reset, controls);
  
  always begin
    ph1 <= 1; #8; ph1 <= 0; #12;
  end
  always begin
    ph2 <= 0; #10; ph2 <= 1; #8; ph2 <= 0; #2;
  end
  
  initial begin
    // start test
    data_in = 8'h1;
    reset = 1;
    #100;
    reset = 0;
    #1;
    control.state_flop.q = 8'd1;
  end
endmodule
