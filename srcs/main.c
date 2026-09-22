#include <elf.h>

#include "utils/error.h"
#include "elf/parser.h"

int main(int ac, char **av) {
	int ret_code = 0;
	Elf64_Ehdr *header = { 0 };

	if (ac != 2) {
		print_error(ERR_TOO_MUCH_ARG);
		return ERR_TOO_MUCH_ARG;
	}

	ret_code = parse_elf(header);
	if (ret_code != ERR_OK) {
		print_error(ret_code);
		return ret_code;
	}
	return ret_code;
}
