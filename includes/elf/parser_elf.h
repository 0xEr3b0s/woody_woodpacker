#ifndef ELF_PARSER_H
# define ELF_PARSER_H

#include <elf.h>

#include "io/bin_io.h"

#define ELF_HEADER_SIZE 64 // bytes ( octets )

typedef struct elf_view_s {
	const Elf64_Ehdr *ehdr;

	const Elf64_Phdr *phdrs;
	uint16_t phdrs_count;

	const Elf64_Phdr *target_pt_load;
	
	Elf64_Off entrypoint_file_offset;
} elf_view_t;

Elf64_Ehdr *parse_elf(mapped_bin_t *bin);

void open_executable(void);

#endif
