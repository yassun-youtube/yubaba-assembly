default rel

%define SYSCALL_EXIT     0x2000001
%define SYSCALL_SYSREAD  0x2000003
%define SYSCALL_SYSWRITE 0x2000004

%define STDIN 0
%define STDOUT 1

%define BUFFER_SIZE 64

section .data
    keiyaku: db "契約書だよ。そこに名前を書きな。", 0x0a
    keiyaku_len: equ $-keiyaku

    fun: db "フン。"
    fun_len: equ $-fun

    zeitaku: db "というのかい。贅沢な名だねぇ。", 0x0a
    zeitaku_len: equ $-zeitaku

    imakara: db "今からお前の名前は"
    imakara_len: equ $-imakara

    iikai: db "だ。いいかい、"
    iikai_len: equ $-iikai

    henji: db "だよ。分かったら返事をするんだ、"
    henji_len: equ $-henji

    bikkuri: db "！！", 0x0a
    bikkuri_len: equ $-bikkuri

section .bss
    buffer: resb BUFFER_SIZE

section .text
global start

start:
    mov rsi, keiyaku
    mov rdx, keiyaku_len
    call .syswrite

    call .get_random_one_word
    mov r10, rax              ; save new name to r10
    mov r9, rcx               ; save given name byte length to r9
    sub r9, 1                 ; remove new line

    mov rsi, fun
    mov rdx, fun_len
    call .syswrite

    mov rsi, buffer
    mov rdx, r9
    call .syswrite

    mov rsi, zeitaku
    mov rdx, zeitaku_len
    call .syswrite

    mov rsi, imakara
    mov rdx, imakara_len
    call .syswrite

    call .print_new_name

    mov rsi, iikai
    mov rdx, iikai_len
    call .syswrite

    call .print_new_name

    mov rsi, henji
    mov rdx, henji_len
    call .syswrite

    call .print_new_name

    mov rsi, bikkuri
    mov rdx, bikkuri_len
    call .syswrite

    call .exit

.print_new_name:
    mov rsi, r10
    mov rdx, 3
    call .syswrite
    ret

; return
; rax: address of new name char
; rcx: number of given name characters bytes
.get_random_one_word:
    call .sysread ; set values into buffer and rax has input length
    mov rcx, rax

    xor rdx, rdx
    mov rbx, 3
    idiv rbx      ; rax has length of japanese word
    mov r8, rax  ; store in r8

    rdtsc         ; set random value to rax(this return just clock...)
    xor rdx, rdx
    mov rbx, r8
    idiv rbx      ; get random number from 0 ~ r8-1

    mov r9, rdx
    imul r9, 3    ; set number of 

    mov rax, buffer
    add rax, r9   ; set char address to rax
    ret

.sysread:
    mov rax, SYSCALL_SYSREAD
    mov rdi, STDIN
    mov rsi, buffer
    mov rdx, BUFFER_SIZE
    syscall
    ret

.syswrite:
    mov rax, SYSCALL_SYSWRITE
    mov rdi, STDOUT
    syscall
    ret

.exit:
    mov rax, SYSCALL_EXIT
    xor rdi, rdi
    syscall

.exit_without_rdi:
    mov rax, SYSCALL_EXIT
    syscall
