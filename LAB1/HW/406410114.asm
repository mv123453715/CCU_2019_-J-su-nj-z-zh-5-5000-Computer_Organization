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
	
	#���P�_�S���p n = 1 or 2
	beq $t0,1,Exit_n1
	beq $t0,2,Exit_n2
	
	#�����j��
	# t0 original, t1 big , t2 big_remain , t5 int i ,t6 = �ڸ�t1, t7 issmall,t8 = t5 +2 , t9 = i
	
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
	
AdFdSqrt:	add $t9,$t9,1		#t9= t1�}�ڸ�
	mul $t6,$t9,$t9		
	slt $t3,$t6,$t1		# t6 < t1  t3 = 1    t6 >=t1  t3 =0
	beq $t3,1,AdFdSqrt	#�٨S�}���~��

	mul  $t2,$t9,$t9	#if t1 �O����ƴN���^�h��
	beq  $t2,$t1,t1_add	
	sub $t9,$t9,1		#���O����� t9= t9-1  ��floor
	
AdForCo:	slt $t7,$t9,$t5		# t9 < t5  t7 = 1    t9 >=t5  t7 =0
	beq $t7,1,return_1	#�N������
	beq $t7,0,addispr	#�٨S���է��~���
	
addispr:	div  $t2,$t1,$t5		#t2 = t1 % t5
	mfhi $t2
	beq  $t2,$zero,t1_add 	#�l�ƬO0 �N��D���  �A�^�h+1
	add  $t8,$t5,2 		#t8 = t5 +2  �]���u�P�_�_��
	div  $t2,$t1,$t8		#t2 = t1 % t5
	mfhi $t2
	beq  $t2,$zero,t1_add	#�l�ƬO0 �N��D���  �A�^�h+1
	add  $t5,$t5,6		#�����O0 �~��+6 �i�����
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
	
SuForIni:	add $t5,$t5,5		# t5��l��5  �]��5�H�e�����p�e�����Ҽ{�F
	add $t9,$zero,$zero	#t9 = 0
	
SuFdSqrt:	add $t9,$t9,1
	mul $t6,$t9,$t9		#t9 = t1�}�ڸ�
	slt $t3,$t6,$t1		# t6 < t1  t3 = 1    t6 >=t1  t3 =0
	beq $t3,1,SuFdSqrt	#�٨S�}���~��

	mul  $t2,$t9,$t9	#if t1 �O����ƴN���^�h��
	beq  $t2,$t1,t1_sub	
	sub $t9,$t9,1		#���O����� t9= t9-1  ��floor


SuForCo:	slt $t7,$t9,$t5		# t9 < t5  t7 = 1    t9 >=t5  t7 =0
	beq $t7,1,return_2	#�N������
	beq $t7,0,subispr	#�٨S���է��~���
	
subispr:	div  $t2,$t1,$t5	#t2 = t1 % t5
	mfhi $t2
	beq  $t2,0,t1_sub 	#�l�ƬO0 �N��D���  �A�^�h-1
	add  $t8,$t5,2 		#t8 = t5 +2  �]���u�P�_�_��
	div  $t2,$t1,$t8	#t2 = t1 % t5
	mfhi $t2
	beq  $t2,0,t1_sub	#�l�ƬO0 �N��D���  �A�^�h-1
	add $t5,$t5,6		#�����O0 �~��+6 �i�����
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
		


