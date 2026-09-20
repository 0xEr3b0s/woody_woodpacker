
---

## 1. Read and understand the subject

- Goal: Identify exactly what the 42 subject requires before writing code.

## 2. Understand ELF64

- [ELF — Linux man page](https://man7.org/linux/man-pages/man5/elf.5.html)
- Focus on: `Elf64_Ehdr`, `Elf64_Phdr`, `PT_LOAD`, `PT_NOTE`, entry point, offsets, virtual addresses.

## 3. Write a minimal ELF parser

- [readelf — Linux man page](https://man7.org/linux/man-pages/man1/readelf.1.html)
- Goal: Write your own small program that displays the important ELF information, then compare it with `readelf`.

## 4. Understand how Linux loads an ELF

- [How Programs Get Run — LWN](https://lwn.net/Articles/631631/)
- Focus on: `execve()` → kernel → `PT_LOAD` → memory → `PT_INTERP` → dynamic loader → entry point.

## 5. Understand program segments

- [ELF — Program Loading](https://gabi.xinuos.com/elf/07-loading-intro.html)
- Goal: Understand exactly how file contents map to memory.

## 6. Analyze binaries with `readelf` and `objdump`

- [readelf](https://man7.org/linux/man-pages/man1/readelf.1.html)
- Goal: Analyze several executables with:
    - `readelf -h`
    - `readelf -l`
    - `readelf -S`
    - `readelf -d`
    - `readelf -r`
    - `readelf -s`

## 7. Learn the assembly required for the stub

- [System V AMD64 ABI](https://gitlab.com/x86-psABIs/x86-64-ABI)
- [x86-64 Assembly Reference](https://www.cs.uaf.edu/2017/fall/cs301/reference/x86_64.html)
- Goal: Understand registers, stack, calling conventions, return addresses, and position-independent code.

## 8. Design the packer before implementing it

```
Original ELF
    ↓
Analyze
    ↓
Choose the protected area
    ↓
Encrypt
    ↓
Inject stub
    ↓
Modify ELF
    ↓
New ELF
```

- Goal: Decide exactly which headers/segments you modify and how the original entry point will be recovered.

## 9. Write the ASM stub independently

- [NASM Tutorial](https://cs.lmu.edu/~ray/notes/nasmtutorial/)
- Goal: Get a minimal standalone stub working before integrating it into an ELF.

## 10. Integrate the stub into the ELF

- [ELF — Program Loading](https://man7.org/linux/man-pages/man5/elf.5.html)
- Goal: Place the stub correctly, modify the required ELF fields, and redirect execution temporarily.

## 11. Implement the encryption in C

- Goal: Encrypt the area required by the subject and keep the information needed by the stub to decrypt it.

## 12. Make the complete execution chain work

```
./woody_woodpacker prog
        ↓
      woody
        ↓
   stub executes
        ↓
    decryption
        ↓
 original entry point
        ↓
    program
```

## 13. Test methodically

Test progressively:

```
✓ Small ELF
✓ Dynamically linked ELF
✓ PIE ELF
✓ Different numbers of segments
✓ Different .text sizes
✓ Programs with arguments
✓ Programs using stdin/stdout
✓ Invalid ELF / error cases
```

## 14. Final cleanup

- Check offsets and alignment.
- Handle errors correctly.
- Review `mmap`, `open`, `read`, and `write` usage.
- Preserve executable permissions.
- Run `valgrind`.
- Compare ELF files before/after with `readelf`.
- Add regression tests.

## Priority Order

```
Subject
  ↓
ELF64
  ↓
Program Headers / PT_LOAD
  ↓
readelf + binary analysis
  ↓
Linux ELF loading
  ↓
x86-64 ASM + ABI
  ↓
Stub
  ↓
ELF modification
  ↓
Encryption
  ↓
Integration
  ↓
Testing
```

Main focus: Spend the most time understanding `ELF64 → Program Headers → PT_LOAD → memory loading` before implementing the packer. This is the foundation for the rest of the project.