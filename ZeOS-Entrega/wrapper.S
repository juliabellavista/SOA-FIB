#include <asm.h>
#include <segment.h>


ENTRY(write)
	push %ebp
	movl %esp, %ebp

	push %ebx
	push %ecx
	push %edx

	movl 8(%ebp), %edx
	movl 12(%ebp), %ecx
	movl 16(%ebp), %ebx

	movl $4, %eax
	
	push $retorn_w	

	#dynamic link??
	push %ebp
	movl %esp, %ebp

	SYSENTER

retorn_w:
	pop %ebp

	addl $4, %esp
	pop %edx
	pop %ecx
	pop %ebx

	cmpl $0, %eax
	jge fin_w
	negl %eax
	movl %eax, errno
	movl $-1, %eax
fin_w:
	movl %ebp, %esp
        pop %ebp

	ret

ENTRY(gettime)
	push %ebp
        movl %esp, %ebp
	
	movl $10, %eax
	push %ecx
	push %edx

	push $retorn_gt

        #dynamic link??
        push %ebp
        movl %esp, %ebp
	
	SYSENTER
retorn_gt:
	pop %ebp
	addl $4, %esp

	pop %edx
	pop %ecx

	cmpl $0, %eax
        jge fin_gt
        negl %eax
        movl %eax, errno
        movl $-1, %eax
fin_gt:
	movl %ebp, %esp
        pop %ebp
	ret

ENTRY(getpid)
	push %ebp
	movl %esp, %ebp

	movl $20, %eax
	push %ecx
	push %edx	

	push $retorn_gp

	push %ebp
	movl %esp, %ebp

	SYSENTER
retorn_gp:
	pop %ebp
        addl $4, %esp

        pop %edx
        pop %ecx

        cmpl $0, %eax
        jge fin_gp
        negl %eax
        movl %eax, errno
        movl $-1, %eax
fin_gp:
        movl %ebp, %esp
        pop %ebp
        ret

ENTRY(fork)
        push %ebp
        movl %esp, %ebp

        movl $2, %eax
        push %ecx
        push %edx

        push $retorn_gp

        push %ebp
        movl %esp, %ebp

        SYSENTER
retorn_fk:
        pop %ebp
        addl $4, %esp

        pop %edx
        pop %ecx

        cmpl $0, %eax
        jge fin_fk
        negl %eax
        movl %eax, errno
        movl $-1, %eax
fin_fk:
        movl %ebp, %esp
        pop %ebp
        ret

ENTRY(exit)
        push %ebp
        movl %esp, %ebp

        movl $1, %eax
        push %ecx
        push %edx

        push $retorn_ex

        push %ebp
        movl %esp, %ebp

        SYSENTER
retorn_ex:
        pop %ebp
        addl $4, %esp

        pop %edx
        pop %ecx

        cmpl $0, %eax
        jge fin_ex
        negl %eax
        movl %eax, errno
        movl $-1, %eax
fin_ex:
        movl %ebp, %esp
        pop %ebp
        ret

ENTRY(block)
        push %ebp
        movl %esp, %ebp

        movl $14, %eax
        push %ecx
        push %edx

        push $retorn_bl

        #dynamic link??
        push %ebp
        movl %esp, %ebp

        SYSENTER
retorn_bl:
        pop %ebp
        addl $4, %esp

        pop %edx
        pop %ecx

        cmpl $0, %eax
        jge fin_bl
        negl %eax
        movl %eax, errno
        movl $-1, %eax
fin_bl:
        movl %ebp, %esp
        pop %ebp
        ret


ENTRY(unblock)
        push %ebp
        movl %esp, %ebp

        movl $15, %eax
        push %ecx
        push %edx

	movl 8(%ebp), %edx

        push $retorn_ub

        #dynamic link??
        push %ebp
        movl %esp, %ebp

        SYSENTER
retorn_ub:
        pop %ebp
        addl $4, %esp

        pop %edx
        pop %ecx

        cmpl $0, %eax
        jge fin_ub
        negl %eax
        movl %eax, errno
        movl $-1, %eax
fin_ub:
        movl %ebp, %esp
        pop %ebp
        ret

