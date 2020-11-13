%define BUFFER_SIZE 64

section .bss
    buffer: resb BUFFER_SIZE

section .text
global start

start:
    mov rax, 0x2000003        ; システムコールの番号を指定 (sysread)
    mov rdi, 0
    mov rsi, buffer
    mov rdx, BUFFER_SIZE
    syscall

    mov rax, 0x2000001        ; システムコールの番号を指定（exit)
    xor rdi, rdi              ; 0 で exit
    syscall

