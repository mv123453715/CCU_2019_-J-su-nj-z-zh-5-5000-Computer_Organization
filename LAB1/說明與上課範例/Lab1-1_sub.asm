.data
sub_result:.asciiz"The sub result is:"
inputa:.asciiz "The first number="
inputb:.asciiz "The second number="
.text
.globl main
main:
	#$a0-$a3=�޼�(argument)�Ȧs��
	#$v0-$v1=�ƭ�(value)�Ȧs��
	#$t0-t9=���(integer)�Ȧs��
	
	#��J��۵M�ƨD�̤j���]��
	#Ū�Ĥ@�Ӽƨ�t1
	li $v0,4	        # load syscall code (4 : print string) 
	la $a0,inputa 		# load address of string to be printed into $a0 
	syscall			# print str 
	li $v0,5		# load syscall code (5 : read int)
	syscall			# read int 
	add $t1,$zero,$v0
	#Ū�ĤG�Ӽƨ�t2 
	li $v0,4
	la $a0,inputb
	syscall
	li $v0,5
	syscall
	add $t2,$zero,$v0
	#��� t1 t2 �j�p�A�Yt1�j�h����k�A�Yt1���p�h�Pt2����� 
subb:	sub $t1,$t1,$t2
	#��̤ܳj���]�� 
	li $v0,4
	la $a0,sub_result #load address of string to be printed into $a0 
	syscall
	add $a0,$zero $t1 # a0 = 0+ t1
	li $v0,1  #���ܱN v0 �Ȧs�����ƭȳ]�w�� 1 print integer
	syscall
	li $v0,10  #exit (terminate execution)
	syscall
