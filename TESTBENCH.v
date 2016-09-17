`include "PATTERN.v"
`include "ram_8R8W.v"

module TESTBENCH();
initial begin

//          $fsdbDumpfile("core.fsdb");
//          $fsdbDumpvars;
///////// memory design gtkwave tools ////
//	    $dumpfile("core.vcd");
//	    $dumpvars;
    end

parameter BLOCKSIZE = 10;

wire        clk;
wire        rst;
wire        en_w1, en_w2;
wire        en_w3, en_w4;
wire        en_w5, en_w6;
wire        en_w7, en_w8;

wire [BLOCKSIZE:0] r1_addr, r2_addr, w1_addr, w2_addr;
wire [BLOCKSIZE:0] r3_addr, r4_addr, w3_addr, w4_addr;
wire [BLOCKSIZE:0] r5_addr, r6_addr, w5_addr, w6_addr;
wire [BLOCKSIZE:0] r7_addr, r8_addr, w7_addr, w7_addr;

wire [31:0] w1, w2, d1, d2;
wire [31:0] w3, w4, d3, d4;
wire [31:0] w5, w6, d5, d6;
wire [31:0] w7, w8, d7, d8;

PATTERN u_pattern(
    .clk(clk),
    .rst(rst),
    .w1_addr(w1_addr), .w1_din(w1), .en_w1(en_w1),
    .w2_addr(w2_addr), .w2_din(w2), .en_w2(en_w2),
    .w3_addr(w3_addr), .w3_din(w3), .en_w3(en_w3),
    .w4_addr(w4_addr), .w4_din(w4), .en_w4(en_w4),
    .w5_addr(w5_addr), .w5_din(w5), .en_w5(en_w5),
    .w6_addr(w6_addr), .w6_din(w6), .en_w6(en_w6),
    .w7_addr(w7_addr), .w7_din(w7), .en_w7(en_w7),
    .w7_addr(w8_addr), .w8_din(w8), .en_w8(en_w8),
    .r1_addr(r1_addr), .d1(d1),
    .r2_addr(r2_addr), .d2(d2),
    .r3_addr(r3_addr), .d3(d3),
    .r4_addr(r4_addr), .d4(d4),
    .r5_addr(r5_addr), .d5(d5),
    .r6_addr(r6_addr), .d6(d6),
    .r7_addr(r7_addr), .d7(d7),
    .r8_addr(r8_addr), .d8(d8)
    );

ram_8R8W ram(
    .clk(clk), .rst(rst),
    .w_addr_1(w1_addr), .w_din_1(w1), .w_enb_1(en_w1),
    .w_addr_2(w2_addr), .w_din_2(w2), .w_enb_2(en_w2),
    .w_addr_3(w3_addr), .w_din_3(w3), .w_enb_3(en_w3),
    .w_addr_4(w4_addr), .w_din_4(w4), .w_enb_4(en_w4),
    .w_addr_5(w5_addr), .w_din_5(w5), .w_enb_5(en_w5),
    .w_addr_6(w6_addr), .w_din_6(w6), .w_enb_6(en_w6),
    .w_addr_7(w7_addr), .w_din_7(w7), .w_enb_7(en_w7),
    .w_addr_8(w8_addr), .w_din_8(w8), .w_enb_8(en_w8),
    .r_addr_1(r1_addr), .r_dout_1(d1),
    .r_addr_2(r2_addr), .r_dout_2(d2),
    .r_addr_3(r3_addr), .r_dout_3(d3),
    .r_addr_4(r4_addr), .r_dout_4(d4),
    .r_addr_5(r5_addr), .r_dout_5(d5),
    .r_addr_6(r6_addr), .r_dout_6(d6),
    .r_addr_7(r7_addr), .r_dout_7(d7),
    .r_addr_8(r8_addr), .r_dout_8(d8)
    );

endmodule

