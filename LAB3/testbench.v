`define CYCLE_TIME 20
`define INSTRUCTION_NUMBERS 90000 	//inrput大數字(EX:123)
//`define INSTRUCTION_NUMBERS 1000  //input小數字 (EX: 1-10 )
`timescale 1ns/1ps
`include "CPU.v"

module testbench;
reg Clk, Rst;
reg [31:0] cycles, i;

// Instruction DM initialilation
initial
begin
		/* =============================================R-type Test==============================================*/
		/*
		cpu.IF.instruction[ 0] = 32'b000000_00001_00010_00011_00000_100100;	//slt $3, $1, $2  
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)			
		for (i=4; i<128; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		*/
		
		
		/* =============================================I-type sw/lw Test========================================
		cpu.IF.instruction[ 0] = 32'b100011_00001_00010_00000_00000_000000;	//lw $t2, 0($m1)   
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.instruction[ 4] = 32'b101011_00001_00010_00000_00000_000001;	//sw $t2, 1($m1)	
		for (i=5; i<128; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		*/
		
		/* =============================================I-type beq/bne Test========================================*/
		/*
		//cpu.IF.instruction[ 0] = 32'b000100_00001_00010_00000_00000_000111;	//   beq $t2,$t1,8-0-1=7   
		//cpu.IF.instruction[ 0] = 32'b000101_00001_00010_00000_00000_001000;	//   bne $t0,$t1,8   
		//cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	//00 NOP(add $0, $0, $0)
		//cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//01 NOP(add $0, $0, $0)
		//cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//02 NOP(add $0, $0, $0)
		
		
		cpu.IF.instruction[ 0] = 32'b000000_00011_00010_00011_00000_100000;	//03 add $3, $3, $2    
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	//04 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//05 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//06 NOP(add $0, $0, $0)
		
		
		cpu.IF.instruction[ 4] = 32'b000000_00010_00001_00010_00000_100000;	//07 add $2, $2, $1  
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;	//08 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;	//09 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	//10 NOP(add $0, $0, $0)	
		cpu.IF.instruction[ 8] = 32'b000000_00010_01001_00100_00000_100000;	//07 add $4, $2, $9  $4 =$2  
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	//08 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 10] = 32'b000000_00000_00000_00000_00000_100000;	//09 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 11] = 32'b000000_00000_00000_00000_00000_100000;	//10 NOP(add $0, $0, $0)		
		cpu.IF.instruction[ 12] = 32'b000100_01000_00100_11111_11111_110111;	//   beq $t4,$t8,4-12-1 = -9
		cpu.IF.instruction[13] = 32'b000000_00000_00000_00000_00000_100000;	//08 NOP(add $0, $0, $0)
		cpu.IF.instruction[14] = 32'b000000_00000_00000_00000_00000_100000;	//09 NOP(add $0, $0, $0)
		cpu.IF.instruction[15] = 32'b000000_00000_00000_00000_00000_100000;	//10 NOP(add $0, $0, $0)
		*/


		/* =============================================J-type jmump Test========================================   
		cpu.IF.instruction[ 0] = 32'b000010_00000_00000_00000_00000_001001;	//  j 9   
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	//01 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	//02 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	//03 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 4] = 32'b000000_00001_00010_00011_00000_100000;	//04 add $3, $1, $2    
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;	//05 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;	//06 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	//07 NOP(add $0, $0, $0)
		cpu.IF.instruction[ 8] = 32'b000000_00001_00010_00100_00000_100000;	//08 add $4, $1, $2    
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	//09 NOP(add $0, $0, $0)
		cpu.IF.instruction[10] = 32'b000000_00000_00000_00000_00000_100000;	//10 NOP(add $0, $0, $0)
		cpu.IF.instruction[11] = 32'b000000_00000_00000_00000_00000_100000;	//11 NOP(add $0, $0, $0)
		
		for (i=12; i<128; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		*/
		
		
		
		/* =============================================find biger and samller prime========================================*/   
		
		//********************************************************big_initial************************************************
		
		// if input2 output 3,0
		//if input1 output 2,0
		//if輸入數字過大 需要調大CYCLE數
		
		cpu.IF.instruction[ 0] = 32'b100011_00000_00010_00000_00000_000000;	// lw $t2, 0($m0)   
		cpu.IF.instruction[ 1] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 2] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 3] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 4] = 32'b000000_00010_01001_00011_00000_100000;	// add $t3, $t2, $t9       $t3 = $t2 
		cpu.IF.instruction[ 5] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 6] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 7] = 32'b000000_00000_00000_00000_00000_100000;	// NOP		
		
		//add
		cpu.IF.instruction[ 8] = 32'b000000_00011_00001_00011_00000_100000;	// add $t3, $t3, $t1       $t3 = $t2 + 1
		cpu.IF.instruction[ 9] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[10] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[11] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[12] = 32'b000100_01000_00011_00000_00000_101011;// beq $t3,$t8,Retrun(56-12-1=43 )  beq $t3,2,Retrun      
		cpu.IF.instruction[13] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[14] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[15] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[16] = 32'b000000_00010_00001_00101_00000_100010;// sub $t5, $t2, $t1       $t5 = $t2 - 1
		cpu.IF.instruction[17] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[18] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[19] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 20] = 32'b000000_01001_00001_00100_00000_100000;// add $t4, $t9, $t1       $t4 = 0 + 1
		cpu.IF.instruction[ 21] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 22] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 23] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		
		
		
		//FOR
		cpu.IF.instruction[ 24] = 32'b000000_00011_01001_00110_00000_100000;// add $t6, $t3, $t9   
		cpu.IF.instruction[ 25] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 26] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 27] = 32'b000000_00000_00000_00000_00000_100000;// NOP		
		cpu.IF.instruction[ 28] = 32'b000000_00100_00001_00100_00000_100000;// add $t4, $t4, $t1       $t4 = $t4 + 1
		cpu.IF.instruction[ 29] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 30] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 31] = 32'b000000_00000_00000_00000_00000_100000;// NOP		
		cpu.IF.instruction[ 32] = 32'b000100_00100_00011_00000_00000_010111;// beq $t4,$t3,Retrun(56-32-1=23)      
		cpu.IF.instruction[ 33] = 32'b000000_00000_00000_00000_00000_100000;// NOP(add $0, $0, $0)
		cpu.IF.instruction[ 34] = 32'b000000_00000_00000_00000_00000_100000;// NOP(add $0, $0, $0)
		cpu.IF.instruction[ 35] = 32'b000000_00000_00000_00000_00000_100000;// NOP(add $0, $0, $0)
		
		//ISPRIME
		cpu.IF.instruction[ 36] = 32'b000000_00110_00100_00110_00000_100010;// sub $t6, $t6, $t4       
		cpu.IF.instruction[ 37] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 38] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 39] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 40] = 32'b000100_00110_01001_11111_11111_011111;// beq t$6 , $t9, add(8-40-1=-33)   beq t$6 , 0, add         
		cpu.IF.instruction[ 41] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 42] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 43] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 44] = 32'b000000_00110_01001_00111_00000_101010;// slt $t7, $t6, $t9       
		cpu.IF.instruction[ 45] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 46] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 47] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 48] = 32'b000100_00111_00001_11111_11111_100111;// beq t$7 , $t1, for  (24-48-1=-25)         
		cpu.IF.instruction[ 49] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 50] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 51] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 52] = 32'b000100_00111_01001_11111_11111_101111;// beq t$7 , $t9, isprime   (36-52-1=-17)       t9=0   
		cpu.IF.instruction[ 53] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 54] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 55] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		
		
		//Retunr_big
		cpu.IF.instruction[ 56] = 32'b101011_00001_00011_00000_00000_000000;// sw $t3, 0($m1)	
		cpu.IF.instruction[ 57] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 58] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 59] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		
		
		
		//*****************************************************small_initial******************************************************/
		
		cpu.IF.instruction[ 60] = 32'b100011_00000_00010_00000_00000_000000;	// lw $t2, 0($m0)   
		cpu.IF.instruction[ 61] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 62] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 63] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 64] = 32'b000000_00010_01001_00011_00000_100000;	// add $t3, $t2, $t9       $t3 = $t2 
		cpu.IF.instruction[ 65] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 66] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[ 67] = 32'b000000_00000_00000_00000_00000_100000;	// NOP		
		
		//sub
		cpu.IF.instruction[ 68] = 32'b000000_00011_00001_00011_00000_100010;	// sub $t3, $t3, $t1       $t3 = $t2 - 1
		cpu.IF.instruction[ 69] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[70] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[71] = 32'b000000_00000_00000_00000_00000_100000;	// NOP
		cpu.IF.instruction[72] = 32'b000100_01000_00011_00000_00000_101011;// beq $t3,$t8,Retrun(116-72-1=43 )  beq $t3,2,Retrun      
		cpu.IF.instruction[73] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[74] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[75] = 32'b000000_00000_00000_00000_00000_100000;//NOP
		cpu.IF.instruction[76] = 32'b000000_00010_00001_00101_00000_100010;// sub $t5, $t2, $t1       $t5 = $t2 - 1
		cpu.IF.instruction[77] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[78] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[79] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 80] = 32'b000000_01001_00001_00100_00000_100000;// add $t4, $t9, $t1       $t4 = 0 + 1
		cpu.IF.instruction[ 81] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 82] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 83] = 32'b000000_00000_00000_00000_00000_100000;// NOP
	
		
		
		//FOR
		cpu.IF.instruction[ 84] = 32'b000000_00011_01001_00110_00000_100000;// add $t6, $t3, $t9    t6 = t3 +0
		cpu.IF.instruction[ 85] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 86] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 87] = 32'b000000_00000_00000_00000_00000_100000;// NOP		
		cpu.IF.instruction[ 88] = 32'b000000_00100_00001_00100_00000_100000;// add $t4, $t4, $t1       $t4 = $t4 + 1
		cpu.IF.instruction[ 89] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 90] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 91] = 32'b000000_00000_00000_00000_00000_100000;// NOP		
		cpu.IF.instruction[ 92] = 32'b000100_00100_00011_00000_00000_010111;// beq $t4,$t3,Retrun2(116-92-1=23)      
		cpu.IF.instruction[ 93] = 32'b000000_00000_00000_00000_00000_100000;// NOP(add $0, $0, $0)
		cpu.IF.instruction[ 94] = 32'b000000_00000_00000_00000_00000_100000;// NOP(add $0, $0, $0)
		cpu.IF.instruction[ 95] = 32'b000000_00000_00000_00000_00000_100000;// NOP(add $0, $0, $0)
		
		//ISPRIME
		cpu.IF.instruction[ 96] = 32'b000000_00110_00100_00110_00000_100010;// sub $t6, $t6, $t4       
		cpu.IF.instruction[ 97] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 98] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[ 99] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[100] = 32'b000100_00110_01001_11111_11111_011111;// beq t$6 , $t9, sub(68-100-1=-33)         
		cpu.IF.instruction[101] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[102] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[103] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[104] = 32'b000000_00110_01001_00111_00000_101010;// slt $t7, $t6, $t9     
		cpu.IF.instruction[105] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[106] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[107] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[108] = 32'b000100_00111_00001_11111_11111_100111;// beq t$7 , $t1, for  (84-108-1=-25)         
		cpu.IF.instruction[109] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[110] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[111] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[112] = 32'b000100_00111_01001_11111_11111_101111;// beq t$7 , $t9, isprime   (96-112-1=-17)         
		cpu.IF.instruction[113] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[114] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[115] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		
		//Retunr_small
		cpu.IF.instruction[116] = 32'b101011_00001_00011_00000_00000_000001;// sw $t3, 1($m1)	
		cpu.IF.instruction[117] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[118] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[119] = 32'b000000_00000_00000_00000_00000_100000;// NOP	
		cpu.IF.instruction[120] = 32'b000100_00000_00000_11111_11111_111110;// beq $0 , $t0, nop  119-120-1 = -2		
		cpu.IF.instruction[121] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[122] = 32'b000000_00000_00000_00000_00000_100000;// NOP
		cpu.IF.instruction[123] = 32'b000000_00000_00000_00000_00000_100000;// NOP	
		
		
		for (i=124; i<128; i=i+1)  cpu.IF.instruction[ i] = 32'b000000_00000_00000_00000_00000_100000;	//NOP(add $0, $0, $0)
		cpu.IF.PC = 0;
		

end

// Data Memory & Register Files initialilation
initial
begin
	cpu.MEM.DM[0] = 32'd123;  	// INPUT 若input超過123 請調大INSTRUCTION_NUMBERS
	cpu.MEM.DM[1] = 32'd0;		//output1
	cpu.MEM.DM[2] = 32'd0;		//output2
	for (i=3; i<128; i=i+1) cpu.MEM.DM[i] = 32'b0;
	
	cpu.ID.REG[0] = 32'd0; // nop專用
	cpu.ID.REG[1] = 32'd1; //+1專用	
	cpu.ID.REG[2] = 32'd1; //M0 input
	cpu.ID.REG[3] = 32'd1; //serach bigger or smallest prime
	cpu.ID.REG[4] = 32'd1; //test prime value
	cpu.ID.REG[5] = 32'd1000; //test prime end condition
	cpu.ID.REG[6] = 32'd1; //test prime minus detemine is prime 
	cpu.ID.REG[7] = 32'd2; //test prime minus detemine is prime slt 
	cpu.ID.REG[8] = 32'd2; //2 專用  
	cpu.ID.REG[9] = 32'd0; //0 專用
	for (i=10; i<32; i=i+1) cpu.ID.REG[i] = 32'b0;
	
	


end

//clock cycle time is 20ns, inverse Clk value per 10ns
initial Clk = 1'b1;
always #(`CYCLE_TIME/2) Clk = ~Clk;

//Rst signal
initial begin
	cycles = 32'b0;
	Rst = 1'b1;
	#12 Rst = 1'b0;
end

CPU cpu(
	.clk(Clk),
	.rst(Rst)
);

//display all Register value and Data memory content
always @(posedge Clk) begin
	cycles <= cycles + 1;
	if (cycles == `INSTRUCTION_NUMBERS) $finish; // Finish when excute the 24-th instruction (End label).
	$display("PC: %d cycles: %d", cpu.FD_PC>>2 , cycles);
	$display("  R00-R07: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[0], cpu.ID.REG[1], cpu.ID.REG[2], cpu.ID.REG[3],cpu.ID.REG[4], cpu.ID.REG[5], cpu.ID.REG[6], cpu.ID.REG[7]);
	$display("  R08-R15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[8], cpu.ID.REG[9], cpu.ID.REG[10], cpu.ID.REG[11],cpu.ID.REG[12], cpu.ID.REG[13], cpu.ID.REG[14], cpu.ID.REG[15]);
	$display("  R16-R23: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[16], cpu.ID.REG[17], cpu.ID.REG[18], cpu.ID.REG[19],cpu.ID.REG[20], cpu.ID.REG[21], cpu.ID.REG[22], cpu.ID.REG[23]);
	$display("  R24-R31: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.ID.REG[24], cpu.ID.REG[25], cpu.ID.REG[26], cpu.ID.REG[27],cpu.ID.REG[28], cpu.ID.REG[29], cpu.ID.REG[30], cpu.ID.REG[31]);
	$display("  MEM 0-7: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[0],cpu.MEM.DM[1],cpu.MEM.DM[2],cpu.MEM.DM[3],cpu.MEM.DM[4],cpu.MEM.DM[5],cpu.MEM.DM[6],cpu.MEM.DM[7]);
	$display("  MEM8-15: %08x %08x %08x %08x %08x %08x %08x %08x", cpu.MEM.DM[8],cpu.MEM.DM[9],cpu.MEM.DM[10],cpu.MEM.DM[11],cpu.MEM.DM[12],cpu.MEM.DM[13],cpu.MEM.DM[14],cpu.MEM.DM[15]);
end

//generate wave file, it can use gtkwave to display
initial begin
	$dumpfile("cpu_hw.vcd");
	$dumpvars;
end
endmodule

