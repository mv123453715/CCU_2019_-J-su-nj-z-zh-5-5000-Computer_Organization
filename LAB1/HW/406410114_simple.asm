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
	#$a0-$a3=�޼�(argument)�Ȧs��
	#$v0-$v1=�ƭ�(value)�Ȧs��
	#$t0-t9=���(integer)�Ȧs��
	#*****************************************************************************************#
	#��J�@�۵M��X�A��X�̱��񪺨��ơ@	�@ A�PB (X>A, X<B) 
	#If input 1 , output : null ,2 
	#If input 2 , output : null ,3 
	#*****************************************************************************************#
	
	#*****************************************************************************************#
	#���P�_�[�b�P�_��
	#�P�_��Ƥ�����B�J
	#(1) ��ƥ���6X+1 , 6X+5 �G�Y��6X +0 , 6X+2 , 6X+3, 6X+4�����L����
	#(2)�P�_Y�O�_�O��ƶȧ���Y �Y�i
	#�ƾ��ҩ�:(1) https://tw.answers.yahoo.com/question/index?qid=20091018000015KK07483
	#�ƾ��ҩ�(2) : https://www.zhihu.com/question/21808179
	#*****************************************************************************************#

	#*****************************************************************************************#
	#���G�G
	#input X = 2�ɥu�ݭn24�ӫ��O
	#input X = 100�ɥu�ݭn268�ӫ��O
	#input X = 1000�ɥu�ݭn1369�ӫ��O
	#input X = 10000�ɥu�ݭn8248�ӫ��O
	#�i���Ʀr�V�j�Y���ҬO�V�h��
	#*****************************************************************************************#	
	
	#Ū�۵M��X��t1
	li $v0,4	        # load syscall code (4 : print string) 
	la $a0,inputx		# load address of string to be printed into $a0 
	syscall			# print str 
	li $v0,5		# load syscall code (5 : read int)
	syscall			# read int 
	add $t0,$zero,$v0
	add $t1,$zero,$t0	#t1 = t0

	#�����j��
	# t0 original, t1 big , t2 big_remain , t5 int i ,t6 = �ڸ�t1, t7 issmall,t8 = t5 +2 , t9 = i
	
t1_add:	add $t1,$t1,1  		# t1 = t1 +1	

Initail:	add $t5,$zero,1		#t5 = 1	
	sub $t4,$t1,1
	
for_add:	add $t2,$zero,$t1	#t2 =t1
	add $t5,$t5,1		# t5 = t5+1
	beq $t5,$t1,return_1	#���
	
is_prime:	sub $t2,$t2,$t5		#$t2 = t2 - t5
	beq $t2,$zero,t1_add	# if == 0 �N���Aprime	
	slt $t3,$t2,$zero	#�p��s�N��O t3 =1
	beq $t3,1,for_add	#�p��0�ˬd�U�@��
	beq $t3,0,is_prime	#�j��0�~���

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
	beq $t5,$t1,return_2	#���
	
is_pri2:	sub $t2,$t2,$t5		#$t2 = t2 - t5
	beq $t2,$zero,t1_sub	# if == 0 �N���Aprime	
	slt $t3,$t2,$zero	#�p��s�N��O t3 =1
	beq $t3,1,for_add2	#�p��0�ˬd�U�@��
	beq $t3,0,is_pri2	#�j��0�~���



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
	

		


