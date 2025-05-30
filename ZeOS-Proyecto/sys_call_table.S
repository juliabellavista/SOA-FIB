#include <asm.h>
#include <segment.h>

ENTRY (sys_call_table)
	.long sys_ni_syscall	//0
	.long sys_exit		//1
	.long sys_fork		//2
	.long sys_ni_syscall	//3
	.long sys_write		//4
	.long sys_ni_syscall	//5
	.long sys_spritePut	//6
	.long sys_gotoXY	//7
	.long sys_SetColor	//8
	.long sys_ni_syscall	//9
	.long sys_gettime	//10
	.long sys_threadCreate	//11
	.long sys_threadExit	//12
	.long sys_yield		//13
	.long sys_ni_syscall	//14
	.long sys_ni_syscall	//15
	.long sys_getKey	//16
	.long sys_ni_syscall	//17
	.long sys_sbrk  	//18
	.long sys_ni_syscall	//19
	.long sys_getpid	//20	
	.long sys_semCreate	//21
	.long sys_semWait	//22
	.long sys_semSignal	//23
	.long sys_semDestroy	//24
	.long sys_ni_syscall	//25
	.long sys_ni_syscall	//26
	.long sys_ni_syscall	//27
	.long sys_ni_syscall	//28
	.long sys_ni_syscall	//29
	.long sys_ni_syscall	//30
	.long sys_ni_syscall	//31
	.long sys_ni_syscall	//32
	.long sys_ni_syscall	//33
	.long sys_ni_syscall	//34
	.long sys_get_stats	//35
.globl MAX_SYSCALL
MAX_SYSCALL = (. - sys_call_table)/4
