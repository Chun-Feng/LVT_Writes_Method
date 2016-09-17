module ram_4R4W(
    clk,rst,
    w_addr_1, w_din_1, w_enb_1,
    w_addr_2, w_din_2, w_enb_2,
    w_addr_3, w_din_3, w_enb_3,
    w_addr_4, w_din_4, w_enb_4,
    r_addr_1, r_dout_1,
    r_addr_2, r_dout_2,
    r_addr_3, r_dout_3,
    r_addr_4, r_dout_4
    );

parameter BLOCKSIZE = 10;
parameter BLOCKNUM =  1;

/////////INOUT/////////
input clk;
input rst;

input [BLOCKSIZE : 0] w_addr_1, w_addr_2;
input [BLOCKSIZE : 0] w_addr_3, w_addr_4;
input [31:0] w_din_1,w_din_2;
input [31:0] w_din_3,w_din_4;
input w_enb_1, w_enb_2;
input w_enb_3, w_enb_4;

input [BLOCKSIZE : 0] r_addr_1, r_addr_2;
input [BLOCKSIZE : 0] r_addr_3, r_addr_4;
output reg [31:0] r_dout_1, r_dout_2;
output reg [31:0] r_dout_3, r_dout_4;
////////////////////////////////////////////
reg [BLOCKNUM : 0] lvt_table [0: ( 2 << BLOCKSIZE) - 1];
reg [BLOCKNUM : 0] lvt_r1_choose, lvt_r2_choose;
reg [BLOCKNUM : 0] lvt_r3_choose, lvt_r4_choose;
//////BLOCK INOUT///////
reg b1_enb, b2_enb;
reg b3_enb, b4_enb;

reg [BLOCKSIZE : 0] b1_addrw, b2_addrw;
reg [BLOCKSIZE : 0] b3_addrw, b4_addrw;
reg [31 : 0] b1_dinw, b2_dinw;
reg [31 : 0] b3_dinw, b4_dinw;

reg [BLOCKSIZE : 0] b1_addr1, b1_addr2, b2_addr1, b2_addr2;
reg [BLOCKSIZE : 0] b1_addr3, b1_addr4, b2_addr3, b2_addr4;
reg [BLOCKSIZE : 0] b3_addr1, b3_addr2, b4_addr1, b4_addr2;
reg [BLOCKSIZE : 0] b3_addr3, b3_addr4, b4_addr3, b4_addr4;

wire [31 : 0] b1_dout1, b1_dout2, b2_dout1, b2_dout2;
wire [31 : 0] b1_dout3, b1_dout4, b2_dout3, b2_dout4;
wire [31 : 0] b3_dout1, b3_dout2, b4_dout1, b4_dout2;
wire [31 : 0] b3_dout3, b3_dout4, b4_dout3, b4_dout4;
/////////BLOCKS/////////
ram_4R1W block1(
	.clk(clk), .rst(rst),
	.w_addr_1(b1_addrw), .w_din_1(b1_dinw), .w_enb(b1_enb),
	.r_addr_1(b1_addr1), .r_dout_1(b1_dout1),
	.r_addr_2(b1_addr2), .r_dout_2(b1_dout2),
	.r_addr_3(b1_addr3), .r_dout_3(b1_dout3),
	.r_addr_4(b1_addr4), .r_dout_4(b1_dout4)
        );

ram_4R1W block2(
	.clk(clk),.rst(rst),
	.w_addr_1(b2_addrw), .w_din_1(b2_dinw), .w_enb(b2_enb),
	.r_addr_1(b2_addr1), .r_dout_1(b2_dout1),
	.r_addr_2(b2_addr2), .r_dout_2(b2_dout2),
	.r_addr_3(b2_addr3), .r_dout_3(b2_dout3),
	.r_addr_4(b2_addr4), .r_dout_4(b2_dout4)
        );

ram_4R1W block3(
	.clk(clk), .rst(rst),
	.w_addr_1(b3_addrw), .w_din_1(b3_dinw), .w_enb(b3_enb),
	.r_addr_1(b3_addr1), .r_dout_1(b3_dout1),
	.r_addr_2(b3_addr2), .r_dout_2(b3_dout2),
	.r_addr_3(b3_addr3), .r_dout_3(b3_dout3),
	.r_addr_4(b3_addr4), .r_dout_4(b3_dout4)
        );

ram_4R1W block4(
	.clk(clk), .rst(rst),
	.w_addr_1(b4_addrw), .w_din_1(b4_dinw), .w_enb(b4_enb),
	.r_addr_1(b4_addr1), .r_dout_1(b4_dout1),
	.r_addr_2(b4_addr2), .r_dout_2(b4_dout2),
	.r_addr_3(b4_addr3), .r_dout_3(b4_dout3),
	.r_addr_4(b4_addr4), .r_dout_4(b4_dout4)
        );


always@(*)
    begin
	////Read////
	b1_addr1 = r_addr_1;
	b2_addr1 = r_addr_1;
	b3_addr1 = r_addr_1;
	b4_addr1 = r_addr_1;

	b1_addr2 = r_addr_2;
	b2_addr2 = r_addr_2;
	b3_addr2 = r_addr_2;
	b4_addr2 = r_addr_2;
	
        b1_addr3 = r_addr_3;
	b2_addr3 = r_addr_3;
	b3_addr3 = r_addr_3;
	b4_addr3 = r_addr_3;
	
        b1_addr4 = r_addr_4;
	b2_addr4 = r_addr_4;
	b3_addr4 = r_addr_4;
	b4_addr4 = r_addr_4;
	
        case (lvt_r1_choose)
		2'b00 : r_dout_1 = b1_dout1;
		2'b01 : r_dout_1 = b2_dout1;
		2'b10 : r_dout_1 = b3_dout1;
		2'b11 : r_dout_1 = b4_dout1;
		default : r_dout_1 = b1_dout1;
	    endcase
	case (lvt_r2_choose)
		2'b00 : r_dout_2 = b1_dout2;
		2'b01 : r_dout_2 = b2_dout2;
		2'b10 : r_dout_2 = b3_dout2;
		2'b11 : r_dout_2 = b4_dout2;
		default : r_dout_2 = b1_dout2;
	    endcase
	case (lvt_r3_choose)
		2'b00 : r_dout_3 = b1_dout3;
		2'b01 : r_dout_3 = b2_dout3;
		2'b10 : r_dout_3 = b3_dout3;
		2'b11 : r_dout_3 = b4_dout3;
		default : r_dout_3 = b1_dout3;
	    endcase
	case (lvt_r4_choose)
		2'b00 : r_dout_4 = b1_dout4;
		2'b01 : r_dout_4 = b2_dout4;
		2'b10 : r_dout_4 = b3_dout4;
		2'b11 : r_dout_4 = b4_dout4;
		default : r_dout_4 = b1_dout4;
	    endcase
	////Write////
	b1_addrw = w_addr_1;
	b2_addrw = w_addr_2;
	b3_addrw = w_addr_3;
	b4_addrw = w_addr_4;
	
        b1_enb = w_enb_1;
	b2_enb = w_enb_2;
	b3_enb = w_enb_3;
	b4_enb = w_enb_4;

	b1_dinw = w_din_1;
	b2_dinw = w_din_2;
	b3_dinw = w_din_3;
	b4_dinw = w_din_4;
    end

always@(negedge clk)
    begin
	////Read////
	lvt_r1_choose <= lvt_table[r_addr_1];
	lvt_r2_choose <= lvt_table[r_addr_2];
	lvt_r3_choose <= lvt_table[r_addr_3];
	lvt_r4_choose <= lvt_table[r_addr_4];

	////Write////
	if(w_enb_1 == 1)begin
		lvt_table[w_addr_1] = 2'b00;
	    end
	if(w_enb_2 == 1)begin
		lvt_table[w_addr_2] = 2'b01;
	    end
	if(w_enb_3 == 1)begin
		lvt_table[w_addr_3] = 2'b10;
	    end
	if(w_enb_4 == 1)begin
		lvt_table[w_addr_4] = 2'b11;
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

