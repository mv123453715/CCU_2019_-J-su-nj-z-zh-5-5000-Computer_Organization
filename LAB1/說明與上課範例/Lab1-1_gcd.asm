.data
msgb:.asciiz"The GCD is:"
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
comp:	slt $t0,$t1,$t2		#�P�_t1<t2 ����t1=1 else t1=0
	beq $t0,$zero,subb	#�p�G�۵�����subb(����)
	add $t3,$t1,$zero
	add $t1,$t2,$zero
	add $t2,$t3,$zero
subb:	sub $t1,$t1,$t2
	bne $t1,$zero,comp
	#��̤ܳj���]�� 
	li $v0,4
	la $a0,msgb
	syscall
	add $a0,$zero $t2
	li $v0,1
	syscall
	li $v0,10
	syscall
