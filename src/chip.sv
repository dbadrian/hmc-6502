// chip.sv
// chip module for hmc-6502 CPU
// 5mar08
// tbarr at cs hmc edu
// chip is the top of the heirarchy, interfacing the core with the outside
// world.

`timescale 1 ns / 1 ps
`default_nettype none

module chip(output logic [15:0] address,
            inout wire [7:0] data,
            input logic ph0, resetb,
            output logic read_en, razor_error,
            input logic osc_en,
            output logic osc_out, ph1, ph2);
            
            logic [7:0] data_in, data_out;
            
            // data is a two-way signal, so we have to be sure it drives
            // data_in if it's input and gets driven by data_out if output.
            assign data = (read_en) ? 8'bz : data_out;
            assign data_in = (read_en) ? data : 8'bz;
            
            // Instantiate the core module described in core.sv.
            core core(.address(address), .data_in(data_in), 
                      .data_out(data_out), .ph0(ph0), 
                      .resetb(resetb), .read_en(read_en), 
                      .razor_error(razor_error),
                      .osc_en(osc_en), .osc_out(osc_out),
                      .ph1(ph1), .ph2(ph2));
endmodule
