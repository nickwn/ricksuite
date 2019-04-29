#!/bin/sh

~/ricksuite/rickme.sh "$1.s"

printf "
@ Raspberry Pi directives
 	.cpu    cortex-a53
	.syntax unified

	.equ    FP_OFFSET, 4

@ Constants for local variables
	.equ LOCAL_VAR_SPACE, <# local vars>
	#.equ <*_OFFSET>

@ Constants for parameters
	.equ PARAM_SPACE, <# parameters>
	#.equ <*_OFFSET>

@ General constants
	.equ HALF_DIVISOR, 2
	.equ DOUBLE, 2

	.global $1

	.text   
	.align  2

$1:
@ Standard prologue
	push	{fp, lr}
	add	fp, sp, FP_OFFSET

	@ <method signature>
	@ allocate space on stack for local vars
	sub 	sp, LOCAL_VAR_SPACE
	
	@ allocate space for formal parameters
	sub	sp, PARAM_SPACE
	#str	r0, [fp, *_OFFSET}

	# <method body>

@ Standard epilogue
	sub	sp, fp, FP_OFFSET
	pop	{fp, pc}
" >> "$1.s"
