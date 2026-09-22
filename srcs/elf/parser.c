#include "elf/parser.h"

#include "libft.h"
#include "utils/error.h"

int parse_elf(const char *bin_name, Elf64_Ehdr *header) {
	(void)header;
	(void)bin_name;
	ft_printf("test entering parse_elf");
	return ERR_OK;
}

void open_executable(void) {
}
