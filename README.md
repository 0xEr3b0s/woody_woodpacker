# woody_woodpacker

![alt text](docs/assets/image.png)

## Overview

A packer for 64-bit ELF binaries, written in C. It takes an executable, encrypts it, and produces a new binary (`woody`) that decrypts itself in memory at runtime and executes identically to the original — while announcing its encrypted state with `....WOODY....` on startup.

## Usage

```
./woody_woodpacker <elf64_binary>
```

- Only 64-bit ELF files are accepted.
- Produces `woody`, the packed binary.
- If the algorithm uses a key, it is randomly generated and printed to stdout.

## Requirements

- Written in C, compiled via `make`.
- Allowed functions: `open`, `close`, `exit`, `fputs`, `fflush`, `lseek`, `mmap`, `munmap`, `mprotect`, `perror`, `strerror`, `syscall`, the `printf` family, and libft-authorized functions.
- No crash allowed, under any usage — error handling must be flawless.
- Memory mapped via `mmap` must always be released with `munmap`.

## How it works

1. Parse the ELF header, section headers, and program headers of the input binary.
2. Locate or create space to host the encrypted payload and the decryption stub.
3. Encrypt the target code section with the chosen algorithm.
4. Redirect the ELF entry point to the injected stub.
5. At runtime: the stub prints `....WOODY....`, decrypts the payload in memory, restores permissions, then jumps to the original entry point.

## Key notions

- **ELF format** — header, program headers (loaded segments + permissions), section headers.
- **Entry point (`e_entry`)** — redirected to the injected stub.
- **`mmap` / `mprotect`** — used to map and adjust memory permissions for decryption.
- **Position-independent stub** — the injected code must run correctly regardless of load address.
- **Encryption algorithm** — must be genuinely complex (a bare XOR/ROT is not accepted); justified at defence.

## Status

- [ ] Compiles cleanly
- [ ] Rejects non-64-bit ELF files
- [ ] Produces a working `woody`
- [ ] `woody` prints `....WOODY....` then runs identically to the original
- [ ] No crashes under edge cases
- [ ] No memory leaks (`mmap`/`munmap` balanced)
- [ ] Norm-compliant
