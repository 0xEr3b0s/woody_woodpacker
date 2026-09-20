global _start

section .text
_start:
    mov rdi, 1          ; stdout
    mov rsi, msg        ; adresse du buffer
    mov rdx, 9          ; longueur
    mov rax, 1          ; write
    syscall

    xor rdi, rdi        ; exit status = 0
    mov rax, 60         ; exit
    syscall

section .data
msg: db "hi there", 10
