#include <asm.h>

ENTRY(syscall_sysenter)
	push %ecx
	push %edx
	push $SYSENTER_RETURN
	push %ebp
	mov %esp, %ebp
	sysenter
ENTRY(SYSENTER_RETURN)
	pop %ebp
	pop %edx
	pop %edx
	pop %ecx
	ret

/* int write(int fd, char *buffer, int size) */
ENTRY(write)
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx;  // Save EBX, ESI and EDI if modified
	movl $4, %eax
	movl 0x8(%ebp), %ebx;	//fd
	movl 0xC(%ebp), %ecx;	//buffer
	movl 0x10(%ebp), %edx;	//size
	call syscall_sysenter
	popl %ebx
	test %eax, %eax
	js nok	// if (eax < 0) -> 
	popl %ebp
	ret

/* Common code for negative return */
nok:
	neg %eax
	mov %eax, errno
	mov $-1, %eax
	popl %ebp
	ret

/* int gettime() */
ENTRY(gettime)
	pushl %ebp
	movl %esp, %ebp
	movl $10, %eax
	call syscall_sysenter
	popl %ebp
	ret

ENTRY(getKey)
	pushl %ebp
        movl %esp, %ebp
        pushl %ebx
	movl $16, %eax
	movl 0x8(%ebp), %ebx; //char *b
        call syscall_sysenter
	popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
	popl %ebp
        ret

ENTRY(sbrk)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $18, %eax
        movl 0x8(%ebp), %ebx; //int size
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(spritePut)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $6, %eax
        movl 0x8(%ebp), %ebx; //int posX
	movl 0xC(%ebp), %ecx; //int posY
	movl 0x10(%ebp), %edx; //Sprite* sp
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(gotoXY)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $7, %eax
        movl 0x8(%ebp), %ebx; //int posX
	movl 0xC(%ebp), %ecx; //int posY
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(SetColor)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $8, %eax
        movl 0x8(%ebp), %ebx; //int color
	movl 0xC(%ebp), %ecx; //int background
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(threadCreate)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $11, %eax
	leal thread_create_wrap, %ebx //injecta en 1r param la func wrap
        movl 0x8(%ebp), %ecx; //void (*function)(void* arg)
        movl 0xC(%ebp), %edx; //void* parameter
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(thread_create_wrap)
	pushl %ebp
	movl %esp, %ebp
	
	pushl %ebx
	//habria que considerar si guardar %esi i %edi (pero nosotros no los modificamos)	
	pushl %esi
	pushl %edi

	movl 0x8(%ebp), %ebx //void (*function)(void* arg)
	movl 0xC(%ebp), %esi //void* parameter

	pushl %esi		
	call *%ebx
	popl %esi

	//Terminar el thread llamando al exit
	call threadExit
	
	popl %edi
	popl %esi
	popl %ebx
	popl %ebp
	ret


ENTRY(threadExit)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $12, %eax
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret


ENTRY(semCreate)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $21, %eax
        movl 0x8(%ebp), %ebx; //int initial_value
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(semWait)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $22, %eax
        movl 0x8(%ebp), %ebx; //int semid
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(semSignal)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $23, %eax
        movl 0x8(%ebp), %ebx; //int semid
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret

ENTRY(semDestroy)
        pushl %ebp
        movl %esp, %ebp
        pushl %ebx
        movl $24, %eax
        movl 0x8(%ebp), %ebx; //int semid
        call syscall_sysenter
        popl %ebx
        test %eax, %eax
        js nok  // if (eax < 0) -->
        popl %ebp
        ret


/* int getpid() */
ENTRY(getpid)
	pushl %ebp
	movl %esp, %ebp
	movl $20, %eax
	call syscall_sysenter
	popl %ebp
	ret

/* int fork() */
ENTRY(fork)
	pushl %ebp
	movl %esp, %ebp
	movl $2, %eax
	call syscall_sysenter
	test %eax, %eax
	js nok	// if (eax < 0) -->
	popl %ebp
	ret

/* void exit() */
ENTRY(exit)
	pushl %ebp
	movl %esp, %ebp
	movl $1, %eax
	call syscall_sysenter
	popl %ebp
	ret

/* int yield() */
ENTRY(yield)
	pushl %ebp
	movl %esp, %ebp
	movl $13, %eax
	call syscall_sysenter
	popl %ebp
	ret

/* int get_stats(int pid, struct stats *st) */
ENTRY(get_stats)
	pushl %ebp
	movl %esp, %ebp
	pushl %ebx;  // Save EBX, ESI and EDI if modified
	movl $35, %eax
	movl 0x8(%ebp), %ebx;	//pid
	movl 0xC(%ebp), %ecx;	//st
	call syscall_sysenter
	popl %ebx
	test %eax, %eax
	js nok	// if (eax < 0) -->
	popl %ebp
	ret

ENTRY(SAVE_REGS)
      pushl %eax
      movl %eax, REGS    //SAVE EAX
      lea REGS, %eax
      movl %ebp, 4(%eax)
      movl %edi, 8(%eax)
      movl %esi, 12(%eax)
      movl %edx, 16(%eax)
      movl %ecx, 20(%eax)
      movl %ebx, 24(%eax)
      popl %eax
      ret

ENTRY(RESTORE_REGS)
      lea REGS  , %eax
      movl 4(%eax) , %ebp 
      movl 8(%eax) , %edi 
      movl 12(%eax), %esi 
      movl 16(%eax), %edx 
      movl 20(%eax), %ecx 
      movl 24(%eax), %ebx 
      movl (%eax), %eax
      ret
