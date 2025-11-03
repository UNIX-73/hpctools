	.file	"dgesv.c"
	.text
	.section	.rodata.str1.8,"aMS",@progbits,1
	.align 8
.LC3:
	.string	"ERR: Almost null pivot in col %ld\n"
	.text
	.p2align 4,,15
	.globl	my_dgesv
	.type	my_dgesv, @function
my_dgesv:
.LFB29:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	andq	$-64, %rsp
	subq	$384, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 13, -40
	.cfi_offset 12, -48
	.cfi_offset 3, -56
	movq	%rdx, 344(%rsp)
	testq	%rdi, %rdi
	je	.L40
	movq	%rdi, %r15
	movq	%rsi, %r10
	movq	%rsi, %r13
	movq	%rdx, %r12
	leaq	8(,%rdi,8), %rax
	leaq	-8(%r15), %rbx
	movq	%rdx, 328(%rsp)
	vmovq	.LC1(%rip), %xmm4
	movq	%rax, 96(%rsp)
	subq	$8, %rax
	shrq	$3, %r10
	leaq	0(,%rsi,8), %rdi
	movq	%rax, 368(%rsp)
	movq	%r15, %rax
	movq	%rcx, %r11
	vmovsd	.LC2(%rip), %xmm5
	shrq	$3, %rax
	movq	%rbx, 112(%rsp)
	movq	%r10, %r14
	movq	%rax, 88(%rsp)
	movq	%r15, %rax
	andq	$-8, %rax
	movq	%rdi, 360(%rsp)
	leaq	-1(%r15), %rdi
	movq	%rdi, 304(%rsp)
	leaq	2(%rax), %rdi
	leaq	1(%rax), %rbx
	movq	%rdi, 56(%rsp)
	leaq	4(%rax), %rdi
	movq	%rdi, 40(%rsp)
	leaq	6(%rax), %rdi
	movq	%rbx, 72(%rsp)
	leaq	3(%rax), %rbx
	movq	%rdi, 24(%rsp)
	movq	%rsi, %rdi
	leaq	-1(%rsi), %rsi
	andq	$-8, %rdi
	movq	%rbx, 48(%rsp)
	leaq	5(%rax), %rbx
	movq	%rbx, 32(%rsp)
	leaq	1(%rdi), %rbx
	movq	%rbx, 216(%rsp)
	leaq	2(%rdi), %rbx
	movq	%rbx, 200(%rsp)
	leaq	3(%rdi), %rbx
	movq	%rbx, 176(%rsp)
	leaq	4(%rdi), %rbx
	movq	%rbx, 144(%rsp)
	leaq	5(%rdi), %rbx
	movq	%rbx, 136(%rsp)
	leaq	6(%rdi), %rbx
	movq	%rax, 80(%rsp)
	salq	$3, %rax
	movq	%rdi, 240(%rsp)
	salq	$3, %rdi
	movq	%rbx, 128(%rsp)
	xorl	%ebx, %ebx
	movq	%r15, 288(%rsp)
	movq	$0, 120(%rsp)
	movq	$64, 320(%rsp)
	movq	$0, 352(%rsp)
	movq	$0, 336(%rsp)
	movq	$64, 312(%rsp)
	movq	%rsi, 272(%rsp)
	movq	%rdi, 248(%rsp)
	movq	%rax, 64(%rsp)
	movq	%rbx, 224(%rsp)
	movq	%rcx, 296(%rsp)
	.p2align 4,,10
	.p2align 3
.L25:
	vmovsd	(%r12), %xmm3
	movq	224(%rsp), %rcx
	movq	344(%rsp), %rax
	addq	120(%rsp), %rax
	movq	%rax, 160(%rsp)
	vmovapd	%xmm3, %xmm2
	leaq	1(%rcx), %rax
	vandpd	%xmm4, %xmm2, %xmm2
	movq	%rax, 184(%rsp)
	cmpq	%rax, %r15
	jbe	.L4
	movq	368(%rsp), %r8
	vmovapd	%xmm2, %xmm1
	leaq	(%r12,%r8), %rdi
	jmp	.L7
	.p2align 4,,10
	.p2align 3
.L41:
	movq	%rdx, %rax
.L7:
	vmovsd	(%rdi), %xmm0
	movq	%rcx, %rsi
	leaq	1(%rax), %rdx
	vandpd	%xmm4, %xmm0, %xmm0
	vcomisd	%xmm1, %xmm0
	vmaxsd	%xmm1, %xmm0, %xmm1
	cmova	%rax, %rsi
	addq	%r8, %rdi
	movq	%rsi, %rcx
	cmpq	%rdx, %r15
	jne	.L41
	cmpq	%rsi, 224(%rsp)
	jne	.L96
.L4:
	vcomisd	%xmm2, %xmm5
	ja	.L16
.L98:
	cmpq	184(%rsp), %r15
	je	.L97
	movq	112(%rsp), %r8
	movq	160(%rsp), %r10
	movq	360(%rsp), %r9
	addq	336(%rsp), %r9
	shrq	$3, %r8
	movq	%r9, 104(%rsp)
	movq	352(%rsp), %rdi
	addq	$1, %r8
	addq	368(%rsp), %rdi
	leaq	0(,%r8,8), %rax
	movq	%rax, %rbx
	movq	%rax, 280(%rsp)
	movq	224(%rsp), %rax
	addq	%rbx, %rax
	leaq	1(%rax), %rbx
	movq	%rbx, 264(%rsp)
	leaq	2(%rax), %rbx
	movq	%rbx, 232(%rsp)
	leaq	3(%rax), %rbx
	movq	%rbx, 208(%rsp)
	leaq	4(%rax), %rbx
	movq	%rbx, 192(%rsp)
	leaq	5(%rax), %rbx
	movq	%rbx, 168(%rsp)
	leaq	6(%rax), %rbx
	salq	$3, %rax
	movq	%rbx, 152(%rsp)
	addq	%rax, %r10
	movq	184(%rsp), %rbx
	movq	%rax, 256(%rsp)
	movq	248(%rsp), %rax
	movq	%rbx, 376(%rsp)
	leaq	(%r11,%rax), %rbx
	.p2align 4,,10
	.p2align 3
.L24:
	movq	328(%rsp), %rax
	movq	344(%rsp), %rsi
	leaq	(%rdi,%rax), %rcx
	leaq	64(%rdi), %rax
	cmpq	352(%rsp), %rax
	vmovsd	(%rsi,%rdi), %xmm0
	setle	%dl
	cmpq	320(%rsp), %rdi
	vdivsd	%xmm3, %xmm0, %xmm0
	setge	%al
	orb	%al, %dl
	je	.L45
	cmpq	$6, 304(%rsp)
	jbe	.L45
	vbroadcastsd	%xmm0, %zmm2
	addq	%rdi, %rsi
	xorl	%eax, %eax
	xorl	%edx, %edx
	.p2align 4,,10
	.p2align 3
.L20:
	vmovupd	(%r12,%rax), %zmm1
	vfnmadd213pd	(%rsi,%rax), %zmm2, %zmm1
	addq	$1, %rdx
	vmovupd	%zmm1, (%rsi,%rax)
	addq	$64, %rax
	cmpq	%rdx, %r8
	ja	.L20
	movq	288(%rsp), %rsi
	cmpq	%rsi, 280(%rsp)
	je	.L22
	addq	256(%rsp), %rcx
	vmovsd	(%r10), %xmm1
	vfnmadd213sd	(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, (%rcx)
	cmpq	264(%rsp), %r15
	jbe	.L22
	vmovsd	8(%r10), %xmm1
	vfnmadd213sd	8(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, 8(%rcx)
	cmpq	232(%rsp), %r15
	jbe	.L22
	vmovsd	16(%r10), %xmm1
	vfnmadd213sd	16(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, 16(%rcx)
	cmpq	208(%rsp), %r15
	jbe	.L22
	vmovsd	24(%r10), %xmm1
	vfnmadd213sd	24(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, 24(%rcx)
	cmpq	192(%rsp), %r15
	jbe	.L22
	vmovsd	32(%r10), %xmm1
	vfnmadd213sd	32(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, 32(%rcx)
	cmpq	168(%rsp), %r15
	jbe	.L22
	vmovsd	40(%r10), %xmm1
	vfnmadd213sd	40(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, 40(%rcx)
	cmpq	152(%rsp), %r15
	jbe	.L22
	vmovsd	48(%r10), %xmm1
	vfnmadd213sd	48(%rcx), %xmm0, %xmm1
	vmovsd	%xmm1, 48(%rcx)
.L22:
	testq	%r13, %r13
	je	.L29
	movq	296(%rsp), %rax
	leaq	(%rax,%r9), %rdx
	leaq	64(%r9), %rax
	cmpq	336(%rsp), %rax
	setle	%cl
	cmpq	312(%rsp), %r9
	setge	%al
	orb	%al, %cl
	je	.L46
	cmpq	$6, 272(%rsp)
	jbe	.L46
	vbroadcastsd	%xmm0, %zmm2
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L27:
	vmovupd	(%r11,%rax), %zmm1
	vfnmadd213pd	(%rdx,%rax), %zmm2, %zmm1
	addq	$1, %rcx
	vmovupd	%zmm1, (%rdx,%rax)
	addq	$64, %rax
	cmpq	%r14, %rcx
	jne	.L27
	cmpq	240(%rsp), %r13
	je	.L29
	addq	248(%rsp), %rdx
	vmovsd	(%rbx), %xmm1
	vfnmadd213sd	(%rdx), %xmm0, %xmm1
	vmovsd	%xmm1, (%rdx)
	cmpq	216(%rsp), %r13
	jbe	.L29
	vmovsd	8(%rbx), %xmm1
	vfnmadd213sd	8(%rdx), %xmm0, %xmm1
	vmovsd	%xmm1, 8(%rdx)
	cmpq	200(%rsp), %r13
	jbe	.L29
	vmovsd	16(%rbx), %xmm1
	vfnmadd213sd	16(%rdx), %xmm0, %xmm1
	vmovsd	%xmm1, 16(%rdx)
	cmpq	176(%rsp), %r13
	jbe	.L29
	vmovsd	24(%rbx), %xmm1
	vfnmadd213sd	24(%rdx), %xmm0, %xmm1
	vmovsd	%xmm1, 24(%rdx)
	cmpq	144(%rsp), %r13
	jbe	.L29
	vmovsd	32(%rbx), %xmm1
	vfnmadd213sd	32(%rdx), %xmm0, %xmm1
	vmovsd	%xmm1, 32(%rdx)
	cmpq	136(%rsp), %r13
	jbe	.L29
	vmovsd	40(%rbx), %xmm1
	vfnmadd213sd	40(%rdx), %xmm0, %xmm1
	vmovsd	%xmm1, 40(%rdx)
	cmpq	128(%rsp), %r13
	jbe	.L29
	vmovsd	48(%rdx), %xmm7
	vfnmadd132sd	48(%rbx), %xmm7, %xmm0
	vmovsd	%xmm0, 48(%rdx)
.L29:
	addq	368(%rsp), %rdi
	addq	360(%rsp), %r9
	addq	$1, 376(%rsp)
	movq	376(%rsp), %rax
	cmpq	%rax, %r15
	jne	.L24
	movq	96(%rsp), %rax
	addq	%rax, 352(%rsp)
	addq	%rax, 320(%rsp)
	movq	360(%rsp), %rbx
	addq	%rax, %r12
	subq	$1, 112(%rsp)
	movq	184(%rsp), %rax
	addq	%rbx, %r11
	addq	%rbx, 312(%rsp)
	movq	368(%rsp), %rbx
	movq	%rax, 224(%rsp)
	movq	104(%rsp), %rax
	subq	$1, 288(%rsp)
	subq	$8, 328(%rsp)
	subq	$1, 304(%rsp)
	addq	%rbx, 120(%rsp)
	movq	%rax, 336(%rsp)
	jmp	.L25
	.p2align 4,,10
	.p2align 3
.L45:
	movq	224(%rsp), %rax
	movq	160(%rsp), %rdx
	.p2align 4,,10
	.p2align 3
.L19:
	vmovsd	(%rdx,%rax,8), %xmm1
	vfnmadd213sd	(%rcx,%rax,8), %xmm0, %xmm1
	vmovsd	%xmm1, (%rcx,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %r15
	jne	.L19
	jmp	.L22
	.p2align 4,,10
	.p2align 3
.L46:
	xorl	%eax, %eax
	.p2align 4,,10
	.p2align 3
.L26:
	vmovsd	(%r11,%rax,8), %xmm1
	vfnmadd213sd	(%rdx,%rax,8), %xmm0, %xmm1
	vmovsd	%xmm1, (%rdx,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %r13
	jne	.L26
	jmp	.L29
.L96:
	imulq	%r15, %rcx
	movq	344(%rsp), %rbx
	salq	$3, %rcx
	leaq	(%rbx,%rcx), %rdi
	movq	120(%rsp), %rbx
	leaq	64(%rcx), %r8
	cmpq	%rbx, %r8
	leaq	64(%rbx), %r9
	setle	%r8b
	cmpq	%r9, %rcx
	setge	%cl
	orb	%cl, %r8b
	je	.L42
	cmpq	$6, %rax
	jbe	.L42
	movq	88(%rsp), %r9
	movq	160(%rsp), %r8
	xorl	%eax, %eax
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L9:
	vmovupd	(%r8,%rax), %zmm0
	vmovupd	(%rdi,%rax), %zmm16
	addq	$1, %rcx
	vmovupd	%zmm16, (%r8,%rax)
	vmovupd	%zmm0, (%rdi,%rax)
	addq	$64, %rax
	cmpq	%rcx, %r9
	jne	.L9
	cmpq	80(%rsp), %rdx
	je	.L11
	movq	64(%rsp), %rbx
	movq	160(%rsp), %rax
	addq	%rbx, %rdi
	addq	%rbx, %rax
	vmovsd	(%rax), %xmm0
	vmovsd	(%rdi), %xmm1
	vmovsd	%xmm1, (%rax)
	vmovsd	%xmm0, (%rdi)
	cmpq	72(%rsp), %rdx
	jbe	.L11
	vmovsd	8(%rax), %xmm0
	vmovsd	8(%rdi), %xmm1
	vmovsd	%xmm1, 8(%rax)
	vmovsd	%xmm0, 8(%rdi)
	cmpq	56(%rsp), %rdx
	jbe	.L11
	vmovsd	16(%rax), %xmm0
	vmovsd	16(%rdi), %xmm1
	vmovsd	%xmm1, 16(%rax)
	vmovsd	%xmm0, 16(%rdi)
	cmpq	48(%rsp), %rdx
	jbe	.L11
	vmovsd	24(%rax), %xmm0
	vmovsd	24(%rdi), %xmm1
	vmovsd	%xmm1, 24(%rax)
	vmovsd	%xmm0, 24(%rdi)
	cmpq	40(%rsp), %rdx
	jbe	.L11
	vmovsd	32(%rax), %xmm0
	vmovsd	32(%rdi), %xmm1
	vmovsd	%xmm1, 32(%rax)
	vmovsd	%xmm0, 32(%rdi)
	cmpq	32(%rsp), %rdx
	jbe	.L11
	vmovsd	40(%rax), %xmm0
	vmovsd	40(%rdi), %xmm1
	vmovsd	%xmm1, 40(%rax)
	vmovsd	%xmm0, 40(%rdi)
	cmpq	24(%rsp), %rdx
	jbe	.L11
	vmovsd	48(%rax), %xmm0
	vmovsd	48(%rdi), %xmm1
	vmovsd	%xmm1, 48(%rax)
	vmovsd	%xmm0, 48(%rdi)
.L11:
	vmovsd	(%r12), %xmm3
	vmovapd	%xmm3, %xmm2
	vandpd	%xmm4, %xmm2, %xmm2
	testq	%r13, %r13
	je	.L4
	imulq	%r13, %rsi
	movq	296(%rsp), %rbx
	leaq	0(,%rsi,8), %rax
	leaq	64(%rax), %rcx
	cmpq	336(%rsp), %rcx
	leaq	(%rbx,%rax), %rdx
	setle	%cl
	cmpq	312(%rsp), %rax
	setge	%al
	orb	%al, %cl
	movl	$0, %eax
	je	.L12
	cmpq	$6, 272(%rsp)
	jbe	.L12
	xorl	%ecx, %ecx
	.p2align 4,,10
	.p2align 3
.L13:
	vmovupd	(%r11,%rax), %zmm0
	vmovupd	(%rdx,%rax), %zmm17
	addq	$1, %rcx
	vmovupd	%zmm17, (%r11,%rax)
	vmovupd	%zmm0, (%rdx,%rax)
	addq	$64, %rax
	cmpq	%rcx, %r14
	jne	.L13
	cmpq	240(%rsp), %r13
	je	.L4
	movq	248(%rsp), %rbx
	leaq	(%r11,%rbx), %rax
	addq	%rbx, %rdx
	vmovsd	(%rax), %xmm0
	vmovsd	(%rdx), %xmm1
	vmovsd	%xmm1, (%rax)
	vmovsd	%xmm0, (%rdx)
	cmpq	216(%rsp), %r13
	jbe	.L4
	vmovsd	8(%rax), %xmm0
	vmovsd	8(%rdx), %xmm1
	vmovsd	%xmm1, 8(%rax)
	vmovsd	%xmm0, 8(%rdx)
	cmpq	200(%rsp), %r13
	jbe	.L4
	vmovsd	16(%rax), %xmm0
	vmovsd	16(%rdx), %xmm1
	vmovsd	%xmm1, 16(%rax)
	vmovsd	%xmm0, 16(%rdx)
	cmpq	176(%rsp), %r13
	jbe	.L4
	vmovsd	24(%rax), %xmm0
	vmovsd	24(%rdx), %xmm1
	vmovsd	%xmm1, 24(%rax)
	vmovsd	%xmm0, 24(%rdx)
	cmpq	144(%rsp), %r13
	jbe	.L4
	vmovsd	32(%rax), %xmm0
	vmovsd	32(%rdx), %xmm1
	vmovsd	%xmm1, 32(%rax)
	vmovsd	%xmm0, 32(%rdx)
	cmpq	136(%rsp), %r13
	jbe	.L4
	vmovsd	40(%rax), %xmm0
	vmovsd	40(%rdx), %xmm1
	vmovsd	%xmm1, 40(%rax)
	vmovsd	%xmm0, 40(%rdx)
	cmpq	128(%rsp), %r13
	jbe	.L4
	vcomisd	%xmm2, %xmm5
	vmovsd	48(%rax), %xmm0
	vmovsd	48(%rdx), %xmm1
	vmovsd	%xmm1, 48(%rax)
	vmovsd	%xmm0, 48(%rdx)
	jbe	.L98
.L16:
	movq	224(%rsp), %rbx
	movq	stderr(%rip), %rsi
	leaq	.LC3(%rip), %rdx
	xorl	%eax, %eax
	movl	$1, %edi
	movq	%rbx, %rcx
	vzeroupper
	call	__printf_chk@PLT
	leaq	-40(%rbp), %rsp
	movl	$-1, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_remember_state
	.cfi_def_cfa 7, 8
	ret
	.p2align 4,,10
	.p2align 3
.L12:
	.cfi_restore_state
	vmovsd	(%r11,%rax,8), %xmm0
	vmovsd	(%rdx,%rax,8), %xmm1
	vmovsd	%xmm1, (%r11,%rax,8)
	vmovsd	%xmm0, (%rdx,%rax,8)
	addq	$1, %rax
	cmpq	%rax, %r13
	jne	.L12
	jmp	.L4
.L97:
	movq	224(%rsp), %rbx
	movq	296(%rsp), %r14
	testq	%r13, %r13
	je	.L92
	movq	184(%rsp), %rsi
	movq	344(%rsp), %r10
	leaq	2(%rbx), %rax
	movq	%r13, %r9
	negq	%rax
	negq	%r9
	movq	%r13, 368(%rsp)
	movq	360(%rsp), %r8
	movq	%rsi, %rdx
	leaq	0(,%rax,8), %rcx
	movq	$0, 344(%rsp)
	movq	344(%rsp), %r12
	imulq	%rsi, %rdx
	movq	%rcx, 320(%rsp)
	addq	$8, %rcx
	leaq	0(,%r9,8), %rdi
	movq	%rcx, 328(%rsp)
	salq	$4, %r9
	salq	$3, %rdx
	leaq	-8(%r10,%rdx), %rax
	leaq	-16(%r10,%rdx), %rcx
	movq	%rax, 336(%rsp)
	movq	96(%rsp), %rax
	movq	%rcx, 376(%rsp)
	subq	$16, %rax
	movq	%rax, %r11
	imulq	%rsi, %rax
	imulq	%r13, %r11
	subq	%rdx, %rax
	addq	%r14, %r11
	addq	$16, %rax
	movq	%r11, 352(%rsp)
	movq	%rax, 312(%rsp)
.L36:
	movq	336(%rsp), %rax
	movq	312(%rsp), %rsi
	addq	376(%rsp), %rsi
	vmovsd	(%rax), %xmm3
	movq	184(%rsp), %rax
	cmpq	%r12, %rax
	cmovbe	%rax, %r12
	xorl	%ecx, %ecx
	movq	%r12, %r10
	movq	%r12, %r13
	shrq	%r10
	andq	$-2, %r13
	.p2align 4,,10
	.p2align 3
.L32:
	vpxor	%xmm1, %xmm1, %xmm1
	testq	%r12, %r12
	je	.L39
	cmpq	$1, %r12
	je	.L47
	movq	352(%rsp), %rax
	movq	376(%rsp), %r15
	xorl	%edx, %edx
	vpxor	%xmm1, %xmm1, %xmm1
	leaq	(%rax,%rcx,8), %rax
	.p2align 4,,10
	.p2align 3
.L34:
	vmovsd	(%rax), %xmm0
	vpermilpd	$1, (%r15), %xmm2
	addq	$1, %rdx
	subq	$16, %r15
	vmovhpd	(%rax,%rdi), %xmm0, %xmm0
	addq	%r9, %rax
	vmulpd	%xmm2, %xmm0, %xmm0
	vaddsd	%xmm1, %xmm0, %xmm1
	vunpckhpd	%xmm0, %xmm0, %xmm0
	vaddsd	%xmm1, %xmm0, %xmm1
	cmpq	%rdx, %r10
	jne	.L34
	movq	%r13, %rax
	cmpq	%r13, %r12
	je	.L39
.L33:
	movq	%rbx, %rdx
	leaq	(%r14,%rcx,8), %r15
	subq	%rax, %rdx
	movq	%rdx, %rax
	imulq	%r8, %rdx
	vmovsd	(%r15,%rdx), %xmm6
	vfmadd231sd	(%rsi,%rax,8), %xmm6, %xmm1
.L39:
	vmovsd	(%r11,%rcx,8), %xmm0
	vsubsd	%xmm1, %xmm0, %xmm0
	vdivsd	%xmm3, %xmm0, %xmm0
	vmovsd	%xmm0, (%r11,%rcx,8)
	addq	$1, %rcx
	cmpq	%rcx, 368(%rsp)
	jne	.L32
	movq	344(%rsp), %rsi
	movq	320(%rsp), %rdx
	addq	%rdi, %r11
	addq	%rdx, 336(%rsp)
	movq	328(%rsp), %rdx
	leaq	1(%rsi), %rax
	addq	%rdx, 376(%rsp)
	cmpq	%rbx, %rsi
	je	.L92
	movq	%rax, 344(%rsp)
	movq	%rax, %r12
	jmp	.L36
.L47:
	vpxor	%xmm1, %xmm1, %xmm1
	xorl	%eax, %eax
	jmp	.L33
.L42:
	xorl	%edx, %edx
	movq	160(%rsp), %rcx
	jmp	.L8
.L43:
	movq	%r8, %rdx
.L8:
	vmovsd	(%rcx,%rdx,8), %xmm0
	vmovsd	(%rdi,%rdx,8), %xmm1
	leaq	1(%rdx), %r8
	vmovsd	%xmm1, (%rcx,%rdx,8)
	vmovsd	%xmm0, (%rdi,%rdx,8)
	cmpq	%rdx, %rax
	jne	.L43
	jmp	.L11
.L92:
	vzeroupper
.L40:
	leaq	-40(%rbp), %rsp
	xorl	%eax, %eax
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE29:
	.size	my_dgesv, .-my_dgesv
	.section	.rodata.cst16,"aM",@progbits,16
	.align 16
.LC1:
	.long	4294967295
	.long	2147483647
	.long	0
	.long	0
	.section	.rodata.cst8,"aM",@progbits,8
	.align 8
.LC2:
	.long	3654794683
	.long	1037794527
	.ident	"GCC: (Gentoo 8.4.0-r1 p2) 8.4.0"
	.section	.note.GNU-stack,"",@progbits
