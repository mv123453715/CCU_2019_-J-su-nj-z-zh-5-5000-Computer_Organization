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

	#先做大的
	# t0 original, t1 big , t2 big_remain , t5 int i ,t6 = 根號t1, t7 issmall,t8 = t5 +2 , t9 = i
	
t1_add:	add $t1,$t1,1  		# t1 = t1 +1	

Initail:	add $t5,$zero,1		#t5 = 1	
	sub $t4,$t1,1
	
for_add:	add $t2,$zero,$t1	#t2 =t1
	add $t5,$t5,1		# t5 = t5+1
	beq $t5,$t1,return_1	#找到
	
is_prime:	sub $t2,$t2,$t5		#$t2 = t2 - t5
	beq $t2,$zero,t1_add	# if == 0 代表不適prime	
	slt $t3,$t2,$zero	#小於零代表是 t3 =1
	beq $t3,1,for_add	#小於0檢查下一個
	beq $t3,0,is_prime	#大於0繼續減

return_1: 	li $v0,4
	la $a0,result2 
	syscall
	add $a0,$zero,$t1
	li $v0,1
	syscall
	li $v0,4
	la $a0,enter
	syscall
	
	add $t1,$zero,$t0
t1_sub:	sub $t1,$t1,1  		# t1 = t1 +1	

	add $t5,$zero,1		#t5 = 1	
	sub $t4,$t1,1
	
for_add2:	add $t2,$zero,$t1	#t2 =t1
	add $t5,$t5,1		# t5 = t5+1
	beq $t5,$t1,return_2	#找到
	
is_pri2:	sub $t2,$t2,$t5		#$t2 = t2 - t5
	beq $t2,$zero,t1_sub	# if == 0 代表不適prime	
	slt $t3,$t2,$zero	#小於零代表是 t3 =1
	beq $t3,1,for_add2	#小於0檢查下一個
	beq $t3,0,is_pri2	#大於0繼續減



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
	

		


