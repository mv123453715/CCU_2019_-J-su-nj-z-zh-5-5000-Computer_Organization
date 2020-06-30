.data
result1:.asciiz "Prime_number_smaller_than_inputx: "
result2:.asciiz "Prime_number_greater_than_inputx: "
enter:.asciiz "\n"
result1_null : .asciiz "Prime_number_smaller_than_inputx : null\n"
##result2_null : .asciiz "Prime_number_greater_than_inputx:  null"
inputx:.asciiz "The number="
.text
.globl main
main:
	#$a0-$a3=引數(argument)暫存器
	#$v0-$v1=數值(value)暫存器
	#$t0-t9=整數(integer)暫存器
	#*****************************************************************************************#
	#輸入一自然數X，找出最接近的兩質數　	　 A與B (X>A, X<B) 
	#If input 1 , output : null ,2 
	#If input 2 , output : null ,3 
	#*****************************************************************************************#
	
	#*****************************************************************************************#
	#先判斷加在判斷減
	#判斷質數分成兩步驟
	#(1) 質數必為6X+1 , 6X+5 故若為6X +0 , 6X+2 , 6X+3, 6X+4均跳過不找
	#(2)判斷Y是否是質數僅找到√Y 即可
	#數學證明:(1) https://tw.answers.yahoo.com/question/index?qid=20091018000015KK07483
	#數學證明(2) : https://www.zhihu.com/question/21808179
	#*****************************************************************************************#

	#*****************************************************************************************#
	#成果：
	#input X = 2時只需要24個指令
	#input X = 100時只需要268個指令
	#input X = 1000時只需要1369個指令
	#input X = 10000時只需要8248個指令
	#可見數字越大縮減的比例是越多的
	#*****************************************************************************************#	
	
	#讀自然數X到t1
	li $v0,4	        # load syscall code (4 : print string) 
	la $a0,inputx		# load address of string to be printed into $a0 
	syscall			# print str 
	li $v0,5		# load syscall code (5 : read int)
	syscall			# read int 
	add $t0,$zero,$v0
	add $t1,$zero,$t0	#t1 = t0
	
	#先判斷特殊狀況 n = 1 or 2
	beq $t0,1,Exit_n1
	beq $t0,2,Exit_n2
	
	#先做大的
	# t0 original, t1 big , t2 big_remain , t5 int i ,t6 = 根號t1, t7 issmall,t8 = t5 +2 , t9 = i
	
t1_add:	add $t1,$t1,1  		# t1 = t1 +1	
	add $t5,$zero,$zero	#t5 = 0
		
addfilter:	beq  $t1,2,return_1
	beq  $t1,3,return_1
	div  $t2,$t1,6		#t3 = t1 / 6
	mfhi $t2
	beq  $t2,0,t1_add	# %6
	beq  $t2,1,AdForIni
	beq  $t2,2,t1_add
	beq  $t2,3,t1_add
	beq  $t2,4,t1_add
	beq  $t2,5,AdForIni		

AdForIni:	add $t5,$zero,5		# t5 = 5
	add $t9,$zero,$zero	#t9 = 0
	
AdFdSqrt:	add $t9,$t9,1		#t9= t1開根號
	mul $t6,$t9,$t9		
	slt $t3,$t6,$t1		# t6 < t1  t3 = 1    t6 >=t1  t3 =0
	beq $t3,1,AdFdSqrt	#還沒開完繼續

	mul  $t2,$t9,$t9	#if t1 是平方數就跳回去找
	beq  $t2,$t1,t1_add	
	sub $t9,$t9,1		#不是平方數 t9= t9-1  取floor
	
AdForCo:	slt $t7,$t9,$t5		# t9 < t5  t7 = 1    t9 >=t5  t7 =0
	beq $t7,1,return_1	#代表找到質數
	beq $t7,0,addispr	#還沒測試完繼續測
	
addispr:	div  $t2,$t1,$t5		#t2 = t1 % t5
	mfhi $t2
	beq  $t2,$zero,t1_add 	#餘數是0 代表非質數  再回去+1
	add  $t8,$t5,2 		#t8 = t5 +2  因為只判斷奇數
	div  $t2,$t1,$t8		#t2 = t1 % t5
	mfhi $t2
	beq  $t2,$zero,t1_add	#餘數是0 代表非質數  再回去+1
	add  $t5,$t5,6		#都不是0 繼續+6 進行測試
	j    AdForCo		#


sub_bgn:	add $t1,$zero,$t0	#t1 = t0

t1_sub:	sub $t1,$t1,1  		# t1 = t1 -1	
	add $t5,$zero,$zero	#t5 = 0
	
subfilter:	beq  $t1,2,return_2
	beq  $t1,3,return_2
	div  $t2,$t1,6		#t3 = t1 / 6
	mfhi $t2
	beq  $t2,0,t1_sub	# %6
	beq  $t2,1,SuForIni
	beq  $t2,2,t1_sub
	beq  $t2,3,t1_sub
	beq  $t2,4,t1_sub
	beq  $t2,5,SuForIni
	
SuForIni:	add $t5,$t5,5		# t5初始為5  因為5以前的狀況前面都考慮了
	add $t9,$zero,$zero	#t9 = 0
	
SuFdSqrt:	add $t9,$t9,1
	mul $t6,$t9,$t9		#t9 = t1開根號
	slt $t3,$t6,$t1		# t6 < t1  t3 = 1    t6 >=t1  t3 =0
	beq $t3,1,SuFdSqrt	#還沒開完繼續

	mul  $t2,$t9,$t9	#if t1 是平方數就跳回去找
	beq  $t2,$t1,t1_sub	
	sub $t9,$t9,1		#不是平方數 t9= t9-1  取floor


SuForCo:	slt $t7,$t9,$t5		# t9 < t5  t7 = 1    t9 >=t5  t7 =0
	beq $t7,1,return_2	#代表找到質數
	beq $t7,0,subispr	#還沒測試完繼續測
	
subispr:	div  $t2,$t1,$t5	#t2 = t1 % t5
	mfhi $t2
	beq  $t2,0,t1_sub 	#餘數是0 代表非質數  再回去-1
	add  $t8,$t5,2 		#t8 = t5 +2  因為只判斷奇數
	div  $t2,$t1,$t8	#t2 = t1 % t5
	mfhi $t2
	beq  $t2,0,t1_sub	#餘數是0 代表非質數  再回去-1
	add $t5,$t5,6		#都不是0 繼續+6 進行測試
	j    SuForCo		

return_1: 	li $v0,4
	la $a0,result2 
	syscall
	add $a0,$zero,$t1
	li $v0,1
	syscall
	li $v0,4
	la $a0,enter
	syscall
	j sub_bgn

return_2: 	li $v0,4
	la $a0,result1 
	syscall
	add $a0,$zero,$t1
	li $v0,1
	syscall
	li $v0,4
	la $a0,enter
	syscall
	li $v0,10
	syscall	
	
Exit_n1:	li $v0,4
	la $a0,result1_null 
	syscall
	la $a0,result2
	syscall
	add $a0,$zero 2
	li $v0,1
	syscall
	li $v0,10
	syscall

Exit_n2:	li $v0,4
	la $a0,result1_null 
	syscall
	la $a0,result2
	syscall
	add $a0,$zero 3
	li $v0,1
	syscall
	li $v0,10
	syscall
		


