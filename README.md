# libasm

Reimplementation of standard libc functions in x86-64 assembly (Intel syntax, NASM).

## Objective

Get familiar with assembly language by reimplementing low-level functions: string manipulation, syscalls, and error handling via `errno`.

## Requirements

- 64-bit code only, respect the **x86-64 calling convention**
- **Intel** syntax (not AT&T)
- Assembler: **NASM** only (`.s` files)
- No inline ASM
- `-no-pie` flag is forbidden
- Proper syscall error handling + `errno` update (`__error` / `__errno_location`)

## Implemented Functions

| Function | Description |
|---|---|
| `ft_strlen` | String length |
| `ft_strcpy` | String copy |
| `ft_strcmp` | String comparison |
| `ft_write` | write syscall |
| `ft_read` | read syscall |
| `ft_strdup` | String duplication (malloc call allowed) |

## Compilation

```bash
make        # build libasm.a
make bonus  # build with bonus functions
make clean  # remove object files
make fclean # remove object files and libasm.a
make re     # full rebuild
```

To test:

```bash
make && gcc main.c -L. -lasm -o test && ./test
```

## Resources

- [Cours nasm](https://lacl.u-pec.fr/tan/asm.pdf)
- [NASM Documentation](https://www.nasm.us/doc/)
- [x86-64 Calling Convention (System V ABI)](https://refspecs.linuxbase.org/elf/x86_64-abi-0.99.pdf)
- [Linux Syscall Table x86-64](https://blog.rchapman.org/posts/Linux_System_Call_Table_for_x86_64/)
- [Intel x86 Instruction Reference](https://www.felixcloutier.com/x86/)
- [OSDev Wiki – x86-64](https://wiki.osdev.org/X86-64)