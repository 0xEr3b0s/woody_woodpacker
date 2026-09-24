#include "elf/validate_elf.h"
#include "elf/parser_elf.h"
#include "elf/print_elf.h"
#include "utils/error.h"

Elf64_Ehdr *parse_elf(mapped_bin_t *bin) {
	if (bin == NULL || bin->size < ELF_HEADER_SIZE) {
		print_error(ERR_TRUNCATED);
		return NULL;
	}

	if (!is_magic_valid(bin->content)) {
		print_error(ERR_INVALID_ELF);
		return NULL;
	}
	Elf64_Ehdr *ehdr = (Elf64_Ehdr *)bin->content;
	print_ehdr(ehdr);
	return ehdr;
}
