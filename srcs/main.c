#include <elf.h>

#include "error.h"
#include "elf/parser.h"

int main(void) {
	int ret_code = 0;
	Elf64_Ehdr *header = { 0 };

	ret_code = parse_elf(header);
	if (ret_code != ERR_OK) {
		print_error(ret_code);
		return ret_code;
	}
	return ret_code;
}
