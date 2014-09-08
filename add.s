        .global main
.code32
        .text
main:
call puts
        # write(1, message, 13)
       # mov     $1, %rax                # system call 1 is write
       # mov     $1, %rdi                # file handle 1 is stdou
  mov     (%esi), %eax  
add $8, %esi
pushl  %eax
call atoi
mov %eax, %ebx
pushl $format
call puts

mov (%esi), %eax
add $8, %esi
pushl  %eax
call atoi

#	mov $1003, %rax
#	mov $4, %rdx
	add %ebx, %eax        

print:
        # We need to call printf, but we are using eax, ebx, and ecx.  printf
        # may destroy eax and ecx so we will save these before the call and
        # restore them afterwards.

        pushl    %ebx                    # caller-save register
        pushl    %eax                    # caller-save register

        pushl     $format           # set 1st parameter (format)
       # mov     %ebx, %esi              # set 2nd parameter (current_number)
       # xor     %ebx, %eax              # because printf is varargs
	call    printf  
        # Stack is already aligned because we pushed three 8 byte registers
format:
        .asciz  "%20ld\n"


        # exit(0)
       mov     $60, %ebx               # system call 60 is exit
       xor     %edi, %edi              # we want return code 0
        syscall                         # invoke operating system to exit
