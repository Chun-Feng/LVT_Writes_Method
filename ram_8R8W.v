module ram_8R8W(
        clk,rst,
        w_addr_1, w_din_1, w_enb_1,
        w_addr_2, w_din_2, w_enb_2,
        w_addr_3, w_din_3, w_enb_3,
        w_addr_4, w_din_4, w_enb_4,
        w_addr_5, w_din_5, w_enb_5,
        w_addr_6, w_din_6, w_enb_6,
        w_addr_7, w_din_7, w_enb_7,
        w_addr_8, w_din_8, w_enb_8,
        r_addr_1, r_dout_1,
        r_addr_2, r_dout_2,
        r_addr_3, r_dout_3,
        r_addr_4, r_dout_4,
        r_addr_5, r_dout_5,
        r_addr_6, r_dout_6,
        r_addr_7, r_dout_7,
        r_addr_8, r_dout_8
        );

parameter BLOCKSIZE = 11;
parameter BLOCKNUM = 2;

/////////INOUT/////////
input clk;
input rst;

input [BLOCKSIZE:0] w_addr_1, w_addr_2;
input [BLOCKSIZE:0] w_addr_3, w_addr_4;
input [BLOCKSIZE:0] w_addr_5, w_addr_6;
input [BLOCKSIZE:0] w_addr_7, w_addr_8;

input [31:0] w_din_1,w_din_2;
input [31:0] w_din_3,w_din_4;
input [31:0] w_din_5,w_din_6;
input [31:0] w_din_7,w_din_8;

input w_enb_1, w_enb_2;
input w_enb_3, w_enb_4;
input w_enb_5, w_enb_6;
input w_enb_7, w_enb_8;

input [BLOCKSIZE:0] r_addr_1, r_addr_2;
input [BLOCKSIZE:0] r_addr_3, r_addr_4;
input [BLOCKSIZE:0] r_addr_5, r_addr_6;
input [BLOCKSIZE:0] r_addr_7, r_addr_8;

output reg [31:0] r_dout_1, r_dout_2;
output reg [31:0] r_dout_3, r_dout_4;
output reg [31:0] r_dout_5, r_dout_6;
output reg [31:0] r_dout_7, r_dout_8;
//////////////////////////////////
///// LVT register parameter ////
reg [BLOCKNUM:0] lvt_table [0:( 2 << BLOCKSIZE) - 1];
reg [BLOCKNUM:0] lvt_r1_choose, lvt_r2_choose;
reg [BLOCKNUM:0] lvt_r3_choose, lvt_r4_choose;
reg [BLOCKNUM:0] lvt_r5_choose, lvt_r6_choose;
reg [BLOCKNUM:0] lvt_r7_choose, lvt_r8_choose;
//////BLOCK INOUT///////
reg b1_enb, b2_enb;
reg b3_enb, b4_enb;
reg b5_enb, b6_enb;
reg b7_enb, b8_enb;

reg [BLOCKSIZE:0] b1_addrw, b2_addrw;
reg [BLOCKSIZE:0] b3_addrw, b4_addrw;
reg [BLOCKSIZE:0] b5_addrw, b6_addrw;
reg [BLOCKSIZE:0] b7_addrw, b8_addrw;

reg [31:0] b1_dinw, b2_dinw;
reg [31:0] b3_dinw, b4_dinw;
reg [31:0] b5_dinw, b6_dinw;
reg [31:0] b7_dinw, b8_dinw;

reg [BLOCKSIZE:0] b1_addr1, b1_addr2, b2_addr1, b2_addr2;
reg [BLOCKSIZE:0] b1_addr3, b1_addr4, b2_addr3, b2_addr4;
reg [BLOCKSIZE:0] b1_addr5, b1_addr6, b2_addr5, b2_addr6;
reg [BLOCKSIZE:0] b1_addr7, b1_addr8, b2_addr7, b2_addr8;

reg [BLOCKSIZE:0] b3_addr1, b3_addr2, b4_addr1, b4_addr2;
reg [BLOCKSIZE:0] b3_addr3, b3_addr4, b4_addr3, b4_addr4;
reg [BLOCKSIZE:0] b3_addr5, b3_addr6, b4_addr5, b4_addr6;
reg [BLOCKSIZE:0] b3_addr7, b3_addr8, b4_addr7, b4_addr8;

reg [BLOCKSIZE:0] b5_addr1, b5_addr2, b6_addr1, b6_addr2;
reg [BLOCKSIZE:0] b5_addr3, b5_addr4, b6_addr3, b6_addr4;
reg [BLOCKSIZE:0] b5_addr5, b5_addr6, b6_addr5, b6_addr6;
reg [BLOCKSIZE:0] b5_addr7, b5_addr8, b6_addr7, b6_addr8;

reg [BLOCKSIZE:0] b7_addr1, b7_addr2, b8_addr1, b8_addr2;
reg [BLOCKSIZE:0] b7_addr3, b7_addr4, b8_addr3, b8_addr4;
reg [BLOCKSIZE:0] b7_addr5, b7_addr6, b8_addr5, b8_addr6;
reg [BLOCKSIZE:0] b7_addr7, b7_addr8, b8_addr7, b8_addr8;

wire [31:0] b1_dout1, b1_dout2, b2_dout1, b2_dout2;
wire [31:0] b1_dout3, b1_dout4, b2_dout3, b2_dout4;
wire [31:0] b1_dout5, b1_dout6, b2_dout5, b2_dout6;
wire [31:0] b1_dout7, b1_dout8, b2_dout7, b2_dout8;

wire [31:0] b3_dout1, b3_dout2, b4_dout1, b4_dout2;
wire [31:0] b3_dout3, b3_dout4, b4_dout3, b4_dout4;
wire [31:0] b3_dout5, b3_dout6, b4_dout5, b4_dout6;
wire [31:0] b3_dout7, b3_dout8, b4_dout7, b4_dout8;

wire [31:0] b5_dout1, b5_dout2, b6_dout1, b6_dout2;
wire [31:0] b5_dout3, b5_dout4, b6_dout3, b6_dout4;
wire [31:0] b5_dout5, b5_dout6, b6_dout5, b6_dout6;
wire [31:0] b5_dout7, b5_dout8, b6_dout7, b6_dout8;

wire [31:0] b7_dout1, b7_dout2, b8_dout1, b8_dout2;
wire [31:0] b7_dout3, b7_dout4, b8_dout3, b8_dout4;
wire [31:0] b7_dout5, b7_dout6, b8_dout5, b8_dout6;
wire [31:0] b7_dout7, b7_dout8, b8_dout7, b8_dout8;
/////////BLOCKS/////////
ram_8R1W block1(
	.clk(clk), .rst(rst),
	.w_addr_1(b1_addrw), .w_din_1(b1_dinw), .w_enb(b1_enb),
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
	.w_addr_1(b2_addrw), .w_din_1(b2_dinw), .w_enb(b2_enb),
	.r_addr_1(b2_addr1), .r_dout_1(b2_dout1),
	.r_addr_2(b2_addr2), .r_dout_2(b2_dout2),
	.r_addr_3(b2_addr3), .r_dout_3(b2_dout3),
	.r_addr_4(b2_addr4), .r_dout_4(b2_dout4),
	.r_addr_5(b2_addr5), .r_dout_5(b2_dout5),
	.r_addr_6(b2_addr6), .r_dout_6(b2_dout6),
	.r_addr_7(b2_addr7), .r_dout_7(b2_dout7),
	.r_addr_8(b2_addr8), .r_dout_8(b2_dout8)
        );

ram_8R1W block3(
	.clk(clk), .rst(rst),
	.w_addr_1(b3_addrw), .w_din_1(b3_dinw), .w_enb(b3_enb),
	.r_addr_1(b3_addr1), .r_dout_1(b3_dout1),
	.r_addr_2(b3_addr2), .r_dout_2(b3_dout2),
	.r_addr_3(b3_addr3), .r_dout_3(b3_dout3),
	.r_addr_4(b3_addr4), .r_dout_4(b3_dout4),
	.r_addr_5(b3_addr5), .r_dout_5(b3_dout5),
	.r_addr_6(b3_addr6), .r_dout_6(b3_dout6),
	.r_addr_7(b3_addr7), .r_dout_7(b3_dout7),
	.r_addr_8(b3_addr8), .r_dout_8(b3_dout8)
    );

ram_8R1W block4(
	.clk(clk), .rst(rst),
	.w_addr_1(b4_addrw), .w_din_1(b4_dinw), .w_enb(b4_enb),
	.r_addr_1(b4_addr1), .r_dout_1(b4_dout1),
	.r_addr_2(b4_addr2), .r_dout_2(b4_dout2),
	.r_addr_3(b4_addr3), .r_dout_3(b4_dout3),
	.r_addr_4(b4_addr4), .r_dout_4(b4_dout4),
	.r_addr_5(b4_addr5), .r_dout_5(b4_dout5),
	.r_addr_6(b4_addr6), .r_dout_6(b4_dout6),
	.r_addr_7(b4_addr7), .r_dout_7(b4_dout7),
	.r_addr_8(b4_addr8), .r_dout_8(b4_dout8)
        );

ram_8R1W block5(
	.clk(clk), .rst(rst),
	.w_addr_1(b5_addrw), .w_din_1(b5_dinw), .w_enb(b5_enb),
	.r_addr_1(b5_addr1), .r_dout_1(b5_dout1),
	.r_addr_2(b5_addr2), .r_dout_2(b5_dout2),
	.r_addr_3(b5_addr3), .r_dout_3(b5_dout3),
	.r_addr_4(b5_addr4), .r_dout_4(b5_dout4),
	.r_addr_5(b5_addr5), .r_dout_5(b5_dout5),
	.r_addr_6(b5_addr6), .r_dout_6(b5_dout6),
	.r_addr_7(b5_addr7), .r_dout_7(b5_dout7),
	.r_addr_8(b5_addr8), .r_dout_8(b5_dout8)
        );

ram_8R1W block6(
	.clk(clk), .rst(rst),
	.w_addr_1(b6_addrw), .w_din_1(b6_dinw), .w_enb(b6_enb),
	.r_addr_1(b6_addr1), .r_dout_1(b6_dout1),
	.r_addr_2(b6_addr2), .r_dout_2(b6_dout2),
	.r_addr_3(b6_addr3), .r_dout_3(b6_dout3),
	.r_addr_4(b6_addr4), .r_dout_4(b6_dout4),
	.r_addr_5(b6_addr5), .r_dout_5(b6_dout5),
	.r_addr_6(b6_addr6), .r_dout_6(b6_dout6),
	.r_addr_7(b6_addr7), .r_dout_7(b6_dout7),
	.r_addr_8(b6_addr8), .r_dout_8(b6_dout8)
        );

ram_8R1W block7(
	.clk(clk), .rst(rst),
	.w_addr_1(b7_addrw), .w_din_1(b7_dinw), .w_enb(b7_enb),
	.r_addr_1(b7_addr1), .r_dout_1(b7_dout1),
	.r_addr_2(b7_addr2), .r_dout_2(b7_dout2),
	.r_addr_3(b7_addr3), .r_dout_3(b7_dout3),
	.r_addr_4(b7_addr4), .r_dout_4(b7_dout4),
	.r_addr_5(b7_addr5), .r_dout_5(b7_dout5),
	.r_addr_6(b7_addr6), .r_dout_6(b7_dout6),
	.r_addr_7(b7_addr7), .r_dout_7(b7_dout7),
	.r_addr_8(b7_addr8), .r_dout_8(b7_dout8)
        );

ram_8R1W block8(
	.clk(clk), .rst(rst),
	.w_addr_1(b8_addrw), .w_din_1(b8_dinw), .w_enb(b8_enb),
	.r_addr_1(b8_addr1), .r_dout_1(b8_dout1),
	.r_addr_2(b8_addr2), .r_dout_2(b8_dout2),
	.r_addr_3(b8_addr3), .r_dout_3(b8_dout3),
	.r_addr_4(b8_addr4), .r_dout_4(b8_dout4),
	.r_addr_5(b8_addr5), .r_dout_5(b8_dout5),
	.r_addr_6(b8_addr6), .r_dout_6(b8_dout6),
	.r_addr_7(b8_addr7), .r_dout_7(b8_dout7),
	.r_addr_8(b8_addr8), .r_dout_8(b8_dout8)
        );
////////////////////////////////////////////////
always@(*)
    begin
	////Read////
	b1_addr1 = r_addr_1;
	b2_addr1 = r_addr_1;
	b3_addr1 = r_addr_1;
	b4_addr1 = r_addr_1;
	b5_addr1 = r_addr_1;
	b6_addr1 = r_addr_1;
	b7_addr1 = r_addr_1;
	b8_addr1 = r_addr_1;

        b1_addr2 = r_addr_2;
	b2_addr2 = r_addr_2;
	b3_addr2 = r_addr_2;
	b4_addr2 = r_addr_2;
	b5_addr2 = r_addr_2;
	b6_addr2 = r_addr_2;
	b7_addr2 = r_addr_2;
	b8_addr2 = r_addr_2;
	
        b1_addr3 = r_addr_3;
	b2_addr3 = r_addr_3;
	b3_addr3 = r_addr_3;
	b4_addr3 = r_addr_3;
	b5_addr3 = r_addr_3;
	b6_addr3 = r_addr_3;
	b7_addr3 = r_addr_3;
	b8_addr3 = r_addr_3;
	
        b1_addr4 = r_addr_4;
	b2_addr4 = r_addr_4;
	b3_addr4 = r_addr_4;
	b4_addr4 = r_addr_4;
	b5_addr4 = r_addr_4;
	b6_addr4 = r_addr_4;
	b7_addr4 = r_addr_4;
	b8_addr4 = r_addr_4;
	
        b1_addr5 = r_addr_5;
	b2_addr5 = r_addr_5;
	b3_addr5 = r_addr_5;
	b4_addr5 = r_addr_5;
	b5_addr5 = r_addr_5;
	b6_addr5 = r_addr_5;
	b7_addr5 = r_addr_5;
	b8_addr5 = r_addr_5;
	
        b1_addr6 = r_addr_6;
	b2_addr6 = r_addr_6;
	b3_addr6 = r_addr_6;
	b4_addr6 = r_addr_6;
	b5_addr6 = r_addr_6;
	b6_addr6 = r_addr_6;
	b7_addr6 = r_addr_6;
	b8_addr6 = r_addr_6;
	
        b1_addr7 = r_addr_7;
	b2_addr7 = r_addr_7;
	b3_addr7 = r_addr_7;
	b4_addr7 = r_addr_7;
	b5_addr7 = r_addr_7;
	b6_addr7 = r_addr_7;
	b7_addr7 = r_addr_7;
	b8_addr7 = r_addr_7;
	
        b1_addr8 = r_addr_8;
	b2_addr8 = r_addr_8;
	b3_addr8 = r_addr_8;
	b4_addr8 = r_addr_8;
	b5_addr8 = r_addr_8;
	b6_addr8 = r_addr_8;
	b7_addr8 = r_addr_8;
	b8_addr8 = r_addr_8;
        ///////////////////////////////////////////
	///// Read ports choice - Multiplexor /////
        case (lvt_r1_choose)
		3'b000 : r_dout_1 = b1_dout1;
		3'b001 : r_dout_1 = b2_dout1;
		3'b010 : r_dout_1 = b3_dout1;
		3'b011 : r_dout_1 = b4_dout1;
		3'b100 : r_dout_1 = b5_dout1;
		3'b101 : r_dout_1 = b6_dout1;
		3'b110 : r_dout_1 = b7_dout1;
		3'b111 : r_dout_1 = b8_dout1;
		default : r_dout_1 = b1_dout1;
	    endcase

        case (lvt_r2_choose)
		3'b000 : r_dout_2 = b1_dout2;
		3'b001 : r_dout_2 = b2_dout2;
		3'b010 : r_dout_2 = b3_dout2;
		3'b011 : r_dout_2 = b4_dout2;
		3'b100 : r_dout_2 = b5_dout2;
		3'b101 : r_dout_2 = b6_dout2;
		3'b110 : r_dout_2 = b7_dout2;
		3'b111 : r_dout_2 = b8_dout2;
		default : r_dout_2 = b1_dout2;
	    endcase

	case (lvt_r3_choose)
		3'b000 : r_dout_3 = b1_dout3;
		3'b001 : r_dout_3 = b2_dout3;
		3'b010 : r_dout_3 = b3_dout3;
		3'b011 : r_dout_3 = b4_dout3;
		3'b100 : r_dout_3 = b5_dout3;
		3'b101 : r_dout_3 = b6_dout3;
		3'b110 : r_dout_3 = b7_dout3;
		3'b111 : r_dout_3 = b8_dout3;
		default : r_dout_3 = b1_dout3;
	    endcase

	case (lvt_r4_choose)
		3'b000 : r_dout_4 = b1_dout4;
		3'b001 : r_dout_4 = b2_dout4;
		3'b010 : r_dout_4 = b3_dout4;
		3'b011 : r_dout_4 = b4_dout4;
		3'b100 : r_dout_4 = b5_dout4;
		3'b101 : r_dout_4 = b6_dout4;
		3'b110 : r_dout_4 = b7_dout4;
		3'b111 : r_dout_4 = b8_dout4;
		default : r_dout_4 = b1_dout4;
	    endcase

	case (lvt_r5_choose)
		3'b000 : r_dout_5 = b1_dout5;
		3'b001 : r_dout_5 = b2_dout5;
		3'b010 : r_dout_5 = b3_dout5;
		3'b011 : r_dout_5 = b4_dout5;
		3'b100 : r_dout_5 = b5_dout5;
		3'b101 : r_dout_5 = b6_dout5;
		3'b110 : r_dout_5 = b7_dout5;
		3'b111 : r_dout_5 = b8_dout5;
		default : r_dout_5 = b1_dout5;
	    endcase

	case (lvt_r6_choose)
		3'b000 : r_dout_6 = b1_dout6;
		3'b001 : r_dout_6 = b2_dout6;
		3'b010 : r_dout_6 = b3_dout6;
		3'b011 : r_dout_6 = b4_dout6;
		3'b100 : r_dout_6 = b5_dout6;
		3'b101 : r_dout_6 = b6_dout6;
		3'b110 : r_dout_6 = b7_dout6;
		3'b111 : r_dout_6 = b8_dout6;
		default : r_dout_6 = b1_dout6;
	    endcase

	case (lvt_r7_choose)
		3'b000 : r_dout_7 = b1_dout7;
		3'b001 : r_dout_7 = b2_dout7;
		3'b010 : r_dout_7 = b3_dout7;
		3'b011 : r_dout_7 = b4_dout7;
		3'b100 : r_dout_7 = b5_dout7;
		3'b101 : r_dout_7 = b6_dout7;
		3'b110 : r_dout_7 = b7_dout7;
		3'b111 : r_dout_7 = b8_dout7;
		default : r_dout_7 = b1_dout7;
	    endcase

	case (lvt_r8_choose)
		3'b000 : r_dout_8 = b1_dout8;
		3'b001 : r_dout_8 = b2_dout8;
		3'b010 : r_dout_8 = b3_dout8;
		3'b011 : r_dout_8 = b4_dout8;
		3'b100 : r_dout_8 = b5_dout8;
		3'b101 : r_dout_8 = b6_dout8;
		3'b110 : r_dout_8 = b7_dout8;
		3'b111 : r_dout_8 = b8_dout8;
		default : r_dout_8 = b1_dout8;
	    endcase
	////Write////
	b1_addrw = w_addr_1;
	b2_addrw = w_addr_2;
	b3_addrw = w_addr_3;
	b4_addrw = w_addr_4;
	b5_addrw = w_addr_5;
	b6_addrw = w_addr_6;
	b7_addrw = w_addr_7;
	b8_addrw = w_addr_8;
	
        b1_enb = w_enb_1;
	b2_enb = w_enb_2;
	b3_enb = w_enb_3;
	b4_enb = w_enb_4;
	b5_enb = w_enb_5;
	b6_enb = w_enb_6;
	b7_enb = w_enb_7;
	b8_enb = w_enb_8;

	b1_dinw = w_din_1;
	b2_dinw = w_din_2;
	b3_dinw = w_din_3;
	b4_dinw = w_din_4;
	b5_dinw = w_din_5;
	b6_dinw = w_din_6;
	b7_dinw = w_din_7;
	b8_dinw = w_din_8;
    end

always@(negedge clk)
    begin
	////Read////
	lvt_r1_choose <= lvt_table[r_addr_1];
	lvt_r2_choose <= lvt_table[r_addr_2];
	lvt_r3_choose <= lvt_table[r_addr_3];
	lvt_r4_choose <= lvt_table[r_addr_4];
	lvt_r5_choose <= lvt_table[r_addr_5];
	lvt_r6_choose <= lvt_table[r_addr_6];
	lvt_r7_choose <= lvt_table[r_addr_7];
	lvt_r8_choose <= lvt_table[r_addr_8];
	////Write////
	if(w_enb_1 == 1)begin
		lvt_table[w_addr_1] = 3'b000;
	    end
	if(w_enb_2 == 1)begin
		lvt_table[w_addr_2] = 3'b001;
	    end
	if(w_enb_3 == 1)begin
		lvt_table[w_addr_3] = 3'b010;
	    end
	if(w_enb_4 == 1)begin
		lvt_table[w_addr_4] = 3'b011;
	    end
	if(w_enb_5 == 1)begin
		lvt_table[w_addr_5] = 3'b100;
	    end
	if(w_enb_6 == 1)begin
		lvt_table[w_addr_6] = 3'b101;
	    end
	if(w_enb_7 == 1)begin
		lvt_table[w_addr_7] = 3'b110;
	    end
	if(w_enb_8 == 1)begin
		lvt_table[w_addr_8] = 3'b111;
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

