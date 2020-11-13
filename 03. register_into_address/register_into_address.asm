section .bss
    new_name resb 64

section .text
global start

start:
    mov rax, 10
    mov [new_name], rax

    mov rdi, rax
    mov rax, 0x2000001        ; システムコールの番号を指定（exit)
    syscall
