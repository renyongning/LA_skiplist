	.file	"main.cpp"
	.text
	.section	.text._ZSt23__is_constant_evaluatedv,"axG",@progbits,_ZSt23__is_constant_evaluatedv,comdat
	.weak	_ZSt23__is_constant_evaluatedv
	.type	_ZSt23__is_constant_evaluatedv, @function
_ZSt23__is_constant_evaluatedv:
.LFB1:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$0, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE1:
	.size	_ZSt23__is_constant_evaluatedv, .-_ZSt23__is_constant_evaluatedv
	.section	.text._ZnwmPv,"axG",@progbits,_ZnwmPv,comdat
	.weak	_ZnwmPv
	.type	_ZnwmPv, @function
_ZnwmPv:
.LFB40:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE40:
	.size	_ZnwmPv, .-_ZnwmPv
	.section	.text._ZNSt11char_traitsIcE6lengthEPKc,"axG",@progbits,_ZNSt11char_traitsIcE6lengthEPKc,comdat
	.weak	_ZNSt11char_traitsIcE6lengthEPKc
	.type	_ZNSt11char_traitsIcE6lengthEPKc, @function
_ZNSt11char_traitsIcE6lengthEPKc:
.LFB115:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	call	_ZSt23__is_constant_evaluatedv
	testb	%al, %al
	je	.L6
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc
	jmp	.L7
.L6:
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	nop
.L7:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE115:
	.size	_ZNSt11char_traitsIcE6lengthEPKc, .-_ZNSt11char_traitsIcE6lengthEPKc
	.text
	.type	_ZL18__gthread_active_pv, @function
_ZL18__gthread_active_pv:
.LFB177:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	$1, %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE177:
	.size	_ZL18__gthread_active_pv, .-_ZL18__gthread_active_pv
	.section	.text._ZL20__gthread_mutex_lockP15pthread_mutex_t,"axG",@progbits,_ZNSt5mutex4lockEv,comdat
	.type	_ZL20__gthread_mutex_lockP15pthread_mutex_t, @function
_ZL20__gthread_mutex_lockP15pthread_mutex_t:
.LFB191:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	call	_ZL18__gthread_active_pv
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L11
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	pthread_mutex_lock@PLT
	jmp	.L12
.L11:
	movl	$0, %eax
.L12:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE191:
	.size	_ZL20__gthread_mutex_lockP15pthread_mutex_t, .-_ZL20__gthread_mutex_lockP15pthread_mutex_t
	.section	.text._ZL22__gthread_mutex_unlockP15pthread_mutex_t,"axG",@progbits,_ZNSt5mutex6unlockEv,comdat
	.type	_ZL22__gthread_mutex_unlockP15pthread_mutex_t, @function
_ZL22__gthread_mutex_unlockP15pthread_mutex_t:
.LFB194:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	call	_ZL18__gthread_active_pv
	testl	%eax, %eax
	setne	%al
	testb	%al, %al
	je	.L14
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	pthread_mutex_unlock@PLT
	jmp	.L15
.L14:
	movl	$0, %eax
.L15:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE194:
	.size	_ZL22__gthread_mutex_unlockP15pthread_mutex_t, .-_ZL22__gthread_mutex_unlockP15pthread_mutex_t
#APP
	.globl _ZSt21ios_base_library_initv
#NO_APP
	.section	.text._ZNSt5mutex4lockEv,"axG",@progbits,_ZNSt5mutex4lockEv,comdat
	.align 2
	.weak	_ZNSt5mutex4lockEv
	.type	_ZNSt5mutex4lockEv, @function
_ZNSt5mutex4lockEv:
.LFB2684:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZL20__gthread_mutex_lockP15pthread_mutex_t
	movl	%eax, -4(%rbp)
	cmpl	$0, -4(%rbp)
	je	.L18
	movl	-4(%rbp), %eax
	movl	%eax, %edi
	call	_ZSt20__throw_system_errori@PLT
.L18:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2684:
	.size	_ZNSt5mutex4lockEv, .-_ZNSt5mutex4lockEv
	.section	.text._ZNSt5mutex6unlockEv,"axG",@progbits,_ZNSt5mutex6unlockEv,comdat
	.align 2
	.weak	_ZNSt5mutex6unlockEv
	.type	_ZNSt5mutex6unlockEv, @function
_ZNSt5mutex6unlockEv:
.LFB2686:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZL22__gthread_mutex_unlockP15pthread_mutex_t
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE2686:
	.size	_ZNSt5mutex6unlockEv, .-_ZNSt5mutex6unlockEv
	.globl	mtx
	.bss
	.align 32
	.type	mtx, @object
	.size	mtx, 40
mtx:
	.zero	40
	.globl	_Z9delimiterB5cxx11
	.align 32
	.type	_Z9delimiterB5cxx11, @object
	.size	_Z9delimiterB5cxx11, 32
_Z9delimiterB5cxx11:
	.zero	32
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev:
.LFB3303:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3303:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD1Ev
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD1Ev,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD2Ev
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev:
.LFB3305:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC1Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3305:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC1Ev
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC1Ev,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC5Ev,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev:
.LFB3307:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3307:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC1Ev
	.set	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC1Ev,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2Ev
	.section	.rodata
.LC2:
	.string	"finish"
	.text
	.globl	main
	.type	main, @function
main:
.LFB3298:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3298
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$1192, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	-1088(%rbp), %rax
	movl	$31, %esi
	movq	%rax, %rdi
.LEHB0:
	call	_ZN8SkipListIiiEC1Ei
.LEHE0:
	leaq	-1152(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC1Ev
	movl	$0, -1188(%rbp)
	jmp	.L24
.L25:
	movsd	.LC0(%rip), %xmm0
	movsd	%xmm0, -1176(%rbp)
	leaq	-1188(%rbp), %rdx
	leaq	-1188(%rbp), %rcx
	leaq	-1160(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt4pairIiiEC1IRiS2_Lb1EEEOT_OT0_
	leaq	-1176(%rbp), %rdx
	leaq	-1160(%rbp), %rcx
	leaq	-1120(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt4pairIS_IiiEdEC1IS0_dLb1EEEOT_OT0_
	leaq	-1120(%rbp), %rdx
	leaq	-1152(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB1:
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_
	movl	-1188(%rbp), %eax
	addl	$1, %eax
	movl	%eax, -1188(%rbp)
.L24:
	movl	-1188(%rbp), %eax
	cmpl	$9999, %eax
	jle	.L25
	leaq	-1152(%rbp), %rdx
	leaq	-1120(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC1ERKS4_
.LEHE1:
	leaq	-1120(%rbp), %rdx
	leaq	-1088(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB2:
	call	_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE
.LEHE2:
	leaq	-1120(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED1Ev
	movl	$10001, -1184(%rbp)
	jmp	.L26
.L27:
	movq	.LC1(%rip), %rsi
	movl	-1184(%rbp), %edx
	movl	-1184(%rbp), %ecx
	leaq	-1088(%rbp), %rax
	movq	%rsi, %xmm0
	movl	%ecx, %esi
	movq	%rax, %rdi
.LEHB3:
	call	_ZN8SkipListIiiE6insertEiid
	addl	$1, -1184(%rbp)
.L26:
	cmpl	$19999, -1184(%rbp)
	jle	.L27
	movl	$0, -1180(%rbp)
	jmp	.L28
.L29:
	movl	-1180(%rbp), %edx
	leaq	-1088(%rbp), %rax
	movl	%edx, %esi
	movq	%rax, %rdi
	call	_ZN8SkipListIiiE6searchEi
	movq	%rax, -1168(%rbp)
	addl	$1, -1180(%rbp)
.L28:
	cmpl	$999, -1180(%rbp)
	jle	.L29
	leaq	.LC2(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
.LEHE3:
	leaq	-1152(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED1Ev
	leaq	-1088(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN8SkipListIiiED1Ev
	movl	$0, %eax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L34
	jmp	.L37
.L36:
	endbr64
	movq	%rax, %rbx
	leaq	-1120(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED1Ev
	jmp	.L32
.L35:
	endbr64
	movq	%rax, %rbx
.L32:
	leaq	-1152(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED1Ev
	leaq	-1088(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN8SkipListIiiED1Ev
	movq	%rbx, %rax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L33
	call	__stack_chk_fail@PLT
.L33:
	movq	%rax, %rdi
.LEHB4:
	call	_Unwind_Resume@PLT
.LEHE4:
.L37:
	call	__stack_chk_fail@PLT
.L34:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3298:
	.globl	__gxx_personality_v0
	.section	.gcc_except_table,"a",@progbits
.LLSDA3298:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3298-.LLSDACSB3298
.LLSDACSB3298:
	.uleb128 .LEHB0-.LFB3298
	.uleb128 .LEHE0-.LEHB0
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB1-.LFB3298
	.uleb128 .LEHE1-.LEHB1
	.uleb128 .L35-.LFB3298
	.uleb128 0
	.uleb128 .LEHB2-.LFB3298
	.uleb128 .LEHE2-.LEHB2
	.uleb128 .L36-.LFB3298
	.uleb128 0
	.uleb128 .LEHB3-.LFB3298
	.uleb128 .LEHE3-.LEHB3
	.uleb128 .L35-.LFB3298
	.uleb128 0
	.uleb128 .LEHB4-.LFB3298
	.uleb128 .LEHE4-.LEHB4
	.uleb128 0
	.uleb128 0
.LLSDACSE3298:
	.text
	.size	main, .-main
	.section	.text._ZN9__gnu_cxx11char_traitsIcE6lengthEPKc,"axG",@progbits,_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc,comdat
	.align 2
	.weak	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc
	.type	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc, @function
_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc:
.LFB3320:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	$0, -16(%rbp)
	jmp	.L39
.L40:
	addq	$1, -16(%rbp)
.L39:
	movb	$0, -17(%rbp)
	movq	-40(%rbp), %rdx
	movq	-16(%rbp), %rax
	addq	%rax, %rdx
	leaq	-17(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_
	xorl	$1, %eax
	testb	%al, %al
	jne	.L40
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L42
	call	__stack_chk_fail@PLT
.L42:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3320:
	.size	_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc, .-_ZN9__gnu_cxx11char_traitsIcE6lengthEPKc
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD5Ev,comdat
	.align 2
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev:
.LFB3429:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorIcED2Ev
	nop
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3429:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev
	.set	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD2Ev
	.section	.rodata
	.align 8
.LC3:
	.string	"basic_string: construction from null is not valid"
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.align 2
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_:
.LFB3670:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3670
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-40(%rbp), %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_local_dataEv@PLT
	movq	%rax, %rcx
	movq	-56(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movq	%rbx, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderC1EPcRKS3_@PLT
	cmpq	$0, -48(%rbp)
	jne	.L45
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
.LEHB5:
	call	_ZSt19__throw_logic_errorPKc@PLT
.L45:
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt11char_traitsIcE6lengthEPKc
	movq	-48(%rbp), %rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-48(%rbp), %rcx
	movq	-40(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag
.LEHE5:
	jmp	.L48
.L47:
	endbr64
	movq	%rax, %rbx
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_Alloc_hiderD1Ev
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB6:
	call	_Unwind_Resume@PLT
.LEHE6:
.L48:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3670:
	.section	.gcc_except_table
.LLSDA3670:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3670-.LLSDACSB3670
.LLSDACSB3670:
	.uleb128 .LEHB5-.LFB3670
	.uleb128 .LEHE5-.LEHB5
	.uleb128 .L47-.LFB3670
	.uleb128 0
	.uleb128 .LEHB6-.LFB3670
	.uleb128 .LEHE6-.LEHB6
	.uleb128 0
	.uleb128 0
.LLSDACSE3670:
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC5IS3_EEPKcRKS3_,comdat
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
	.set	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC2IS3_EEPKcRKS3_
	.section	.text._ZN8SkipListIiiEC2Ei,"axG",@progbits,_ZN8SkipListIiiEC5Ei,comdat
	.align 2
	.weak	_ZN8SkipListIiiEC2Ei
	.type	_ZN8SkipListIiiEC2Ei, @function
_ZN8SkipListIiiEC2Ei:
.LFB3673:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3673
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movq	-56(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
.LEHB7:
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEEC1Ev@PLT
.LEHE7:
	movq	-56(%rbp), %rax
	addq	$528, %rax
	movq	%rax, %rdi
.LEHB8:
	call	_ZNSt14basic_ifstreamIcSt11char_traitsIcEEC1Ev@PLT
.LEHE8:
	movq	-56(%rbp), %rax
	movl	-60(%rbp), %edx
	movl	%edx, (%rax)
	movq	-56(%rbp), %rax
	movl	$0, 4(%rax)
	movq	-56(%rbp), %rax
	movl	$0, 1048(%rax)
	movl	$32, %edi
.LEHB9:
	call	_Znwm@PLT
.LEHE9:
	movq	%rax, %rbx
	movl	$1, %r13d
	movq	-56(%rbp), %rax
	movl	(%rax), %ecx
	movl	-36(%rbp), %edx
	movl	-40(%rbp), %eax
	movq	.LC4(%rip), %rsi
	movq	%rsi, %xmm0
	movl	%eax, %esi
	movq	%rbx, %rdi
.LEHB10:
	call	_ZN4NodeIiiEC1Eiiid
.LEHE10:
	movq	-56(%rbp), %rax
	movq	%rbx, 8(%rax)
	jmp	.L57
.L56:
	endbr64
	movq	%rax, %r12
	testb	%r13b, %r13b
	je	.L51
	movl	$32, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L51:
	movq	%r12, %rbx
	jmp	.L52
.L55:
	endbr64
	movq	%rax, %rbx
.L52:
	movq	-56(%rbp), %rax
	addq	$528, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ifstreamIcSt11char_traitsIcEED1Ev@PLT
	jmp	.L53
.L54:
	endbr64
	movq	%rax, %rbx
.L53:
	movq	-56(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev@PLT
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB11:
	call	_Unwind_Resume@PLT
.LEHE11:
.L57:
	addq	$40, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3673:
	.section	.gcc_except_table
.LLSDA3673:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3673-.LLSDACSB3673
.LLSDACSB3673:
	.uleb128 .LEHB7-.LFB3673
	.uleb128 .LEHE7-.LEHB7
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB8-.LFB3673
	.uleb128 .LEHE8-.LEHB8
	.uleb128 .L54-.LFB3673
	.uleb128 0
	.uleb128 .LEHB9-.LFB3673
	.uleb128 .LEHE9-.LEHB9
	.uleb128 .L55-.LFB3673
	.uleb128 0
	.uleb128 .LEHB10-.LFB3673
	.uleb128 .LEHE10-.LEHB10
	.uleb128 .L56-.LFB3673
	.uleb128 0
	.uleb128 .LEHB11-.LFB3673
	.uleb128 .LEHE11-.LEHB11
	.uleb128 0
	.uleb128 0
.LLSDACSE3673:
	.section	.text._ZN8SkipListIiiEC2Ei,"axG",@progbits,_ZN8SkipListIiiEC5Ei,comdat
	.size	_ZN8SkipListIiiEC2Ei, .-_ZN8SkipListIiiEC2Ei
	.weak	_ZN8SkipListIiiEC1Ei
	.set	_ZN8SkipListIiiEC1Ei,_ZN8SkipListIiiEC2Ei
	.section	.text._ZN8SkipListIiiED2Ev,"axG",@progbits,_ZN8SkipListIiiED5Ev,comdat
	.align 2
	.weak	_ZN8SkipListIiiED2Ev
	.type	_ZN8SkipListIiiED2Ev, @function
_ZN8SkipListIiiED2Ev:
.LFB3676:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3676
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	-40(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEE7is_openEv@PLT
	testb	%al, %al
	je	.L59
	movq	-40(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEE5closeEv@PLT
.L59:
	movq	-40(%rbp), %rax
	addq	$528, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ifstreamIcSt11char_traitsIcEE7is_openEv@PLT
	testb	%al, %al
	je	.L60
	movq	-40(%rbp), %rax
	addq	$528, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ifstreamIcSt11char_traitsIcEE5closeEv@PLT
.L60:
	movq	-40(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	8(%rax), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	jmp	.L61
.L63:
	movq	-32(%rbp), %rbx
	testq	%rbx, %rbx
	je	.L62
	movq	%rbx, %rdi
	call	_ZN4NodeIiiED1Ev
	movl	$32, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L62:
	movq	-24(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
.L61:
	cmpq	$0, -24(%rbp)
	jne	.L63
	movq	-40(%rbp), %rax
	addq	$528, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ifstreamIcSt11char_traitsIcEED1Ev@PLT
	movq	-40(%rbp), %rax
	addq	$16, %rax
	movq	%rax, %rdi
	call	_ZNSt14basic_ofstreamIcSt11char_traitsIcEED1Ev@PLT
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3676:
	.section	.gcc_except_table
.LLSDA3676:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3676-.LLSDACSB3676
.LLSDACSB3676:
.LLSDACSE3676:
	.section	.text._ZN8SkipListIiiED2Ev,"axG",@progbits,_ZN8SkipListIiiED5Ev,comdat
	.size	_ZN8SkipListIiiED2Ev, .-_ZN8SkipListIiiED2Ev
	.weak	_ZN8SkipListIiiED1Ev
	.set	_ZN8SkipListIiiED1Ev,_ZN8SkipListIiiED2Ev
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev:
.LFB3679:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, -8(%rbp)
	nop
	nop
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3679:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC1Ev
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC1Ev,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2Ev
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev:
.LFB3685:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3685
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	16(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	sarq	$4, %rax
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD1Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3685:
	.section	.gcc_except_table
.LLSDA3685:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3685-.LLSDACSB3685
.LLSDACSB3685:
.LLSDACSE3685:
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED5Ev,comdat
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED1Ev
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED1Ev,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED5Ev,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev:
.LFB3688:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3688
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	movq	-40(%rbp), %rdx
	movq	8(%rdx), %rdx
	movq	-40(%rbp), %rcx
	movq	(%rcx), %rcx
	movq	%rcx, -24(%rbp)
	movq	%rdx, -16(%rbp)
	movq	%rax, -8(%rbp)
	movq	-16(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_
	nop
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3688:
	.section	.gcc_except_table
.LLSDA3688:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3688-.LLSDACSB3688
.LLSDACSB3688:
.LLSDACSE3688:
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED5Ev,comdat
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED1Ev
	.set	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED1Ev,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EED2Ev
	.section	.text._ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_,"axG",@progbits,_ZNSt4pairIiiEC5IRiS2_Lb1EEEOT_OT0_,comdat
	.align 2
	.weak	_ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_
	.type	_ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_, @function
_ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_:
.LFB3691:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE
	movl	(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, (%rax)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE
	movl	(%rax), %edx
	movq	-8(%rbp), %rax
	movl	%edx, 4(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3691:
	.size	_ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_, .-_ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_
	.weak	_ZNSt4pairIiiEC1IRiS2_Lb1EEEOT_OT0_
	.set	_ZNSt4pairIiiEC1IRiS2_Lb1EEEOT_OT0_,_ZNSt4pairIiiEC2IRiS2_Lb1EEEOT_OT0_
	.section	.text._ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_,"axG",@progbits,_ZNSt4pairIS_IiiEdEC5IS0_dLb1EEEOT_OT0_,comdat
	.align 2
	.weak	_ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_
	.type	_ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_, @function
_ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_:
.LFB3694:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE
	movq	-8(%rbp), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rdx)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE
	movsd	(%rax), %xmm0
	movq	-8(%rbp), %rax
	movsd	%xmm0, 8(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3694:
	.size	_ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_, .-_ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_
	.weak	_ZNSt4pairIS_IiiEdEC1IS0_dLb1EEEOT_OT0_
	.set	_ZNSt4pairIS_IiiEdEC1IS0_dLb1EEEOT_OT0_,_ZNSt4pairIS_IiiEdEC2IS0_dLb1EEEOT_OT0_
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_:
.LFB3696:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3696:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE9push_backEOS2_
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC5ERKS4_,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_:
.LFB3698:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3698
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$88, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -40(%rbp)
	xorl	%eax, %eax
	movq	-104(%rbp), %rbx
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	movq	%rax, -88(%rbp)
	leaq	-89(%rbp), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, -80(%rbp)
	movq	%rax, -72(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, -64(%rbp)
	movq	-72(%rbp), %rax
	movq	%rax, -56(%rbp)
	movq	-64(%rbp), %rax
	movq	%rax, -48(%rbp)
	nop
	nop
	nop
	nop
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	movq	%rax, %rcx
	leaq	-89(%rbp), %rax
	movq	%rax, %rdx
	movq	%rcx, %rsi
	movq	%rbx, %rdi
.LEHB12:
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_
.LEHE12:
	leaq	-89(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev
	nop
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	movq	%rax, %r13
	movq	-104(%rbp), %rax
	movq	(%rax), %rbx
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	movq	%rax, %r12
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv
	movq	%r13, %rcx
	movq	%rbx, %rdx
	movq	%r12, %rsi
	movq	%rax, %rdi
.LEHB13:
	call	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E
.LEHE13:
	movq	-104(%rbp), %rdx
	movq	%rax, 8(%rdx)
	nop
	movq	-40(%rbp), %rax
	subq	%fs:40, %rax
	je	.L77
	jmp	.L80
.L78:
	endbr64
	movq	%rax, %rbx
	leaq	-89(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev
	nop
	movq	%rbx, %rax
	movq	-40(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L74
	call	__stack_chk_fail@PLT
.L74:
	movq	%rax, %rdi
.LEHB14:
	call	_Unwind_Resume@PLT
.L79:
	endbr64
	movq	%rax, %rbx
	movq	-104(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EED2Ev
	movq	%rbx, %rax
	movq	-40(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L76
	call	__stack_chk_fail@PLT
.L76:
	movq	%rax, %rdi
	call	_Unwind_Resume@PLT
.LEHE14:
.L80:
	call	__stack_chk_fail@PLT
.L77:
	addq	$88, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3698:
	.section	.gcc_except_table
.LLSDA3698:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3698-.LLSDACSB3698
.LLSDACSB3698:
	.uleb128 .LEHB12-.LFB3698
	.uleb128 .LEHE12-.LEHB12
	.uleb128 .L78-.LFB3698
	.uleb128 0
	.uleb128 .LEHB13-.LFB3698
	.uleb128 .LEHE13-.LEHB13
	.uleb128 .L79-.LFB3698
	.uleb128 0
	.uleb128 .LEHB14-.LFB3698
	.uleb128 .LEHE14-.LEHB14
	.uleb128 0
	.uleb128 0
.LLSDACSE3698:
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC5ERKS4_,comdat
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC1ERKS4_
	.set	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC1ERKS4_,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEC2ERKS4_
	.section	.text._ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE,"axG",@progbits,_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE,comdat
	.align 2
	.weak	_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE
	.type	_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE, @function
_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE:
.LFB3700:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3700
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r14
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$48, %rsp
	.cfi_offset 14, -24
	.cfi_offset 13, -32
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	movl	%eax, %edx
	movq	-72(%rbp), %rax
	movl	%edx, 1048(%rax)
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	addl	$1, %eax
	cltq
	movabsq	$1152921504606846975, %rdx
	cmpq	%rax, %rdx
	jb	.L82
	salq	$3, %rax
	movq	%rax, %rdi
.LEHB15:
	call	_Znam@PLT
	movq	%rax, -48(%rbp)
	movl	$0, -64(%rbp)
	jmp	.L84
.L82:
	call	__cxa_throw_bad_array_new_length@PLT
.L85:
	movl	-64(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, (%rdx)
	movl	-64(%rbp), %eax
	movl	%eax, %esi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZNSolsEi@PLT
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	addl	$1, -64(%rbp)
.L84:
	movq	-72(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -64(%rbp)
	jle	.L85
	movl	$0, -60(%rbp)
	jmp	.L86
.L90:
	movl	-60(%rbp), %eax
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm
	movq	8(%rax), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %xmm0
	movq	%rax, %rdi
	call	_ZN8SkipListIiiE16get_random_levelEd
	movl	%eax, -52(%rbp)
	movl	$32, %edi
	call	_Znwm@PLT
.LEHE15:
	movq	%rax, %rbx
	movl	$1, %r14d
	movl	-60(%rbp), %eax
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm
	movq	8(%rax), %r13
	movl	-60(%rbp), %eax
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm
	movl	4(%rax), %r12d
	movl	-60(%rbp), %eax
	movslq	%eax, %rdx
	movq	-80(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm
	movl	(%rax), %eax
	movl	-52(%rbp), %edx
	movq	%r13, %xmm0
	movl	%edx, %ecx
	movl	%r12d, %edx
	movl	%eax, %esi
	movq	%rbx, %rdi
.LEHB16:
	call	_ZN4NodeIiiEC1Eiiid
.LEHE16:
	movq	%rbx, -40(%rbp)
	movl	-52(%rbp), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-72(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	%eax, -52(%rbp)
	jle	.L87
	movq	-72(%rbp), %rax
	movl	-52(%rbp), %edx
	movl	%edx, 4(%rax)
.L87:
	movl	$0, -56(%rbp)
	jmp	.L88
.L89:
	movl	-56(%rbp), %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-48(%rbp), %rax
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movl	-56(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-40(%rbp), %rax
	movq	%rax, (%rdx)
	addl	$1, -56(%rbp)
.L88:
	movl	-56(%rbp), %eax
	cmpl	-52(%rbp), %eax
	jle	.L89
	addl	$1, -60(%rbp)
.L86:
	movq	-72(%rbp), %rax
	movl	1048(%rax), %eax
	cmpl	%eax, -60(%rbp)
	jl	.L90
	cmpq	$0, -48(%rbp)
	je	.L95
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZdaPv@PLT
	jmp	.L95
.L94:
	endbr64
	movq	%rax, %r12
	testb	%r14b, %r14b
	je	.L93
	movl	$32, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L93:
	movq	%r12, %rax
	movq	%rax, %rdi
.LEHB17:
	call	_Unwind_Resume@PLT
.LEHE17:
.L95:
	nop
	addq	$48, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%r14
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3700:
	.section	.gcc_except_table
.LLSDA3700:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3700-.LLSDACSB3700
.LLSDACSB3700:
	.uleb128 .LEHB15-.LFB3700
	.uleb128 .LEHE15-.LEHB15
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB16-.LFB3700
	.uleb128 .LEHE16-.LEHB16
	.uleb128 .L94-.LFB3700
	.uleb128 0
	.uleb128 .LEHB17-.LFB3700
	.uleb128 .LEHE17-.LEHB17
	.uleb128 0
	.uleb128 0
.LLSDACSE3700:
	.section	.text._ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE,"axG",@progbits,_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE,comdat
	.size	_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE, .-_ZN8SkipListIiiE8bulkloadESt6vectorISt4pairIS2_IiiEdESaIS4_EE
	.section	.rodata
.LC5:
	.string	"key:"
.LC6:
	.string	",exists"
.LC7:
	.string	"Successfully inserted key:"
.LC8:
	.string	",value:"
	.section	.text._ZN8SkipListIiiE6insertEiid,"axG",@progbits,_ZN8SkipListIiiE6insertEiid,comdat
	.align 2
	.weak	_ZN8SkipListIiiE6insertEiid
	.type	_ZN8SkipListIiiE6insertEiid, @function
_ZN8SkipListIiiE6insertEiid:
.LFB3701:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$104, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -88(%rbp)
	movl	%esi, -92(%rbp)
	movl	%edx, -96(%rbp)
	movsd	%xmm0, -104(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	%rsp, %rax
	movq	%rax, %rbx
	leaq	mtx(%rip), %rax
	movq	%rax, %rdi
	call	_ZNSt5mutex4lockEv
	movq	-88(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -56(%rbp)
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	movslq	%eax, %rdx
	subq	$1, %rdx
	movq	%rdx, -48(%rbp)
	cltq
	leaq	0(,%rax,8), %rdx
	movl	$16, %eax
	subq	$1, %rax
	addq	%rdx, %rax
	movl	$16, %ecx
	movl	$0, %edx
	divq	%rcx
	imulq	$16, %rax, %rax
	movq	%rax, %rcx
	andq	$-4096, %rcx
	movq	%rsp, %rdx
	subq	%rcx, %rdx
.L97:
	cmpq	%rdx, %rsp
	je	.L98
	subq	$4096, %rsp
	orq	$0, 4088(%rsp)
	jmp	.L97
.L98:
	movq	%rax, %rdx
	andl	$4095, %edx
	subq	%rdx, %rsp
	movq	%rax, %rdx
	andl	$4095, %edx
	testq	%rdx, %rdx
	je	.L99
	andl	$4095, %eax
	subq	$8, %rax
	addq	%rsp, %rax
	orq	$0, (%rax)
.L99:
	movq	%rsp, %rax
	addq	$7, %rax
	shrq	$3, %rax
	salq	$3, %rax
	movq	%rax, -40(%rbp)
	movq	-88(%rbp), %rax
	movl	(%rax), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-40(%rbp), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	movq	-88(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -72(%rbp)
	jmp	.L100
.L104:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movl	-72(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
.L101:
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movl	-72(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L102
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movl	-72(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_ZNK4NodeIiiE7get_keyEv
	cmpl	%eax, -92(%rbp)
	jle	.L102
	movl	$1, %eax
	jmp	.L103
.L102:
	movl	$0, %eax
.L103:
	testb	%al, %al
	jne	.L104
	movq	-40(%rbp), %rax
	movl	-72(%rbp), %edx
	movslq	%edx, %rdx
	movq	-56(%rbp), %rcx
	movq	%rcx, (%rax,%rdx,8)
	subl	$1, -72(%rbp)
.L100:
	cmpl	$0, -72(%rbp)
	jns	.L101
	movq	-56(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -56(%rbp)
	cmpq	$0, -56(%rbp)
	je	.L106
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK4NodeIiiE7get_keyEv
	cmpl	%eax, -92(%rbp)
	jne	.L106
	movl	$1, %eax
	jmp	.L107
.L106:
	movl	$0, %eax
.L107:
	testb	%al, %al
	je	.L108
	leaq	.LC5(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-92(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
	movq	%rax, %rdx
	leaq	.LC6(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	leaq	mtx(%rip), %rax
	movq	%rax, %rdi
	call	_ZNSt5mutex6unlockEv
	movl	$1, %eax
	jmp	.L109
.L108:
	cmpq	$0, -56(%rbp)
	je	.L110
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK4NodeIiiE7get_keyEv
	cmpl	%eax, -92(%rbp)
	je	.L111
.L110:
	movl	$1, %eax
	jmp	.L112
.L111:
	movl	$0, %eax
.L112:
	testb	%al, %al
	je	.L113
	movq	-104(%rbp), %rdx
	movq	-88(%rbp), %rax
	movq	%rdx, %xmm0
	movq	%rax, %rdi
	call	_ZN8SkipListIiiE16get_random_levelEd
	movl	%eax, -60(%rbp)
	movq	-88(%rbp), %rax
	movl	4(%rax), %eax
	cmpl	%eax, -60(%rbp)
	jle	.L114
	movq	-88(%rbp), %rax
	movl	4(%rax), %eax
	addl	$1, %eax
	movl	%eax, -68(%rbp)
	jmp	.L115
.L116:
	movq	-88(%rbp), %rax
	movq	8(%rax), %rcx
	movq	-40(%rbp), %rax
	movl	-68(%rbp), %edx
	movslq	%edx, %rdx
	movq	%rcx, (%rax,%rdx,8)
	addl	$1, -68(%rbp)
.L115:
	movl	-60(%rbp), %eax
	cmpl	-68(%rbp), %eax
	jge	.L116
	movq	-88(%rbp), %rax
	movl	-60(%rbp), %edx
	movl	%edx, 4(%rax)
.L114:
	movq	-104(%rbp), %rdi
	movl	-60(%rbp), %ecx
	movl	-96(%rbp), %edx
	movl	-92(%rbp), %esi
	movq	-88(%rbp), %rax
	movq	%rdi, %xmm0
	movq	%rax, %rdi
	call	_ZN8SkipListIiiE11create_nodeEiiid
	movq	%rax, -32(%rbp)
	movl	$0, -64(%rbp)
	jmp	.L117
.L118:
	movq	-40(%rbp), %rax
	movl	-64(%rbp), %edx
	movslq	%edx, %rdx
	movq	(%rax,%rdx,8), %rax
	movq	(%rax), %rax
	movl	-64(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	leaq	(%rax,%rdx), %rcx
	movq	-32(%rbp), %rax
	movq	(%rax), %rax
	movl	-64(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	(%rcx), %rax
	movq	%rax, (%rdx)
	movq	-40(%rbp), %rax
	movl	-64(%rbp), %edx
	movslq	%edx, %rdx
	movq	(%rax,%rdx,8), %rax
	movq	(%rax), %rax
	movl	-64(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rax, %rdx
	movq	-32(%rbp), %rax
	movq	%rax, (%rdx)
	addl	$1, -64(%rbp)
.L117:
	movl	-64(%rbp), %eax
	cmpl	-60(%rbp), %eax
	jl	.L118
	leaq	.LC7(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-92(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-96(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	movq	-88(%rbp), %rax
	movl	1048(%rax), %eax
	leal	1(%rax), %edx
	movq	-88(%rbp), %rax
	movl	%edx, 1048(%rax)
.L113:
	leaq	mtx(%rip), %rax
	movq	%rax, %rdi
	call	_ZNSt5mutex6unlockEv
	movl	$0, %eax
.L109:
	movq	%rbx, %rsp
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L120
	call	__stack_chk_fail@PLT
.L120:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3701:
	.size	_ZN8SkipListIiiE6insertEiid, .-_ZN8SkipListIiiE6insertEiid
	.section	.rodata
.LC9:
	.string	"search_element------------"
.LC10:
	.string	"Found key:"
.LC11:
	.string	"Not Found Key:"
	.section	.text._ZN8SkipListIiiE6searchEi,"axG",@progbits,_ZN8SkipListIiiE6searchEi,comdat
	.align 2
	.weak	_ZN8SkipListIiiE6searchEi
	.type	_ZN8SkipListIiiE6searchEi, @function
_ZN8SkipListIiiE6searchEi:
.LFB3702:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movl	%esi, -44(%rbp)
	leaq	.LC9(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	movq	-40(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -24(%rbp)
	movq	-40(%rbp), %rax
	movl	4(%rax), %eax
	movl	%eax, -28(%rbp)
	jmp	.L122
.L126:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
.L123:
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L124
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movl	-28(%rbp), %edx
	movslq	%edx, %rdx
	salq	$3, %rdx
	addq	%rdx, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_ZNK4NodeIiiE7get_keyEv
	cmpl	%eax, -44(%rbp)
	jle	.L124
	movl	$1, %eax
	jmp	.L125
.L124:
	movl	$0, %eax
.L125:
	testb	%al, %al
	jne	.L126
	subl	$1, -28(%rbp)
.L122:
	cmpl	$0, -28(%rbp)
	jns	.L123
	movq	-24(%rbp), %rax
	movq	(%rax), %rax
	movq	(%rax), %rax
	movq	%rax, -24(%rbp)
	cmpq	$0, -24(%rbp)
	je	.L128
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK4NodeIiiE7get_keyEv
	cmpl	%eax, -44(%rbp)
	jne	.L128
	movl	$1, %eax
	jmp	.L129
.L128:
	movl	$0, %eax
.L129:
	testb	%al, %al
	je	.L130
	leaq	.LC10(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
	movq	%rax, %rdx
	leaq	.LC8(%rip), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK4NodeIiiE9get_valueEv
	movl	%eax, %esi
	movq	%rbx, %rdi
	call	_ZNSolsEi@PLT
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	movq	-24(%rbp), %rax
	jmp	.L131
.L130:
	leaq	.LC11(%rip), %rax
	movq	%rax, %rsi
	leaq	_ZSt4cout(%rip), %rax
	movq	%rax, %rdi
	call	_ZStlsISt11char_traitsIcEERSt13basic_ostreamIcT_ES5_PKc@PLT
	movq	%rax, %rdx
	movl	-44(%rbp), %eax
	movl	%eax, %esi
	movq	%rdx, %rdi
	call	_ZNSolsEi@PLT
	movq	_ZSt4endlIcSt11char_traitsIcEERSt13basic_ostreamIT_T0_ES6_@GOTPCREL(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSolsEPFRSoS_E@PLT
	movl	$0, %eax
.L131:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3702:
	.size	_ZN8SkipListIiiE6searchEi, .-_ZN8SkipListIiiE6searchEi
	.section	.text._ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_,"axG",@progbits,_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_,comdat
	.weak	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_
	.type	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_, @function
_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_:
.LFB3704:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movzbl	(%rax), %edx
	movq	-16(%rbp), %rax
	movzbl	(%rax), %eax
	cmpb	%al, %dl
	sete	%al
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3704:
	.size	_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_, .-_ZN9__gnu_cxx11char_traitsIcE2eqERKcS3_
	.section	.text._ZNSt15__new_allocatorIcED2Ev,"axG",@progbits,_ZNSt15__new_allocatorIcED5Ev,comdat
	.align 2
	.weak	_ZNSt15__new_allocatorIcED2Ev
	.type	_ZNSt15__new_allocatorIcED2Ev, @function
_ZNSt15__new_allocatorIcED2Ev:
.LFB3712:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3712:
	.size	_ZNSt15__new_allocatorIcED2Ev, .-_ZNSt15__new_allocatorIcED2Ev
	.weak	_ZNSt15__new_allocatorIcED1Ev
	.set	_ZNSt15__new_allocatorIcED1Ev,_ZNSt15__new_allocatorIcED2Ev
	.section	.text._ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_,"axG",@progbits,_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC5EPS4_,comdat
	.align 2
	.weak	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_
	.type	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_, @function
_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_:
.LFB3742:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	-16(%rbp), %rdx
	movq	%rdx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3742:
	.size	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_, .-_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_
	.weak	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC1EPS4_
	.set	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC1EPS4_,_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC2EPS4_
	.section	.text._ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev,"axG",@progbits,_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD5Ev,comdat
	.align 2
	.weak	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev
	.type	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev, @function
_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev:
.LFB3745:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3745
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L138
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE10_M_disposeEv@PLT
.L138:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3745:
	.section	.gcc_except_table
.LLSDA3745:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3745-.LLSDACSB3745
.LLSDACSB3745:
.LLSDACSE3745:
	.section	.text._ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev,"axG",@progbits,_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD5Ev,comdat
	.size	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev, .-_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev
	.weak	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev
	.set	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev,_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD2Ev
	.section	.text._ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag,"axG",@progbits,_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag,comdat
	.align 2
	.weak	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag
	.type	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag, @function
_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag:
.LFB3740:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$96, %rsp
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	%rdx, -88(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-80(%rbp), %rax
	movq	%rax, -48(%rbp)
	movq	-88(%rbp), %rax
	movq	%rax, -40(%rbp)
	nop
	movq	-48(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	subq	-32(%rbp), %rax
	nop
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	cmpq	$15, %rax
	jbe	.L143
	leaq	-56(%rbp), %rcx
	movq	-72(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE9_M_createERmm@PLT
	movq	%rax, %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEPc@PLT
	movq	-56(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE11_M_capacityEm@PLT
	jmp	.L144
.L143:
	movq	-72(%rbp), %rax
	movq	%rax, -16(%rbp)
	nop
.L144:
	movq	-72(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardC1EPS4_
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE7_M_dataEv@PLT
	movq	%rax, %rcx
	movq	-88(%rbp), %rdx
	movq	-80(%rbp), %rax
	movq	%rax, %rsi
	movq	%rcx, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_S_copy_charsEPcPKcS7_@PLT
	movq	$0, -48(%rbp)
	movq	-56(%rbp), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE13_M_set_lengthEm@PLT
	leaq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tagEN6_GuardD1Ev
	movq	-8(%rbp), %rax
	subq	%fs:40, %rax
	je	.L145
	call	__stack_chk_fail@PLT
.L145:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3740:
	.size	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag, .-_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEE12_M_constructIPKcEEvT_S8_St20forward_iterator_tag
	.section	.text._ZN4NodeIiiEC2Eiiid,"axG",@progbits,_ZN4NodeIiiEC5Eiiid,comdat
	.align 2
	.weak	_ZN4NodeIiiEC2Eiiid
	.type	_ZN4NodeIiiEC2Eiiid, @function
_ZN4NodeIiiEC2Eiiid:
.LFB3881:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movl	%esi, -12(%rbp)
	movl	%edx, -16(%rbp)
	movl	%ecx, -20(%rbp)
	movsd	%xmm0, -32(%rbp)
	movq	-8(%rbp), %rax
	movl	-12(%rbp), %edx
	movl	%edx, 12(%rax)
	movq	-8(%rbp), %rax
	movl	-16(%rbp), %edx
	movl	%edx, 16(%rax)
	movq	-8(%rbp), %rax
	movsd	-32(%rbp), %xmm0
	movsd	%xmm0, 24(%rax)
	movq	-8(%rbp), %rax
	movl	-20(%rbp), %edx
	movl	%edx, 8(%rax)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	cltq
	movabsq	$1152921504606846975, %rdx
	cmpq	%rax, %rdx
	jb	.L147
	salq	$3, %rax
	jmp	.L149
.L147:
	call	__cxa_throw_bad_array_new_length@PLT
.L149:
	movq	%rax, %rdi
	call	_Znam@PLT
	movq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movl	-20(%rbp), %eax
	addl	$1, %eax
	cltq
	leaq	0(,%rax,8), %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movl	$0, %esi
	movq	%rax, %rdi
	call	memset@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3881:
	.size	_ZN4NodeIiiEC2Eiiid, .-_ZN4NodeIiiEC2Eiiid
	.weak	_ZN4NodeIiiEC1Eiiid
	.set	_ZN4NodeIiiEC1Eiiid,_ZN4NodeIiiEC2Eiiid
	.section	.text._ZN4NodeIiiED2Ev,"axG",@progbits,_ZN4NodeIiiED5Ev,comdat
	.align 2
	.weak	_ZN4NodeIiiED2Ev
	.type	_ZN4NodeIiiED2Ev, @function
_ZN4NodeIiiED2Ev:
.LFB3888:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	testq	%rax, %rax
	je	.L152
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	_ZdaPv@PLT
.L152:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3888:
	.size	_ZN4NodeIiiED2Ev, .-_ZN4NodeIiiED2Ev
	.weak	_ZN4NodeIiiED1Ev
	.set	_ZN4NodeIiiED1Ev,_ZN4NodeIiiED2Ev
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC5Ev,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev:
.LFB3894:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	$0, (%rax)
	movq	-8(%rbp), %rax
	movq	$0, 8(%rax)
	movq	-8(%rbp), %rax
	movq	$0, 16(%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3894:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC1Ev
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC1Ev,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev
	.section	.text._ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev,"axG",@progbits,_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED5Ev,comdat
	.align 2
	.weak	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev
	.type	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev, @function
_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev:
.LFB3897:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3897:
	.size	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev, .-_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev
	.weak	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED1Ev
	.set	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED1Ev,_ZNSt15__new_allocatorISt4pairIS0_IiiEdEED2Ev
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m:
.LFB3899:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	cmpq	$0, -48(%rbp)
	je	.L157
	movq	-40(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m
	nop
.L157:
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3899:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv:
.LFB3900:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3900:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	.section	.text._ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE,"axG",@progbits,_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE,comdat
	.weak	_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE
	.type	_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE, @function
_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE:
.LFB3902:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3902:
	.size	_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE, .-_ZSt7forwardIRiEOT_RNSt16remove_referenceIS1_E4typeE
	.section	.text._ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE,"axG",@progbits,_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE,comdat
	.weak	_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE
	.type	_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE, @function
_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE:
.LFB3903:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3903:
	.size	_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE, .-_ZSt7forwardISt4pairIiiEEOT_RNSt16remove_referenceIS2_E4typeE
	.section	.text._ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE,"axG",@progbits,_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE,comdat
	.weak	_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE
	.type	_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE, @function
_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE:
.LFB3904:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3904:
	.size	_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE, .-_ZSt7forwardIdEOT_RNSt16remove_referenceIS0_E4typeE
	.section	.text._ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_,"axG",@progbits,_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_,comdat
	.weak	_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_
	.type	_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_, @function
_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_:
.LFB3905:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3905:
	.size	_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_, .-_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_:
.LFB3906:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -72(%rbp)
	movq	%rsi, -80(%rbp)
	movq	-72(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-72(%rbp), %rax
	movq	16(%rax), %rax
	cmpq	%rax, %rdx
	je	.L169
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	-72(%rbp), %rdx
	movq	8(%rdx), %rdx
	movq	-72(%rbp), %rcx
	movq	%rcx, -64(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	-64(%rbp), %rdx
	movq	%rdx, -40(%rbp)
	movq	-56(%rbp), %rdx
	movq	%rdx, -32(%rbp)
	movq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$16, %edi
	call	_ZnwmPv
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rbx)
	movq	%rdx, 8(%rbx)
	nop
	nop
	movq	-72(%rbp), %rax
	movq	8(%rax), %rax
	leaq	16(%rax), %rdx
	movq	-72(%rbp), %rax
	movq	%rdx, 8(%rax)
	jmp	.L170
.L169:
	movq	-80(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	%rax, %rbx
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	movq	%rax, %rcx
	movq	-72(%rbp), %rax
	movq	%rbx, %rdx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_
.L170:
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3906:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE12emplace_backIJS2_EEERS2_DpOT_
	.section	.text._ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv,"axG",@progbits,_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv,comdat
	.align 2
	.weak	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	.type	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv, @function
_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv:
.LFB3908:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	8(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	subq	%rax, %rdx
	movq	%rdx, %rax
	sarq	$4, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3908:
	.size	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv, .-_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	.section	.text._ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv,"axG",@progbits,_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv,comdat
	.align 2
	.weak	_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	.type	_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv, @function
_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv:
.LFB3909:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3909:
	.size	_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv, .-_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC5EmRKS3_,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_:
.LFB3912:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3912
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	-40(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC1ERKS3_
	movq	-32(%rbp), %rdx
	movq	-24(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
.LEHB18:
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm
.LEHE18:
	jmp	.L179
.L178:
	endbr64
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implD1Ev
	movq	%rbx, %rax
	movq	%rax, %rdi
.LEHB19:
	call	_Unwind_Resume@PLT
.LEHE19:
.L179:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3912:
	.section	.gcc_except_table
.LLSDA3912:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3912-.LLSDACSB3912
.LLSDACSB3912:
	.uleb128 .LEHB18-.LFB3912
	.uleb128 .LEHE18-.LEHB18
	.uleb128 .L178-.LFB3912
	.uleb128 0
	.uleb128 .LEHB19-.LFB3912
	.uleb128 .LEHE19-.LEHB19
	.uleb128 0
	.uleb128 0
.LLSDACSE3912:
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC5EmRKS3_,comdat
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC1EmRKS3_
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC1EmRKS3_,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EEC2EmRKS3_
	.section	.text._ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv,"axG",@progbits,_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv,comdat
	.align 2
	.weak	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv
	.type	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv, @function
_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv:
.LFB3914:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS5_
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L182
	call	__stack_chk_fail@PLT
.L182:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3914:
	.size	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv, .-_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv
	.section	.text._ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv,"axG",@progbits,_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv,comdat
	.align 2
	.weak	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	.type	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv, @function
_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv:
.LFB3915:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rax
	leaq	8(%rax), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS5_
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L185
	call	__stack_chk_fail@PLT
.L185:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3915:
	.size	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv, .-_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	.section	.text._ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E,"axG",@progbits,_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E,comdat
	.weak	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E
	.type	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E, @function
_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E:
.LFB3916:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3916:
	.size	_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E, .-_ZSt22__uninitialized_copy_aIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_S4_ET0_T_SD_SC_RSaIT1_E
	.section	.text._ZN8SkipListIiiE16get_random_levelEd,"axG",@progbits,_ZN8SkipListIiiE16get_random_levelEd,comdat
	.align 2
	.weak	_ZN8SkipListIiiE16get_random_levelEd
	.type	_ZN8SkipListIiiE16get_random_levelEd, @function
_ZN8SkipListIiiE16get_random_levelEd:
.LFB3919:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movsd	%xmm0, -32(%rbp)
	movl	$1, -4(%rbp)
	jmp	.L189
.L196:
	addl	$1, -4(%rbp)
.L189:
	call	rand@PLT
	andl	$1, %eax
	testl	%eax, %eax
	jne	.L190
	movl	-4(%rbp), %eax
	movl	$1, %edx
	movl	%eax, %ecx
	shrq	%cl, %rdx
	movq	%rdx, %rax
	subq	$1, %rax
	testq	%rax, %rax
	js	.L191
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rax, %xmm0
	jmp	.L192
.L191:
	movq	%rax, %rdx
	shrq	%rdx
	andl	$1, %eax
	orq	%rax, %rdx
	pxor	%xmm0, %xmm0
	cvtsi2ssq	%rdx, %xmm0
	addss	%xmm0, %xmm0
.L192:
	movq	-24(%rbp), %rax
	movl	1048(%rax), %eax
	pxor	%xmm1, %xmm1
	cvtsi2ssl	%eax, %xmm1
	divss	%xmm1, %xmm0
	pxor	%xmm1, %xmm1
	cvtss2sd	%xmm0, %xmm1
	movsd	-32(%rbp), %xmm0
	comisd	%xmm1, %xmm0
	jb	.L193
.L190:
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jge	.L193
	movl	$1, %eax
	jmp	.L195
.L193:
	movl	$0, %eax
.L195:
	testb	%al, %al
	jne	.L196
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	cmpl	%eax, -4(%rbp)
	jl	.L197
	movq	-24(%rbp), %rax
	movl	(%rax), %eax
	jmp	.L198
.L197:
	movl	-4(%rbp), %eax
.L198:
	movl	%eax, -4(%rbp)
	movl	-4(%rbp), %eax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3919:
	.size	_ZN8SkipListIiiE16get_random_levelEd, .-_ZN8SkipListIiiE16get_random_levelEd
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm:
.LFB3920:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rdx
	salq	$4, %rdx
	addq	%rdx, %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3920:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EEixEm
	.section	.text._ZNK4NodeIiiE7get_keyEv,"axG",@progbits,_ZNK4NodeIiiE7get_keyEv,comdat
	.align 2
	.weak	_ZNK4NodeIiiE7get_keyEv
	.type	_ZNK4NodeIiiE7get_keyEv, @function
_ZNK4NodeIiiE7get_keyEv:
.LFB3921:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	12(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3921:
	.size	_ZNK4NodeIiiE7get_keyEv, .-_ZNK4NodeIiiE7get_keyEv
	.section	.text._ZN8SkipListIiiE11create_nodeEiiid,"axG",@progbits,_ZN8SkipListIiiE11create_nodeEiiid,comdat
	.align 2
	.weak	_ZN8SkipListIiiE11create_nodeEiiid
	.type	_ZN8SkipListIiiE11create_nodeEiiid, @function
_ZN8SkipListIiiE11create_nodeEiiid:
.LFB3922:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA3922
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r13
	pushq	%r12
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 13, -24
	.cfi_offset 12, -32
	.cfi_offset 3, -40
	movq	%rdi, -56(%rbp)
	movl	%esi, -60(%rbp)
	movl	%edx, -64(%rbp)
	movl	%ecx, -68(%rbp)
	movsd	%xmm0, -80(%rbp)
	movl	$32, %edi
.LEHB20:
	call	_Znwm@PLT
.LEHE20:
	movq	%rax, %rbx
	movl	$1, %r13d
	movq	-80(%rbp), %rsi
	movl	-68(%rbp), %ecx
	movl	-64(%rbp), %edx
	movl	-60(%rbp), %eax
	movq	%rsi, %xmm0
	movl	%eax, %esi
	movq	%rbx, %rdi
.LEHB21:
	call	_ZN4NodeIiiEC1Eiiid
.LEHE21:
	movq	%rbx, -40(%rbp)
	movq	-40(%rbp), %rax
	jmp	.L209
.L208:
	endbr64
	movq	%rax, %r12
	testb	%r13b, %r13b
	je	.L207
	movl	$32, %esi
	movq	%rbx, %rdi
	call	_ZdlPvm@PLT
.L207:
	movq	%r12, %rax
	movq	%rax, %rdi
.LEHB22:
	call	_Unwind_Resume@PLT
.LEHE22:
.L209:
	addq	$56, %rsp
	popq	%rbx
	popq	%r12
	popq	%r13
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3922:
	.section	.gcc_except_table
.LLSDA3922:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE3922-.LLSDACSB3922
.LLSDACSB3922:
	.uleb128 .LEHB20-.LFB3922
	.uleb128 .LEHE20-.LEHB20
	.uleb128 0
	.uleb128 0
	.uleb128 .LEHB21-.LFB3922
	.uleb128 .LEHE21-.LEHB21
	.uleb128 .L208-.LFB3922
	.uleb128 0
	.uleb128 .LEHB22-.LFB3922
	.uleb128 .LEHE22-.LEHB22
	.uleb128 0
	.uleb128 0
.LLSDACSE3922:
	.section	.text._ZN8SkipListIiiE11create_nodeEiiid,"axG",@progbits,_ZN8SkipListIiiE11create_nodeEiiid,comdat
	.size	_ZN8SkipListIiiE11create_nodeEiiid, .-_ZN8SkipListIiiE11create_nodeEiiid
	.section	.text._ZNK4NodeIiiE9get_valueEv,"axG",@progbits,_ZNK4NodeIiiE9get_valueEv,comdat
	.align 2
	.weak	_ZNK4NodeIiiE9get_valueEv
	.type	_ZNK4NodeIiiE9get_valueEv, @function
_ZNK4NodeIiiE9get_valueEv:
.LFB3923:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movl	16(%rax), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE3923:
	.size	_ZNK4NodeIiiE9get_valueEv, .-_ZNK4NodeIiiE9get_valueEv
	.section	.text._ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_,"axG",@progbits,_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_,comdat
	.weak	_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_
	.type	_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_, @function
_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_:
.LFB4052:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4052:
	.size	_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_, .-_ZSt8_DestroyIPSt4pairIS0_IiiEdEEvT_S4_
	.section	.text._ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE,"axG",@progbits,_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE,comdat
	.weak	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	.type	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE, @function
_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE:
.LFB4053:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4053:
	.size	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE, .-_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv:
.LFB4055:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rax
	leaq	8(%rax), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS4_
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L217
	call	__stack_chk_fail@PLT
.L217:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4055:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	.section	.rodata
.LC12:
	.string	"vector::_M_realloc_insert"
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_:
.LFB4056:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$152, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -136(%rbp)
	movq	%rsi, -144(%rbp)
	movq	%rdx, -152(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	-136(%rbp), %rax
	leaq	.LC12(%rip), %rdx
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc
	movq	%rax, -120(%rbp)
	movq	-136(%rbp), %rax
	movq	(%rax), %rax
	movq	%rax, -112(%rbp)
	movq	-136(%rbp), %rax
	movq	8(%rax), %rax
	movq	%rax, -104(%rbp)
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv
	movq	%rax, -128(%rbp)
	leaq	-128(%rbp), %rdx
	leaq	-144(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_
	movq	%rax, -96(%rbp)
	movq	-136(%rbp), %rax
	movq	-120(%rbp), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm
	movq	%rax, -88(%rbp)
	movq	-88(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	-152(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	-96(%rbp), %rdx
	movq	%rdx, %rcx
	salq	$4, %rcx
	movq	-88(%rbp), %rdx
	addq	%rdx, %rcx
	movq	-136(%rbp), %rdx
	movq	%rdx, -72(%rbp)
	movq	%rcx, -64(%rbp)
	movq	%rax, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	-72(%rbp), %rdx
	movq	%rdx, -48(%rbp)
	movq	-64(%rbp), %rdx
	movq	%rdx, -40(%rbp)
	movq	%rax, -32(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rsi
	movl	$16, %edi
	call	_ZnwmPv
	movq	%rax, %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rbx)
	movq	%rdx, 8(%rbx)
	nop
	nop
	movq	$0, -80(%rbp)
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	movq	%rax, %rbx
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	movq	(%rax), %rsi
	movq	-88(%rbp), %rdx
	movq	-112(%rbp), %rax
	movq	%rbx, %rcx
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_
	movq	%rax, -80(%rbp)
	addq	$16, -80(%rbp)
	movq	-136(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	movq	%rax, %rbx
	leaq	-144(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	movq	(%rax), %rax
	movq	-80(%rbp), %rdx
	movq	-104(%rbp), %rsi
	movq	%rbx, %rcx
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_
	movq	%rax, -80(%rbp)
	movq	-136(%rbp), %rax
	movq	-136(%rbp), %rdx
	movq	16(%rdx), %rdx
	subq	-112(%rbp), %rdx
	sarq	$4, %rdx
	movq	-112(%rbp), %rcx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE13_M_deallocateEPS2_m
	movq	-136(%rbp), %rax
	movq	-88(%rbp), %rdx
	movq	%rdx, (%rax)
	movq	-136(%rbp), %rax
	movq	-80(%rbp), %rdx
	movq	%rdx, 8(%rax)
	movq	-120(%rbp), %rax
	salq	$4, %rax
	movq	%rax, %rdx
	movq	-88(%rbp), %rax
	addq	%rax, %rdx
	movq	-136(%rbp), %rax
	movq	%rdx, 16(%rax)
	nop
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L219
	call	__stack_chk_fail@PLT
.L219:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4056:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE17_M_realloc_insertIJS2_EEEvN9__gnu_cxx17__normal_iteratorIPS2_S4_EEDpOT_
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv:
.LFB4060:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE3endEv
	movq	%rax, -24(%rbp)
	leaq	-24(%rbp), %rax
	movl	$1, %esi
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl
	movq	%rax, -16(%rbp)
	leaq	-16(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L222
	call	__stack_chk_fail@PLT
.L222:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4060:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE4backEv
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC5ERKS3_,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_:
.LFB4063:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	nop
	nop
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_Vector_impl_dataC2Ev
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4063:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC1ERKS3_
	.set	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC1ERKS3_,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE12_Vector_implC2ERKS3_
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm:
.LFB4065:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm
	movq	-8(%rbp), %rdx
	movq	%rax, (%rdx)
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 8(%rax)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	movq	-16(%rbp), %rdx
	salq	$4, %rdx
	addq	%rax, %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, 16(%rax)
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4065:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE17_M_create_storageEm
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC5ERKS5_,comdat
	.align 2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_
	.type	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_, @function
_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_:
.LFB4067:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4067:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_, .-_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS5_
	.set	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS5_,_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS5_
	.section	.text._ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_,"axG",@progbits,_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_,comdat
	.weak	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_
	.type	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_, @function
_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_:
.LFB4069:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movb	$0, -2(%rbp)
	movb	$0, -1(%rbp)
	movq	-40(%rbp), %rdx
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4069:
	.size	_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_, .-_ZSt18uninitialized_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_
	.section	.text._ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m,"axG",@progbits,_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m,comdat
	.align 2
	.weak	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m
	.type	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m, @function
_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m:
.LFB4147:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rax
	salq	$4, %rax
	movq	%rax, %rdx
	movq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZdlPvm@PLT
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4147:
	.size	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m, .-_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE10deallocateEPS2_m
	.section	.text._ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_,"axG",@progbits,_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_,comdat
	.weak	_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_
	.type	_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_, @function
_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_:
.LFB4148:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4148:
	.size	_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_, .-_ZNSt12_Destroy_auxILb1EE9__destroyIPSt4pairIS2_IiiEdEEEvT_S6_
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC5ERKS4_,comdat
	.align 2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_
	.type	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_, @function
_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_:
.LFB4151:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	nop
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4151:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_, .-_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS4_
	.set	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS4_,_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC2ERKS4_
	.section	.text._ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc,"axG",@progbits,_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc,comdat
	.align 2
	.weak	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc
	.type	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc, @function
_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc:
.LFB4153:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$72, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -56(%rbp)
	movq	%rsi, -64(%rbp)
	movq	%rdx, -72(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv
	movq	%rax, %rbx
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	subq	%rax, %rbx
	movq	%rbx, %rdx
	movq	-64(%rbp), %rax
	cmpq	%rax, %rdx
	setb	%al
	testb	%al, %al
	je	.L233
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L234
	call	__stack_chk_fail@PLT
.L234:
	movq	-72(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt20__throw_length_errorPKc@PLT
.L233:
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	movq	%rax, %rbx
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	movq	%rax, -40(%rbp)
	leaq	-64(%rbp), %rdx
	leaq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZSt3maxImERKT_S2_S2_
	movq	(%rax), %rax
	addq	%rbx, %rax
	movq	%rax, -32(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE4sizeEv
	cmpq	%rax, -32(%rbp)
	jb	.L235
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv
	cmpq	-32(%rbp), %rax
	jnb	.L236
.L235:
	movq	-56(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv
	jmp	.L237
.L236:
	movq	-32(%rbp), %rax
.L237:
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L239
	call	__stack_chk_fail@PLT
.L239:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4153:
	.size	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc, .-_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE12_M_check_lenEmPKc
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv,comdat
	.align 2
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv:
.LFB4154:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-24(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS4_
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L242
	call	__stack_chk_fail@PLT
.L242:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4154:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE5beginEv
	.section	.text._ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_,"axG",@progbits,_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_,comdat
	.weak	_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_
	.type	_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_, @function
_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_:
.LFB4155:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	movq	(%rax), %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	movq	(%rax), %rax
	movq	%rbx, %rdx
	subq	%rax, %rdx
	movq	%rdx, %rax
	sarq	$4, %rax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4155:
	.size	_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_, .-_ZN9__gnu_cxxmiIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEENS_17__normal_iteratorIT_T0_E15difference_typeERKSB_SE_
	.section	.text._ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm,"axG",@progbits,_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm,comdat
	.align 2
	.weak	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm
	.type	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm, @function
_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm:
.LFB4156:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	cmpq	$0, -32(%rbp)
	je	.L246
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -8(%rbp)
	movq	-8(%rbp), %rcx
	movq	-16(%rbp), %rax
	movl	$0, %edx
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv
	nop
	jmp	.L248
.L246:
	movl	$0, %eax
.L248:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4156:
	.size	_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm, .-_ZNSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE11_M_allocateEm
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_,comdat
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_:
.LFB4157:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	%rcx, -32(%rbp)
	movq	-32(%rbp), %rcx
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rsi
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4157:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_relocateEPS2_S5_S5_RS3_
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv:
.LFB4158:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4158:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl, @function
_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl:
.LFB4160:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movq	-40(%rbp), %rax
	movq	(%rax), %rax
	movq	-48(%rbp), %rdx
	salq	$4, %rdx
	negq	%rdx
	addq	%rdx, %rax
	movq	%rax, -24(%rbp)
	leaq	-24(%rbp), %rdx
	leaq	-16(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEC1ERKS4_
	movq	-16(%rbp), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L256
	call	__stack_chk_fail@PLT
.L256:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4160:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl, .-_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEmiEl
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv:
.LFB4161:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4161:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv
	.section	.text._ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_,"axG",@progbits,_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_,comdat
	.weak	_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_
	.type	_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_, @function
_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_:
.LFB4165:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$32, %rsp
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	%rdx, -24(%rbp)
	movq	-24(%rbp), %rdx
	movq	-16(%rbp), %rcx
	movq	-8(%rbp), %rax
	movq	%rcx, %rsi
	movq	%rax, %rdi
	call	_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4165:
	.size	_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_, .-_ZNSt20__uninitialized_copyILb0EE13__uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS4_IiiEdESt6vectorIS6_SaIS6_EEEEPS6_EET0_T_SF_SE_
	.section	.text._ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv,"axG",@progbits,_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv,comdat
	.align 2
	.weak	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv
	.type	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv, @function
_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv:
.LFB4191:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNKSt12_Vector_baseISt4pairIS0_IiiEdESaIS2_EE19_M_get_Tp_allocatorEv
	movq	%rax, %rdi
	call	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4191:
	.size	_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv, .-_ZNKSt6vectorISt4pairIS0_IiiEdESaIS2_EE8max_sizeEv
	.section	.text._ZSt3maxImERKT_S2_S2_,"axG",@progbits,_ZSt3maxImERKT_S2_S2_,comdat
	.weak	_ZSt3maxImERKT_S2_S2_
	.type	_ZSt3maxImERKT_S2_S2_, @function
_ZSt3maxImERKT_S2_S2_:
.LFB4192:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rdx
	movq	-16(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	jnb	.L264
	movq	-16(%rbp), %rax
	jmp	.L265
.L264:
	movq	-8(%rbp), %rax
.L265:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4192:
	.size	_ZSt3maxImERKT_S2_S2_, .-_ZSt3maxImERKT_S2_S2_
	.section	.text._ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_,"axG",@progbits,_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_,comdat
	.weak	_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_
	.type	_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_, @function
_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_:
.LFB4194:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r12
	pushq	%rbx
	subq	$32, %rsp
	.cfi_offset 12, -24
	.cfi_offset 3, -32
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	%rcx, -48(%rbp)
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_
	movq	%rax, %r12
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_
	movq	%rax, %rdi
	movq	-48(%rbp), %rax
	movq	%rax, %rcx
	movq	%r12, %rdx
	movq	%rbx, %rsi
	call	_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_
	addq	$32, %rsp
	popq	%rbx
	popq	%r12
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4194:
	.size	_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_, .-_ZSt12__relocate_aIPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_
	.section	.text._ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_,"axG",@progbits,_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_,comdat
	.weak	_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_
	.type	_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_, @function
_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_:
.LFB4199:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.L269
.L270:
	leaq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_
	movq	%rbx, %rsi
	movq	%rax, %rdi
	call	_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_
	leaq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv
	addq	$16, -24(%rbp)
.L269:
	leaq	-48(%rbp), %rdx
	leaq	-40(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	testb	%al, %al
	jne	.L270
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4199:
	.size	_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_, .-_ZSt16__do_uninit_copyIN9__gnu_cxx17__normal_iteratorIPKSt4pairIS2_IiiEdESt6vectorIS4_SaIS4_EEEEPS4_ET0_T_SD_SC_
	.section	.text._ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_,"axG",@progbits,_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_,comdat
	.weak	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_
	.type	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_, @function
_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_:
.LFB4210:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$64, %rsp
	movq	%rdi, -56(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -8(%rbp)
	xorl	%eax, %eax
	movabsq	$576460752303423487, %rax
	movq	%rax, -48(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -32(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, -24(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -16(%rbp)
	movabsq	$576460752303423487, %rax
	nop
	nop
	movq	%rax, -40(%rbp)
	leaq	-40(%rbp), %rdx
	leaq	-48(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	_ZSt3minImERKT_S2_S2_
	movq	(%rax), %rax
	movq	-8(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L277
	call	__stack_chk_fail@PLT
.L277:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4210:
	.size	_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_, .-_ZNSt6vectorISt4pairIS0_IiiEdESaIS2_EE11_S_max_sizeERKS3_
	.section	.text._ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv,"axG",@progbits,_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv,comdat
	.align 2
	.weak	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv
	.type	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv, @function
_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv:
.LFB4211:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$48, %rsp
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	%rdx, -40(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, -8(%rbp)
	movabsq	$576460752303423487, %rax
	cmpq	-32(%rbp), %rax
	setb	%al
	movzbl	%al, %eax
	testq	%rax, %rax
	setne	%al
	testb	%al, %al
	je	.L280
	movabsq	$1152921504606846975, %rax
	cmpq	-32(%rbp), %rax
	jnb	.L281
	call	_ZSt28__throw_bad_array_new_lengthv@PLT
.L281:
	call	_ZSt17__throw_bad_allocv@PLT
.L280:
	movq	-32(%rbp), %rax
	salq	$4, %rax
	movq	%rax, %rdi
	call	_Znwm@PLT
	nop
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4211:
	.size	_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv, .-_ZNSt15__new_allocatorISt4pairIS0_IiiEdEE8allocateEmPKv
	.section	.text._ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_,"axG",@progbits,_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_,comdat
	.weak	_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_
	.type	_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_, @function
_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_:
.LFB4212:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4212:
	.size	_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_, .-_ZSt12__niter_baseIPSt4pairIS0_IiiEdEET_S4_
	.section	.text._ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_,"axG",@progbits,_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_,comdat
	.weak	_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_
	.type	_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_, @function
_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_:
.LFB4213:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$56, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -40(%rbp)
	movq	%rsi, -48(%rbp)
	movq	%rdx, -56(%rbp)
	movq	%rcx, -64(%rbp)
	movq	-56(%rbp), %rax
	movq	%rax, -24(%rbp)
	jmp	.L286
.L287:
	movq	-40(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_
	movq	%rax, %rcx
	movq	-64(%rbp), %rax
	movq	%rax, %rdx
	movq	%rbx, %rsi
	movq	%rcx, %rdi
	call	_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_
	addq	$16, -40(%rbp)
	addq	$16, -24(%rbp)
.L286:
	movq	-40(%rbp), %rax
	cmpq	-48(%rbp), %rax
	jne	.L287
	movq	-24(%rbp), %rax
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4213:
	.size	_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_, .-_ZSt14__relocate_a_1IPSt4pairIS0_IiiEdES3_SaIS2_EET0_T_S6_S5_RT1_
	.section	.text._ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_,"axG",@progbits,_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_,comdat
	.weak	_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	.type	_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_, @function
_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_:
.LFB4214:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	movq	(%rax), %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	movq	(%rax), %rax
	cmpq	%rax, %rbx
	setne	%al
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4214:
	.size	_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_, .-_ZN9__gnu_cxxneIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEEbRKNS_17__normal_iteratorIT_T0_EESE_
	.section	.text._ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv,"axG",@progbits,_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv,comdat
	.align 2
	.weak	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv
	.type	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv, @function
_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv:
.LFB4215:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	leaq	16(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	%rdx, (%rax)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4215:
	.size	_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv, .-_ZN9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEppEv
	.section	.text._ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_,"axG",@progbits,_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_,comdat
	.weak	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_
	.type	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_, @function
_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_:
.LFB4216:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4216:
	.size	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_, .-_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv:
.LFB4217:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4217:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEEdeEv
	.section	.text._ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_,"axG",@progbits,_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_,comdat
	.weak	_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_
	.type	_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_, @function
_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_:
.LFB4218:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$24, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -24(%rbp)
	movq	%rsi, -32(%rbp)
	movq	-24(%rbp), %rax
	movq	%rax, %rsi
	movl	$16, %edi
	call	_ZnwmPv
	movq	%rax, %rbx
	movq	-32(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rbx)
	movq	%rdx, 8(%rbx)
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4218:
	.size	_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_, .-_ZSt10_ConstructISt4pairIS0_IiiEdEJRKS2_EEvPT_DpOT0_
	.section	.text._ZSt3minImERKT_S2_S2_,"axG",@progbits,_ZSt3minImERKT_S2_S2_,comdat
	.weak	_ZSt3minImERKT_S2_S2_
	.type	_ZSt3minImERKT_S2_S2_, @function
_ZSt3minImERKT_S2_S2_:
.LFB4225:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	%rsi, -16(%rbp)
	movq	-16(%rbp), %rax
	movq	(%rax), %rdx
	movq	-8(%rbp), %rax
	movq	(%rax), %rax
	cmpq	%rax, %rdx
	jnb	.L299
	movq	-16(%rbp), %rax
	jmp	.L300
.L299:
	movq	-8(%rbp), %rax
.L300:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4225:
	.size	_ZSt3minImERKT_S2_S2_, .-_ZSt3minImERKT_S2_S2_
	.section	.text._ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_,"axG",@progbits,_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_,comdat
	.weak	_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_
	.type	_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_, @function
_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_:
.LFB4227:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$120, %rsp
	.cfi_offset 3, -24
	movq	%rdi, -104(%rbp)
	movq	%rsi, -112(%rbp)
	movq	%rdx, -120(%rbp)
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt4moveIRSt4pairIS0_IiiEdEEONSt16remove_referenceIT_E4typeEOS5_
	movq	-120(%rbp), %rdx
	movq	%rdx, -64(%rbp)
	movq	-104(%rbp), %rdx
	movq	%rdx, -56(%rbp)
	movq	%rax, -48(%rbp)
	movq	-48(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	-64(%rbp), %rdx
	movq	%rdx, -40(%rbp)
	movq	-56(%rbp), %rdx
	movq	%rdx, -32(%rbp)
	movq	%rax, -24(%rbp)
	movq	-32(%rbp), %rax
	movq	%rax, %rsi
	movl	$16, %edi
	call	_ZnwmPv
	movq	%rax, %rbx
	movq	-24(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt7forwardISt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS3_E4typeE
	movq	8(%rax), %rdx
	movq	(%rax), %rax
	movq	%rax, (%rbx)
	movq	%rdx, 8(%rbx)
	nop
	nop
	movq	-112(%rbp), %rax
	movq	%rax, %rdi
	call	_ZSt11__addressofISt4pairIS0_IiiEdEEPT_RS3_
	movq	-120(%rbp), %rdx
	movq	%rdx, -96(%rbp)
	movq	%rax, -88(%rbp)
	movq	-96(%rbp), %rax
	movq	%rax, -80(%rbp)
	movq	-88(%rbp), %rax
	movq	%rax, -72(%rbp)
	nop
	nop
	nop
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4227:
	.size	_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_, .-_ZSt19__relocate_object_aISt4pairIS0_IiiEdES2_SaIS2_EEvPT_PT0_RT1_
	.section	.text._ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv,"axG",@progbits,_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv,comdat
	.align 2
	.weak	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	.type	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv, @function
_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv:
.LFB4228:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4228:
	.size	_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv, .-_ZNK9__gnu_cxx17__normal_iteratorIPKSt4pairIS1_IiiEdESt6vectorIS3_SaIS3_EEE4baseEv
	.section	.text._ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE,"axG",@progbits,_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE,comdat
	.weak	_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE
	.type	_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE, @function
_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE:
.LFB4229:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movq	%rdi, -8(%rbp)
	movq	-8(%rbp), %rax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4229:
	.size	_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE, .-_ZSt7forwardIRKSt4pairIS0_IiiEdEEOT_RNSt16remove_referenceIS5_E4typeE
	.section	.rodata
.LC13:
	.string	":"
	.text
	.type	_Z41__static_initialization_and_destruction_0v, @function
_Z41__static_initialization_and_destruction_0v:
.LFB4231:
	.cfi_startproc
	.cfi_personality 0x9b,DW.ref.__gxx_personality_v0
	.cfi_lsda 0x1b,.LLSDA4231
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%rbx
	subq	$40, %rsp
	.cfi_offset 3, -24
	movq	%fs:40, %rax
	movq	%rax, -24(%rbp)
	xorl	%eax, %eax
	leaq	-33(%rbp), %rax
	movq	%rax, -32(%rbp)
	nop
	nop
	leaq	-33(%rbp), %rax
	movq	%rax, %rdx
	leaq	.LC13(%rip), %rax
	movq	%rax, %rsi
	leaq	_Z9delimiterB5cxx11(%rip), %rax
	movq	%rax, %rdi
.LEHB23:
	call	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEEC1IS3_EEPKcRKS3_
.LEHE23:
	leaq	-33(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorIcED2Ev
	nop
	leaq	__dso_handle(%rip), %rax
	movq	%rax, %rdx
	leaq	_Z9delimiterB5cxx11(%rip), %rax
	movq	%rax, %rsi
	movq	_ZNSt7__cxx1112basic_stringIcSt11char_traitsIcESaIcEED1Ev@GOTPCREL(%rip), %rax
	movq	%rax, %rdi
	call	__cxa_atexit@PLT
	nop
	movq	-24(%rbp), %rax
	subq	%fs:40, %rax
	je	.L309
	jmp	.L311
.L310:
	endbr64
	movq	%rax, %rbx
	leaq	-33(%rbp), %rax
	movq	%rax, %rdi
	call	_ZNSt15__new_allocatorIcED2Ev
	nop
	movq	%rbx, %rax
	movq	-24(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L308
	call	__stack_chk_fail@PLT
.L308:
	movq	%rax, %rdi
.LEHB24:
	call	_Unwind_Resume@PLT
.LEHE24:
.L311:
	call	__stack_chk_fail@PLT
.L309:
	movq	-8(%rbp), %rbx
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4231:
	.section	.gcc_except_table
.LLSDA4231:
	.byte	0xff
	.byte	0xff
	.byte	0x1
	.uleb128 .LLSDACSE4231-.LLSDACSB4231
.LLSDACSB4231:
	.uleb128 .LEHB23-.LFB4231
	.uleb128 .LEHE23-.LEHB23
	.uleb128 .L310-.LFB4231
	.uleb128 0
	.uleb128 .LEHB24-.LFB4231
	.uleb128 .LEHE24-.LEHB24
	.uleb128 0
	.uleb128 0
.LLSDACSE4231:
	.text
	.size	_Z41__static_initialization_and_destruction_0v, .-_Z41__static_initialization_and_destruction_0v
	.section	.rodata
	.type	_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE, @object
	.size	_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE, 1
_ZNSt8__detail30__integer_to_chars_is_unsignedIjEE:
	.byte	1
	.type	_ZNSt8__detail30__integer_to_chars_is_unsignedImEE, @object
	.size	_ZNSt8__detail30__integer_to_chars_is_unsignedImEE, 1
_ZNSt8__detail30__integer_to_chars_is_unsignedImEE:
	.byte	1
	.type	_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE, @object
	.size	_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE, 1
_ZNSt8__detail30__integer_to_chars_is_unsignedIyEE:
	.byte	1
	.type	_ZSt12__is_ratio_vISt5ratioILl1ELl1000000000EEE, @object
	.size	_ZSt12__is_ratio_vISt5ratioILl1ELl1000000000EEE, 1
_ZSt12__is_ratio_vISt5ratioILl1ELl1000000000EEE:
	.byte	1
	.type	_ZSt12__is_ratio_vISt5ratioILl1ELl1EEE, @object
	.size	_ZSt12__is_ratio_vISt5ratioILl1ELl1EEE, 1
_ZSt12__is_ratio_vISt5ratioILl1ELl1EEE:
	.byte	1
	.type	_ZSt12__is_ratio_vISt5ratioILl1000000000ELl1EEE, @object
	.size	_ZSt12__is_ratio_vISt5ratioILl1000000000ELl1EEE, 1
_ZSt12__is_ratio_vISt5ratioILl1000000000ELl1EEE:
	.byte	1
	.text
	.type	_GLOBAL__sub_I_mtx, @function
_GLOBAL__sub_I_mtx:
.LFB4232:
	.cfi_startproc
	endbr64
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	call	_Z41__static_initialization_and_destruction_0v
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE4232:
	.size	_GLOBAL__sub_I_mtx, .-_GLOBAL__sub_I_mtx
	.section	.init_array,"aw"
	.align 8
	.quad	_GLOBAL__sub_I_mtx
	.section	.rodata
	.align 8
.LC0:
	.long	-755914244
	.long	1062232653
	.align 8
.LC1:
	.long	-350469331
	.long	1058682594
	.align 8
.LC4:
	.long	0
	.long	0
	.hidden	DW.ref.__gxx_personality_v0
	.weak	DW.ref.__gxx_personality_v0
	.section	.data.rel.local.DW.ref.__gxx_personality_v0,"awG",@progbits,DW.ref.__gxx_personality_v0,comdat
	.align 8
	.type	DW.ref.__gxx_personality_v0, @object
	.size	DW.ref.__gxx_personality_v0, 8
DW.ref.__gxx_personality_v0:
	.quad	__gxx_personality_v0
	.hidden	__dso_handle
	.ident	"GCC: (Ubuntu 13.2.0-23ubuntu4) 13.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
