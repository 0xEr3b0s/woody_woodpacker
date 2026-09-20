---

## 1. Objective

---
---

## Introduction
### 1.1. File Format

![[ELF Object FIle Format.png]]

ELF header is the roadmap of the object file. 
Sections hold the bulk of object file information for the linking view.

### 1.2. Data Representation

What interest me for now is the 64-Bit Data Types

![[64-Bit Data Types.png]]

The size on this schema is the size in bytes of the element. 
The alignment means that the data should be store at a multiple of the alignment value, it's for optimization of the processor, else the processor might be slower.

## 2. ELF Header

### 2.1. Content of the ELF Header

```C
typedef struct {
        unsigned char   e_ident[EI_NIDENT];
        Elf64_Half      e_type;
        Elf64_Half      e_machine;
        Elf64_Word      e_version;
        Elf64_Addr      e_entry;
        Elf64_Off       e_phoff;
        Elf64_Off       e_shoff;
        Elf64_Word      e_flags;
        Elf64_Half      e_ehsize;
        Elf64_Half      e_phentsize;
        Elf64_Half      e_phnum;
        Elf64_Half      e_shentsize;
        Elf64_Half      e_shnum;
        Elf64_Half      e_shstrndx;
} Elf64_Ehdr;
```

e_indent:
	Mark the file as object file. Provide machine-independent data with which to decode and interpret the file's contents.

e_type:
	![[Object Files Types.png]]

e_machine:
	Specifies the required architecture for an individual file.

e_version:
	![[Object File Version Number.png]]

e_entry:
	Gives the virtual address to which the system first transfers control. Holds 0 if no member.

Those are the most interesting variable of the ELF Header.

### 2.3. Data Encoding

Specifies how to interpret the basic object in a file.

![[Data Encoding.png]]

## 3. Sections



---
