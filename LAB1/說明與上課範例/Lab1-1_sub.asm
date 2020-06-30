.data
sub_result:.asciiz"The sub result is:"
inputa:.asciiz "The first number="
inputb:.asciiz "The second number="
.text
.globl main
main:
	#$a0-$a3=引數(argument)暫存器
	#$v0-$v1=數值(value)暫存器
	#$t0-t9=整數(integer)暫存器
	
	#輸入兩自然數求最大公因數
	#讀第一個數到t1
	li $v0,4	        # load syscall code (4 : print string) 
	la $a0,inputa 		# load address of string to be printed into $a0 
	syscall			# print str 
	li $v0,5		# load syscall code (5 : read int)
	syscall			# read int 
	add $t1,$zero,$v0
	#讀第二個數到t2 
	li $v0,4
	la $a0,inputb
	syscall
	li $v0,5
	syscall
	add $t2,$zero,$v0
	#比對 t1 t2 大小，若t1大則做減法，若t1較小則與t2做對調 
subb:	sub $t1,$t1,$t2
	#顯示最大公因數 
	li $v0,4
	la $a0,sub_result #load address of string to be printed into $a0 
	syscall
	add $a0,$zero $t1 # a0 = 0+ t1
	li $v0,1  #指示將 v0 暫存器的數值設定為 1 print integer
	syscall
	li $v0,10  #exit (terminate execution)
	syscall
