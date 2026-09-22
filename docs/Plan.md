# Woody Woodpacker — Attack Plan

- [Linux Executable walkthrough](assets/LinuxExecutablewalkthrough.png)

> Each phase has a validation checkpoint.
> Do not move to the next phase until the current checkpoint is validated.

---

## 1. Understand the subject

* [ x ] Read the entire subject.
* [ x ] Identify the required behavior.
* [ x ] Identify constraints and forbidden assumptions.
* [ x ] Define what the final program must achieve.

### Checkpoint

* [ x ] I know exactly what the subject requires.

- [1. Understand the project](1.UnderstandTheProject.md)

---

## 2. Understand ELF64

* [ x ] Understand the ELF64 header.
* [ x ] Understand program headers.
* [ x ] Understand `PT_LOAD`.
* [ x ] Understand `p_offset`, `p_vaddr`, `p_filesz`, `p_memsz`, `p_flags`, and `p_align`.
* [ x ] Understand the entry point.
* [ x ] Understand how an ELF is mapped into memory.

### Checkpoint

* [ ] I can explain the role of `Elf64_Ehdr`.
* [ ] I can explain the role of `Elf64_Phdr`.
* [ ] I can explain how a `PT_LOAD` segment maps file data to memory.
* [ ] I understand the relationship between file offsets and virtual addresses.
* [ ] I can explain how execution reaches the entry point.

- [ELF64](https://youtu.be/nC1U1LJQL8o?si=U4bzHqHuurjccAk5)

---

## 4. Build the ELF parser

* [ ] Read and validate the ELF header.
* [ ] Parse program headers.
* [ ] Identify relevant segments.
* [ ] Expose the information needed by the rest of the project.
* [ ] Handle invalid ELF files.

### Checkpoint

* [ ] My parser correctly handles valid ELF64 binaries.
* [ ] My parser rejects invalid input cleanly.
* [ ] I can retrieve every ELF value needed by the packer.
* [ ] ELF-specific logic is isolated inside the `elf` module.

---

## 5. Set up I/O

* [ ] Implement file reading.
* [ ] Implement file writing.
* [ ] Handle file errors.
* [ ] Handle resource cleanup.
* [ ] Preserve the required file properties.

### Checkpoint

* [ ] I can load an ELF completely into memory.
* [ ] I can write it back without unintended modifications.
* [ ] Errors are handled correctly.
* [ ] No resources are leaked.

---

## 6. Design the packer

* [ ] Determine what part of the ELF must be modified.
* [ ] Determine where the encrypted data will live.
* [ ] Determine where the stub will live.
* [ ] Determine how the original entry point will be preserved.
* [ ] Define the runtime execution flow.

### Checkpoint

* [ ] I can draw the complete before/after ELF layout.
* [ ] I know exactly which ELF structures will change.
* [ ] I know where the stub and encrypted data will be placed.
* [ ] I know how execution will reach the stub.
* [ ] I know how the original program will resume execution.

---

## 7. Implement encryption

* [ ] Implement the required encryption mechanism.
* [ ] Implement the corresponding decryption logic.
* [ ] Define the data required by the stub.
* [ ] Test encryption independently.

### Checkpoint

* [ ] Encryption produces the expected result.
* [ ] Decryption restores the original data.
* [ ] The encrypted region is clearly defined.
* [ ] The stub has everything it needs to decrypt it.

---

## 8. Develop the stub

* [ ] Understand the required x86-64 instructions.
* [ ] Understand the relevant calling convention.
* [ ] Understand position-independent execution where required.
* [ ] Implement the decryption logic.
* [ ] Implement the transfer back to the original program.

### Checkpoint

* [ ] The stub builds correctly.
* [ ] The stub can execute independently.
* [ ] The stub can decrypt the protected data.
* [ ] The stub can transfer execution to the original entry point.
* [ ] The original program still behaves correctly.

---

## 9. Integrate the stub and modify the ELF

* [ ] Inject the stub.
* [ ] Inject the required metadata/data.
* [ ] Modify the relevant ELF structures.
* [ ] Update offsets and addresses.
* [ ] Handle alignment correctly.
* [ ] Redirect the entry point.

### Checkpoint

* [ ] The generated file is still a valid ELF.
* [ ] `readelf` reports coherent headers and segments.
* [ ] The stub is located where expected.
* [ ] The encrypted data is located where expected.
* [ ] Execution reaches the stub.

---

## 10. Full integration

* [ ] Connect `io`, `elf`, `crypto`, and `packer`.
* [ ] Implement the complete packing process.
* [ ] Generate the final packed binary.
* [ ] Execute the packed binary.

### Checkpoint

* [ ] `./woody_woodpacker <binary>` produces the expected output.
* [ ] The generated binary executes.
* [ ] The stub decrypts the protected data.
* [ ] Execution reaches the original program.
* [ ] The original program behaves correctly.

---

## 11. Testing

* [ ] Test a minimal ELF.
* [ ] Test dynamically linked binaries.
* [ ] Test PIE binaries if required.
* [ ] Test different segment layouts.
* [ ] Test different program sizes.
* [ ] Test programs using arguments.
* [ ] Test programs using stdin/stdout.
* [ ] Test invalid ELF files.
* [ ] Test error cases.

### Checkpoint

* [ ] All required test cases pass.
* [ ] Error cases behave correctly.
* [ ] Original and packed binaries behave equivalently where required.
* [ ] No obvious memory/resource issues remain.

---

## 12. Final cleanup

* [ ] Review memory management.
* [ ] Review file descriptor management.
* [ ] Review error handling.
* [ ] Verify permissions.
* [ ] Verify offsets and alignment.
* [ ] Run `valgrind`.
* [ ] Run regression tests.
* [ ] Clean up the Makefile.
* [ ] Remove unnecessary code/debugging.
* [ ] Review the project against the subject one final time.

### Final Checkpoint

* [ ] The project follows the subject completely.
* [ ] The project builds from a clean checkout.
* [ ] All tests pass.
* [ ] No known leaks or resource issues remain.
* [ ] The code is understandable and maintainable.
* [ ] I can explain every important part of the implementation.

---

# Priority

```text
  Subject
    ↓
  ELF64
    ↓
  Program Headers / PT_LOAD
    ↓
  Binary analysis
    ↓
  ELF parser
    ↓
  I/O
    ↓
  Packer design
    ↓
  Encryption
    ↓
  ASM stub
    ↓
  ELF modification
    ↓
  Integration
    ↓
  Testing
    ↓
  Cleanup
```
