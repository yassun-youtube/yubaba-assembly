; raxの値をhello_worldと同じ様に標準出力しようとしても失敗する
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

    mov rdx, rax
    mov rax, 0x2000004        ; システムコールの番号を指定 (syswrite)
    mov rdi, 1                ; 1(STDOUT)を指定
    mov rsi, buffer
    syscall

    mov rdi, rax
    mov rax, 0x2000001        ; システムコールの番号を指定（exit)
    syscall
