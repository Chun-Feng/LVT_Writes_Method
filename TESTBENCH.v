`include "PATTERN.v"
`include "ram_2R2W.v"

module TESTBENCH();
initial begin

//          $fsdbDumpfile("core.fsdb");
//          $fsdbDumpvars;

	    $dumpfile("core.vcd");
	    $dumpvars;
    end

parameter BLOCKSIZE = 10;

wire        clk;
wire        rst;
wire        en_w1, en_w2;
wire [BLOCKSIZE:0] r1_addr, r2_addr, w1_addr, w2_addr;
wire [31:0] w1, w2, d1, d2;

PATTERN u_pattern(
    .clk(clk),
    .rst(rst),
    .w1_addr(w1_addr), .w1_din(w1), .en_w1(en_w1),
    .w2_addr(w2_addr), .w2_din(w2), .en_w2(en_w2),
    .r1_addr(r1_addr), .d1(d1),
    .r2_addr(r2_addr), .d2(d2)
    );

ram_2R2W ram(
    .clk(clk), .rst(rst),
    .w_addr_1(w1_addr), .w_din_1(w1), .w_enb_1(en_w1),
    .w_addr_2(w2_addr), .w_din_2(w2), .w_enb_2(en_w2),
    .r_addr_1(r1_addr), .r_dout_1(d1),
    .r_addr_2(r2_addr), .r_dout_2(d2)
    );

endmodule

