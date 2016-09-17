module ram_4R1W(
    clk, rst,
    w_addr_1, w_din_1, w_enb,
    r_addr_1, r_dout_1,
    r_addr_2, r_dout_2,
    r_addr_3, r_dout_3,
    r_addr_4, r_dout_4
    );

parameter BLOCLSIZE = 11;

input clk;
input rst;
input [BLOCLSIZE : 0] w_addr_1;
input [31 : 0] w_din_1;
input w_enb;

input [BLOCLSIZE : 0] r_addr_1, r_addr_2;
input [BLOCLSIZE : 0] r_addr_3, r_addr_4;
output [31:0] r_dout_1, r_dout_2;
output [31:0] r_dout_3, r_dout_4;
//////////////////////////////

ram_1R1W block1(
    .clk(clk), .rst(rst),
    .w_addr(w_addr_1), .w_din(w_din_1), .w_enb(w_enb),
    .r_addr(r_addr_1), .r_dout(r_dout_1)
    );

ram_1R1W block2(
    .clk(clk), .rst(rst),
    .w_addr(w_addr_1), .w_din(w_din_1), .w_enb(w_enb),
    .r_addr(r_addr_2), .r_dout(r_dout_2)
    );

ram_1R1W block3(
    .clk(clk), .rst(rst),
    .w_addr(w_addr_1), .w_din(w_din_1), .w_enb(w_enb),
    .r_addr(r_addr_3), .r_dout(r_dout_3)
    );

ram_1R1W block4(
    .clk(clk), .rst(rst),
    .w_addr(w_addr_1), .w_din(w_din_1), .w_enb(w_enb),
    .r_addr(r_addr_4), .r_dout(r_dout_4)
    );

endmodule

