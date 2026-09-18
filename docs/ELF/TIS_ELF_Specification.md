---

## 1. Objective

---
---

## Book I: Executable and Linking Format ( ELF )

### Introduction

There are three main type of object files:
- A relocatable file holds code and data suitable for linking with other object files to create an executable or a shared object file.
- An executable file holds a program suitable for execution
- A shared object file holds code and data suitable for linking in two contexts. First, the link editor may process it with other relocatable and shared object files to create another object file. Second, the dynamic linker combines it with an executable file and other shared objects to create a process image.

Object files are binary representation of programs intended to get execute on a processor.

### File format

Object files participate in building a program ( linking ) and running a program ( execution ).

### Object File Format

![[Screenshot 2026-09-18 at 19.39.25.png]]

ELF Header -> reside at the beginning & holds a "road map" describing the file's organization.
Sections -> holds the bulk of object file information for the linking view.

If present, a program header table tells the system how to create a process image. All files used to execute a program must contains a program header table. Relocatable files don't need any.
Section header tables contains information describing the file's sections. Every section has an entry in the table. File used in linking must have a section header table.

### Data Representation



---
