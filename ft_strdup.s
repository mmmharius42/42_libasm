section .text
global ft_strdup
extern malloc
extern ft_strlen
extern ft_strcpy

ft_strdup:
    push rbx
    mov rbx, rdi
    call ft_strlen
    inc rax
    mov rdi, rax
    call malloc wrt ..plt
    cmp rax, 0
    je .error
    mov rdi, rax
    mov rsi, rbx
    call ft_strcpy
    pop rbx
    ret

.error:
    pop rbx
    xor rax, rax
    ret

section .note.GNU-stack noalloc noexec nowrite progbits