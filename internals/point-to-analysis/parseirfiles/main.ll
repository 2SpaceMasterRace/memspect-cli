	.text
	.file	"main.c"
	.globl	main                    # -- Begin function main
	.p2align	4, 0x90
	.type	main,@function
main:                                   # @main
	.cfi_startproc
# %bb.0:
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset %rbp, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register %rbp
	xorl	%eax, %eax
	movl	$0, -4(%rbp)
	leaq	-20(%rbp), %rcx
	movq	%rcx, -16(%rbp)
	movq	-32(%rbp), %rdx
	movq	%rdx, -16(%rbp)
	movq	-40(%rbp), %rdx
	movq	(%rdx), %rdx
	movq	%rdx, -16(%rbp)
                                        # kill: def $ecx killed $ecx killed $rcx
	movq	-16(%rbp), %rdx
	movl	%ecx, (%rdx)
	movq	-32(%rbp), %rdx
                                        # kill: def $edx killed $edx killed $rdx
	movq	-16(%rbp), %rsi
	movl	%edx, (%rsi)
	movq	-40(%rbp), %rsi
	movq	(%rsi), %rsi
                                        # kill: def $esi killed $esi killed $rsi
	movq	-16(%rbp), %rdi
	movl	%esi, (%rdi)
	popq	%rbp
	.cfi_def_cfa %rsp, 8
	retq
.Lfunc_end0:
	.size	main, .Lfunc_end0-main
	.cfi_endproc
                                        # -- End function
	.ident	"clang version 10.0.0-4ubuntu1 "
	.section	".note.GNU-stack","",@progbits
	.addrsig
