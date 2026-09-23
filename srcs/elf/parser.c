#include "libft.h"
#include "elf/parser_elf.h"
#include "elf/print_elf.h"

Elf64_Ehdr *parse_elf(mapped_bin_t *bin) {
	Elf64_Ehdr *Ehdr = 0;
	Elf64_Phdr *Phdr = 0;

	ft_memcpy((void *)Ehdr, bin->content, ELF_HEADER_SIZE); // <- save only the 64 first into ELF header
	print_ehdr(Ehdr);
	ft_memcpy((void *)Phdr, (const void *)bin->content + 64, bin->size); // <- saving from after the ELF header to then end into program header

	return 0;
}

void open_executable(void) {
}
