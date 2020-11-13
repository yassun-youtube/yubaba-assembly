section .data
    hello_world: db "Hello, World!", 0x0a
    hello_world_len: equ $-hello_world

section .text
global start

start:
    mov rax, 0x2000004        ; システムコールの番号を指定 (syswrite)
    mov rdi, 1                ; 1(STDOUT)を指定
    mov rsi, hello_world      ; Hello, World! が格納されているアドレスを指定
    mov rdx, hello_world_len  ; 何文字読むかを指定
    syscall

    mov rax, 0x2000001        ; システムコールの番号を指定（exit)
    xor rdi, rdi              ; 0 で exit
    syscall
