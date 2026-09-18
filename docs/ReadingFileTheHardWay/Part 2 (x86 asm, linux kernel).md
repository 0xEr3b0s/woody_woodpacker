
[[Reading file the hard way]]

Rust as C or node.js endup using the same functions under the hood. Let's dig that up.

If we run our stdio-powered C program in gdb, and break on `read`, we can confirm that we indeed end up calling a `read` function (which is called `__GI___libc_read` here, but oh well).

Same goes for Rust and node.js.

However, when we try to step through it… nothing. For the sake of the investigation, I cloned the glibc repository (since that’s where the read function seems to live), and found this.

![[Pasted image 20260918153525.png]]

The fonction read don't live in the userland but in the kernel.

![[Pasted image 20260918153616.png]]

Each layer of that circle bring it's own set of permissions.

![[Pasted image 20260918153708.png]]

In image the separation of the utilisation of the CPU by layer 3.

Ring 3 is like a prison, Anybody from circle 0 can visit ring 3 but ring 3 can only send letters to others.
Kernel is handling reading writing etc.

When we open file, the kernel: 
- Decide whether or not this is allowed 
- Asks the VFS who's responsible for this particular path
- Reserve a file descriptor, which is:
	- Just a number
	- unique per processes
- Make a note that this number correspond to that ressource
- Tells us what the number is

lsof allow us to look what fd are open in our program

### Make a syscall

Read syscall isn't the same as the read from glibc.

![[Pasted image 20260918163454.png]]

For exemple Go seems to link to libc too.

Even though, in some respects, Go is a higher-level language than C (it has a garbage collector, it comes with concurrency primitives, etc.), it doesn’t rely on libc to make syscalls.

This contrasts with the Node.js runtime, and the Rust standard library, which both use libc to make syscalls.

### Making a Linux syscall x86_64

All languages need at one point to use syscall one way or the other.
So far we're been using languages that either:
- Use libc to make syscall via a wrapper
- Make syscall for us

Let's try to make syscall by myself.
We'll use yasm to make our syscall.

```
global _start ; _start is our entry point - this is its declaration... 

section .text ; the text section is where we'll put executable code 
_start: xor rdi, rdi ; ...and this is its definition. we just set rdi to 0.
```

This is a very simple program that just put RDI to 0.
Obviously it gonna crash and to make our program exit properly we need to do our very first syscall.

```
		global _start

		section .text
_start: mov rax, 60
		syscall

```

Like that we made a syscall without using libc.

```
global _start

section .text
_start:
    mov     rax, 2          ; sys_open
    mov     rdi, path       ; chemin
    xor     rsi, rsi        ; O_RDONLY
    syscall                 ; retour dans rax

    mov     rax, 60         ; sys_exit
    xor     rdi, rdi        ; exit code = 0
    syscall

section .data
path:
    db "/etc/hosts", 0
```

>[!tip]
>Just for some explaination, the linux convention to do syscall is to put the syscall code in rax and then call syscall
>The kernel with that gonna use the good syscall from the code given

### Final version of the asm

```asm
global _start

section .text
_start:
    ; Ouvrir le fichier /etc/hosts en lecture seule
    mov     rax, 2              ; syscall open
    mov     rdi, path           ; chemin du fichier
    xor     rsi, rsi            ; O_RDONLY
    syscall

    push    rax                 ; sauvegarder le file descriptor
    sub     rsp, 16             ; réserver 16 octets pour le buffer

read_buffer:
    ; Lire jusqu'à 16 octets
    xor     rax, rax            ; syscall read
    mov     rdi, [rsp+16]       ; file descriptor
    mov     rsi, rsp            ; adresse du buffer
    mov     rdx, 16             ; taille max à lire
    syscall

    test    rax, rax            ; est-ce qu'on a lu 0 octet ? (fin de fichier)
    jz      exit

    ; Écrire ce qu'on a lu sur stdout
    mov     rdx, rax            ; nombre d'octets lus
    mov     rax, 1              ; syscall write
    mov     rdi, 1              ; stdout
    mov     rsi, rsp            ; buffer
    syscall

    jmp     read_buffer         ; recommencer

exit:
    ; Quitter proprement
    mov     rax, 60             ; syscall exit
    xor     rdi, rdi            ; code de retour 0
    syscall

section .data
path:   db  "/etc/hosts", 0
```

### Memory mapped files

![[Pasted image 20260918181741.png]]

This is what look like the memory.
In an operating system like Linux, each process has its own **virtual address space**. Some of it is mapped to physical memory, via the Memory management unit (MMU for short).

When a program start few pages are reserved for its stack.
When allocating on the heap, the process is asking the kernel for some more pages. Those are allocated by malloc and libarated by free.

### Using mmap for assembly

A process’s address space refers to _virtual memory_, which is then mapped to physical memory via page tables. When an unmapped range is accessed, it results in a page fault.

Instead of reading parts of files with `read`, we can map them into the virtual address space with `mmap`. Reading from that range will result in the kernel reading the relevant parts of the file.

Executables are memory-mapped when ran (even on Windows).