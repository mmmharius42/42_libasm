# libasm x86-64 Assembly Library - Linux ELF64

---

## Main Registers (64-bit)

| Register      | Role                                           |
|---            |---                                            |
| `rax`         | Return value + syscall number                 |
| `rdi`         | 1st argument                                  |
| `rsi`         | 2nd argument                                  |
| `rdx`         | 3rd argument                                  |
| `rbx`         | Preserved register — must be saved before use |
| `rsp / rbp`   | Stack pointer / base pointer                  |

> `al` / `bl` = lower 8-bit part of `rax` / `rbx` (used to read a `char`)

---

## Instructions

| Instruction   | What it does | Example |
|---------------|---------------------------------------------|------------------|
| `mov a, b`    | Copy `b` into `a`                                 | `mov rax, 1` |
| `movzx a, b`  | Copy `b` into `a`, GB set to 0                    | `movzx rax, al` |
| `xor a, a`    | Set `a` to 0 (cheaper than `mov a, 0`)            | `xor rax, rax` |
| `inc a`       | Increment `a` by 1 | `inc rdi`                    |
| `neg a`       | Negate `a` (two's complement)                     | `neg rax` |
| `sub a, b`    | `a = a - b` | `sub rax, rbx`                      |
| `cmp a, b`    | Compute `a - b`, update flags, discard result     | `cmp rax, 0` |
| `push a`      | Push `a` onto the stack                           | `push rbx` |
| `pop a`       | Pop top of stack into `a`                         | `pop rdx` |
| `call fn`     | Call function `fn`                                | `call malloc wrt ..plt` |
| `ret`         | Return to caller                                  | `ret` |
| `syscall`     | Trigger a kernel system call                      | `syscall` |

---

## Jump Instructions

| Instruction | Jumps when… | Flag condition |
|---|---|---|
| `jmp label` | Always | — |
| `je label` | Equal / zero | ZF=1 |
| `jne label` | Not equal | ZF=0 |
| `jl label` | Less (signed) | SF≠OF |

> Flags are set by `cmp a, b` which computes `a - b` without storing the result.

---
## Syscalls Used

| rax | syscall | args                        |
| --- | ------- | --------------------------- |
| `0` | read    | rdi=fd, rsi=buf, rdx=count  |
| `1` | write   | rdi=fd, rsi=buf, rdx=nbytes |

Return value stored in `rax` after `syscall`
> If `rax < 0`, an error occurred.

---

## wrt ..plt

When calling an external function (`malloc`, `__errno_location`, etc.), the linker needs to know where the function is located in memory. `wrt ..plt` tells NASM to use the **PLT** (Procedure Linkage Table) a jump table filled by the dynamic linker at runtime.

```asm
call malloc wrt ..plt
call __errno_location wrt ..plt
```

> Without `wrt ..plt` in ELF64 → relocation error during linking.

---

## errno Handling

When `rax < 0` after a syscall, the negative value *is* the error code.
We store it in `errno` and return `-1`.

```asm
.error:
    neg rax                         ; positive error code
    push rax
    call __errno_location wrt ..plt ; rax -> errno address
    pop rdx
    mov [rax], rdx                  ; errno = error code
    mov rax, -1
    ret
```

---

## Compilation

```bash
make           # compile libasm.a
make main      # compile + link the test main
./libasm       # run the tests
```

```bash
make re && make main && ./libasm
# clean + rebuild + test
```

---

## Implemented Functions

* `ft_strlen`
* `ft_strcpy`
* `ft_strcmp`
* `ft_write`
* `ft_read`
* `ft_strdup`
