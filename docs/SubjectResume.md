### 1.1 Goal

- Encrypt a given program (passed as parameter).
- Only **64-bit ELF files** are accepted.
- Output: a new program called `woody`.
- The new program `woody` must **decrypt and run the original program in an identical way**.

> **Note:** Compression possibilities should be explored.
> It is **strongly recommended** to implement the compression algorithm in assembly.

### 1.2 Mandatory Part (Exo 3)

| Item                        | Requirement                                      |
|-----------------------------|--------------------------------------------------|
| **Executable name**         | `woody-woodpecker`                               |
| **Parameters**              | 64-bit ELF file only                             |
| **Output**                  | `woody` program file                             |
| **Encryption Algorithm**    | Free to choose                                   |
| **Algorithm complexity**    | Important for the defense                        |

#### Encryption Keys
- In case of encryption keys, they must be **randomly generated**.
- The key(s) must be **displayed at the start** of the running time.

#### Behavior of the encrypted program
- When the program is encrypted, it must print:
  ```
  ....Woody....
  ```
  (followed by a newline).
- Execution after encryption **must not crash**.
- The execution of the original program **must not be altered** (i.e. the decrypted program must behave identically to the original).

---

## 2. General Instructions

- Written in **C** (any version) with a **Makefile**.
- **Allowed functions**:
  - `open`, `close`, `exit`
  - `fputs`, `fflush`, `lseek`
  - `mmap`, `munmap`, `mprotect`
  - `perror`, `strerror`
  - `syscall`
  - `printf` family
  - `bzero`
