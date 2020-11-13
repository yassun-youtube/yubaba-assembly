section .text
global start

start:
    mov rax, 0x2000003        ; システムコールの番号を指定 (sysread)
    syscall

    mov rax, 0x2000001        ; システムコールの番号を指定（exit)
    xor rdi, rdi              ; 0 で exit
    syscall
