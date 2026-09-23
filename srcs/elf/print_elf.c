#include <stdio.h>

#include "elf/print_elf.h"

static const char *ehdr_type_str(Elf64_Half type)
{
	switch (type)
	{
		case ET_NONE: return "NONE (aucun)";
		case ET_REL:  return "REL (relogeable)";
		case ET_EXEC: return "EXEC (exécutable)";
		case ET_DYN:  return "DYN (partagé / PIE)";
		case ET_CORE: return "CORE";
		default:      return "inconnu";
	}
}

static const char *ehdr_machine_str(Elf64_Half machine)
{
	switch (machine)
	{
		case EM_X86_64: return "x86-64";
		case EM_386:    return "Intel 80386";
		case EM_AARCH64:return "AArch64";
		default:        return "autre";
	}
}

void print_ehdr(const Elf64_Ehdr *ehdr)
{
	printf("Magic:   ");
	for (int i = 0; i < EI_NIDENT; i++) {
		printf("%02x ", ehdr->e_ident[i]);
	}
	printf("\n");

	printf("Class:                     %s\n",
		ehdr->e_ident[EI_CLASS] == ELFCLASS64 ? "ELF64" :
		ehdr->e_ident[EI_CLASS] == ELFCLASS32 ? "ELF32" : "invalide");
	printf("Data:                      %s\n",
		ehdr->e_ident[EI_DATA] == ELFDATA2LSB ? "little-endian" :
		ehdr->e_ident[EI_DATA] == ELFDATA2MSB ? "big-endian" : "invalide");
	printf("Version (ident):           %d\n", ehdr->e_ident[EI_VERSION]);
	printf("OS/ABI:                    %d\n", ehdr->e_ident[EI_OSABI]);

	printf("Type:                      %s\n", ehdr_type_str(ehdr->e_type));
	printf("Machine:                   %s\n", ehdr_machine_str(ehdr->e_machine));
	printf("Version:                   %#x\n", ehdr->e_version);
	printf("Point d'entree (e_entry):  %#llx\n", (unsigned long long)ehdr->e_entry);
	printf("Debut des Phdr (e_phoff):  %llu\n",  (unsigned long long)ehdr->e_phoff);
	printf("Debut des Shdr (e_shoff):  %llu\n",  (unsigned long long)ehdr->e_shoff);
	printf("Flags:                     %#x\n", ehdr->e_flags);
	printf("Taille en-tete (e_ehsize): %d\n", ehdr->e_ehsize);
	printf("Taille entree Phdr:        %d\n", ehdr->e_phentsize);
	printf("Nombre de Phdr (e_phnum):  %d\n", ehdr->e_phnum);
	printf("Taille entree Shdr:        %d\n", ehdr->e_shentsize);
	printf("Nombre de Shdr (e_shnum):  %d\n", ehdr->e_shnum);
	printf("Index shstrtab:            %d\n", ehdr->e_shstrndx);
}
