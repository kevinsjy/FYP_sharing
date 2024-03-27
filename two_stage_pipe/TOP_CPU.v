

`timescale 1ns/1ns
`include "definitions.svh"
module TOP_CPU
   
(
    input wire          clk,
    input wire          rst,
    //output wire[31:0]   result
    output wire  [31:0]led_101100_dubug
);
 
    //wire [31:0] led_101100_dubug;

    wire [31:0]  pc_i;
    wire [31:0]  pc_o;

    wire [31:0] im_o;

    // IF_ID
    wire        if_flush;
    wire [31:0] pc_if_o;
    wire [31:0] im_if_o;

    // Control Unite ouput 
    wire        Branch;
    wire        MemRead;
    wire        MemtoReg;
    wire [1:0]  ALUOp;
    wire        MemWrite;
    wire        ALUSrc;
    wire        RegWrite;
	wire 		Jalr;
	wire		Jal;
    // ALU Control ouput 
    wire [3:0]  ALUCtl;

    // Register Files
    wire [31:0] dm_mux_o;
	wire [31:0] rf_write;
    wire [31:0] rf_o_1;
	wire [31:0] rf_o_2;
    // Imm gen
    wire [31:0] ig_o;
    // ALU
    wire [31:0] alu_o;
    wire Zero;

    //Data memory
    wire [31:0] dm_data_o;

    //RF_ALU_MUX
    wire [31:0] alu_b_i;
    
    
    //-------------------------------------------------------------------------------------
    //The first level of the pipeline IF
    //-------------------------------------------------------------------------------------
    //***********************************************Program Counter Branch ******************************//
    PC_BRANCH U_pc_branch(
        .pc_o(pc_if_o),
        .ig_o(ig_o),
		.alu_o(alu_o),
        .Branch(Branch),
        .Zero(Zero),
		.Jal(Jal),
		.Jalr(Jalr),
        .pc_new(pc_i)
    );
    //***********************************************Program Counter******************************//
    PC U_pc(
        .clk (clk),
        .rst(rst),
        .pc_i(pc_i),
        .pc_o(pc_o)
    );
    
    //***********************************************Instrution Memory******************************//

    IM U_im(
        .im_rd_ads(pc_o),           //ADD instruction
        .ist(im_o)
    );


    //-------------------------------------------------------------------------------------
    //The Segment register IF_ID
    //-------------------------------------------------------------------------------------

    IF_ID U_if_id(
        .clk(clk),
        .rst(rst),
        .flush(if_flush),
        .instruct_in(im_o),
        .pc_i(pc_o),
        .pc_out(pc_if_o),
        .instruct_out(im_if_o)
    );

    
    //-------------------------------------------------------------------------------------
    //The second level of the pipeline  ID
    //-------------------------------------------------------------------------------------
    
    //***********************************************Control******************************//

    Hazard_Detec U_hazard_detec(
        .instruct_i(im_if_o),
        .reg1_data_i(rf_o_1),
        .reg2_data_i(rf_o_2),
        .flush(if_flush)
    );

  //***********************************************Control******************************//

    Control U_control(
        .Control_op(im_if_o[6:0]),
        .Branch(Branch),
        .MemRead(MemRead),
        .MemtoReg(MemtoReg),
        .ALUOp(ALUOp),
        .MemWrite(MemWrite),
        .ALUSrc(ALUSrc),
        .RegWrite(RegWrite),
		.Jal(Jal),
		.Jalr(Jalr)

    );
    //***********************************************ALU Control******************************//

   

    ALUControl U_alucontrol(
        .ALUOp(ALUOp),
        .FunCode({im_if_o[30],im_if_o[14:12]}),
        .ALUCtl(ALUCtl)
    );

    //***********************************************Register Files******************************//

    RF U_rf(
        .clk(clk),
        .rst(rst),
        .RegWrite(RegWrite),
        .r_rg_1(im_if_o[19:15]),
        .r_rg_2(im_if_o[24:20]),
        .w_rg(im_if_o[11:7]),
        .w_data(rf_write),
        .data_o_1(rf_o_1),
        .data_o_2(rf_o_2)
        //.output_x11_debug_led(led_101100_dubug)
        
    );
    //***********************************************Imme Gen ******************************//  
    IG U_ig(
        .ist_o(im_if_o),
        .ig_o(ig_o)
    );
    //***********************************************RF_ALU_MUX******************************//  
    RF_ALU_MUX U_rf_alu_mux(
        .ALUSrc(ALUSrc),
        .rf_data(rf_o_2),
        .ig_data(ig_o),
        .alu_b_i(alu_b_i)
    );
    
    //***********************************************ALU ******************************//

    ALU U_alu(
        .ALUCtl(ALUCtl),
        .a(rf_o_1),
        .b(alu_b_i),
        .alu_o(alu_o),
        .Zero(Zero)
    );

    //***********************************************ALU ******************************//
    DM  U_dm(
        .clk(clk),
        .rst(rst),
        .MemWrite(MemWrite),
        .MemRead(MemRead),
        .w_addr_i(alu_o),
        .w_data_i(rf_o_2),
        .r_data_o(dm_data_o),
        .output_x11_debug_led(led_101100_dubug)

    );
   //***********************************************Write back MUX from ALU or Data memory  ******************************//
    WB U_wb(
        .MemtoReg(MemtoReg),
        .memory_data(dm_data_o),
        .alu_data(alu_o),
        .write_data_o(dm_mux_o)
    );
 //***********************************************Unonditional branch to RF  ******************************//
	Jal_Jalr_RF U_jal_jalr_rf(
		.pc_o(pc_if_o),
		.dm_mux_o(dm_mux_o),
		.Jal(Jal),
		.Jalr(Jalr),
		.rf_write(rf_write)
    );  

endmodule 