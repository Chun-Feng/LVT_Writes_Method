module ram_8R2W(
        clk,rst,
        w_addr_1, w_din_1, w_enb_1,
        w_addr_2, w_din_2, w_enb_2,
        r_addr_1, r_dout_1,
        r_addr_2, r_dout_2,
        r_addr_3, r_dout_3,
        r_addr_4, r_dout_4,
        r_addr_5, r_dout_5,
        r_addr_6, r_dout_6,
        r_addr_7, r_dout_7,
        r_addr_8, r_dout_8
        );

parameter BLOCKSIZE = 12;  //general parameter - memory depth
parameter BLOCKNUM = 0;  //2^(BLOCKNUM) = multiple writes

/////////INPUT-OUTPUT parts/////////
input clk;
input rst;

input [BLOCKSIZE:0] w_addr_1, w_addr_2;
input [31:0] w_din_1, w_din_2;

input w_enb_1, w_enb_2;

input [BLOCKSIZE:0] r_addr_1, r_addr_2;
input [BLOCKSIZE:0] r_addr_3, r_addr_4;
input [BLOCKSIZE:0] r_addr_5, r_addr_6;
input [BLOCKSIZE:0] r_addr_7, r_addr_8;

output reg [31:0] r_dout_1, r_dout_2;
output reg [31:0] r_dout_3, r_dout_4;
output reg [31:0] r_dout_5, r_dout_6;
output reg [31:0] r_dout_7, r_dout_8;

/////// LVT-based register ///////
reg [BLOCKNUM:0] lvt_table [0:(2 << BLOCKSIZE) - 1];
reg [BLOCKNUM:0] lvt_r1_choose, lvt_r2_choose;
reg [BLOCKNUM:0] lvt_r3_choose, lvt_r4_choose;
reg [BLOCKNUM:0] lvt_r5_choose, lvt_r6_choose;
reg [BLOCKNUM:0] lvt_r7_choose, lvt_r8_choose;

//////BLOCK INOUT///////
reg b1_enb, b2_enb;
reg [BLOCKSIZE:0] b1_addrw, b2_addrw;
reg [31:0] b1_dinw, b2_dinw;

reg [BLOCKSIZE:0] b1_addr1, b1_addr2, b2_addr1, b2_addr2;
reg [BLOCKSIZE:0] b1_addr3, b1_addr4, b2_addr3, b2_addr4;
reg [BLOCKSIZE:0] b1_addr5, b1_addr6, b2_addr5, b2_addr6;
reg [BLOCKSIZE:0] b1_addr7, b1_addr8, b2_addr7, b2_addr8;

wire [31:0] b1_dout1, b1_dout2, b2_dout1, b2_dout2;
wire [31:0] b1_dout3, b1_dout4, b2_dout3, b2_dout4;
wire [31:0] b1_dout5, b1_dout6, b2_dout5, b2_dout6;
wire [31:0] b1_dout7, b1_dout8, b2_dout7, b2_dout8;

/////////BLOCKS/////////
ram_8R1W block1(
	.clk(clk), .rst(rst),
	.w_addr_1(w_addr_1), .w_din_1(b1_dinw), .w_enb(b1_enb),
	.r_addr_1(b1_addr1), .r_dout_1(b1_dout1),
	.r_addr_2(b1_addr2), .r_dout_2(b1_dout2),
	.r_addr_3(b1_addr3), .r_dout_3(b1_dout3),
	.r_addr_4(b1_addr4), .r_dout_4(b1_dout4),
	.r_addr_5(b1_addr5), .r_dout_5(b1_dout5),
	.r_addr_6(b1_addr6), .r_dout_6(b1_dout6),
	.r_addr_7(b1_addr7), .r_dout_7(b1_dout7),
	.r_addr_8(b1_addr8), .r_dout_8(b1_dout8)
        );

ram_8R1W block2(
	.clk(clk), .rst(rst),
	.w_addr_1(w_addr_2), .w_din_1(b2_dinw), .w_enb(b2_enb),
	.r_addr_1(b2_addr1), .r_dout_1(b2_dout1),
	.r_addr_2(b2_addr2), .r_dout_2(b2_dout2),
	.r_addr_3(b2_addr3), .r_dout_3(b2_dout3),
	.r_addr_4(b2_addr4), .r_dout_4(b2_dout4),
	.r_addr_5(b2_addr5), .r_dout_5(b2_dout5),
	.r_addr_6(b2_addr6), .r_dout_6(b2_dout6),
	.r_addr_7(b2_addr7), .r_dout_7(b2_dout7),
	.r_addr_8(b2_addr8), .r_dout_8(b2_dout8)
        );

always@(*)
    begin
	////READS PARTS////
	b1_addr1 = r_addr_1;
	b2_addr1 = r_addr_1;

        b1_addr2 = r_addr_2;
	b2_addr2 = r_addr_2;

        b1_addr3 = r_addr_3;
	b2_addr3 = r_addr_3;
	
        b1_addr4 = r_addr_4;
	b2_addr4 = r_addr_4;
	
        b1_addr5 = r_addr_5;
	b2_addr5 = r_addr_5;
	
        b1_addr6 = r_addr_6;
	b2_addr6 = r_addr_6;
	
        b1_addr7 = r_addr_7;
	b2_addr7 = r_addr_7;
	
        b1_addr8 = r_addr_8;
	b2_addr8 = r_addr_8;
	
        ///////LVT output choice - multiplexors//////
        r_dout_1 = (lvt_r1_choose == 0)? b1_dout1 : b2_dout1;
	r_dout_2 = (lvt_r2_choose == 0)? b1_dout2 : b2_dout2;
	r_dout_3 = (lvt_r3_choose == 0)? b1_dout3 : b2_dout3;
	r_dout_4 = (lvt_r4_choose == 0)? b1_dout4 : b2_dout4;
	r_dout_5 = (lvt_r5_choose == 0)? b1_dout5 : b2_dout5;
	r_dout_6 = (lvt_r6_choose == 0)? b1_dout6 : b2_dout6;
	r_dout_7 = (lvt_r7_choose == 0)? b1_dout7 : b2_dout7;
	r_dout_8 = (lvt_r8_choose == 0)? b1_dout8 : b2_dout8;
	
        ////Write////
	b1_addrw = w_addr_1;
	b2_addrw = w_addr_2;
	
        b1_enb = w_enb_1;
	b2_enb = w_enb_2;
	b1_dinw = w_din_1;
	b2_dinw = w_din_2;
    end

always@(negedge clk)
    begin
	////READ-OUTPUT parts////
	lvt_r1_choose <= lvt_table[r_addr_1];
	lvt_r2_choose <= lvt_table[r_addr_2];
	lvt_r3_choose <= lvt_table[r_addr_3];
	lvt_r4_choose <= lvt_table[r_addr_4];
	lvt_r5_choose <= lvt_table[r_addr_5];
	lvt_r6_choose <= lvt_table[r_addr_6];
	lvt_r7_choose <= lvt_table[r_addr_7];
	lvt_r8_choose <= lvt_table[r_addr_8];

	////Write////
	if(w_enb_1 == 1)    begin
		lvt_table[w_addr_1] = 0;
	    end
	if(w_enb_2 == 1)    begin
		lvt_table[w_addr_2] = 1;
	    end
end

always@(posedge clk or negedge rst)
    begin
	if(!rst)
	    begin
	    end
	else
	    begin
	    end
end

endmodule

