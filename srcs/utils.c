#include <stdio.h>
#include <unistd.h>
#include <sys/mman.h>

#include "Woody.h"

#ifdef DEBUG
static const char* get_type_str(uint16_t type) {
    switch (type) {
        case ET_NONE:   return "NONE (None)";
        case ET_REL:    return "REL (Relocatable file)";
        case ET_EXEC:   return "EXEC (Executable file)";
        case ET_DYN:    return "DYN (Position-Independent Executable / Shared Object)";
        case ET_CORE:   return "CORE (Core file)";
        default:        return "UNKNOWN";
    }
}

static const char* get_machine_str(uint16_t machine) {
    switch (machine) {
        case EM_X86_64: return "Advanced Micro Devices x86-64";
        case EM_386:    return "Intel 80386";
        case EM_ARM:    return "ARM";
        case EM_AARCH64:return "ARM AArch64";
        case EM_RISCV:  return "RISC-V";
        default:        return "UNKNOWN";
    }
}

void print_elf_header(data_t *data) {
	Elf64_Ehdr *hdr = data->header;

	printf("=========ELF FILE HEADER=========\n");

	// magic bytes
	printf("Magic: ");
	for (int i = 0; i < EI_NIDENT; i++) {
		printf("%02x ", hdr->e_ident[i]);
	}
	printf("\n");

	// class (32 bit vs 64 bit)
	printf("Class:                   %s\n",
			hdr->e_ident[EI_CLASS] == ELFCLASS64 ? "ELF64" :
			hdr->e_ident[EI_CLASS] == ELFCLASS32 ? "ELF32" : "Invalid");

	// data encoding (endianness)
	printf("Data Encoding:          %s\n",
			hdr->e_ident[EI_DATA] == ELFDATA2LSB ? "2's complement, little endian" :
			hdr->e_ident[EI_DATA] == ELFDATA2MSB ? "2's complement, big endian" : "Invalid");

	// file  metadata & offsets
	printf("Type:                       %s\n", get_type_str(hdr->e_type));
	printf("Machine Architecture:       %s\n", get_machine_str(hdr->e_machine));
	printf("Entry Point Address:        0x%016lx\n", hdr->e_entry);
	printf("Start of Program Headers:   %lu (bytes into file)\n", hdr->e_phoff);
	printf("Start of Section Headers:   %lu (bytes into file)\n", hdr->e_shoff);
	printf("Flags:                      0x%x\n", hdr->e_flags);
	printf("Header Size:                %d bytes\n", hdr->e_ehsize);
	printf("Program Header Count:       %d (size: %d bytes)\n", hdr->e_phnum, hdr->e_phentsize);
	printf("Section Header Count:       %d (size: %d bytes)\n", hdr->e_shnum, hdr->e_shentsize);
	printf("Section Header String Index:%d\n", hdr->e_shstrndx);
	printf("\n");
}
# define WOODY_DEBUG(d) print_elf_header(d)
#else
# define WOODY_DEBUG(d) ((void)0)
#endif

void cleanup(data_t *data) {
	munmap(data->map, data->size);
	close(data->fd);
}
