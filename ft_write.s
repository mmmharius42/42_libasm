default rel                             ; addr absolue -> relative : program can be lunch every where
section .text
global ft_write
extern __errno_location

ft_write:
    mov rax, 1
    syscall

    cmp rax, 0
    jl .error
    ret

.error:
    neg rax
    push rax
    call __errno_location wrt ..plt
    pop qword [rax]
    mov rax, -1
    ret

section .note.GNU-stack noalloc noexec nowrite progbits
