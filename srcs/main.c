#include <sys/mman.h>

#include "woody.h"

#include "io/bin_io.h"
#include "utils/error.h"
#include "utils/cleaning.h"
#include "elf/parser_elf.h"

int main(int ac, char **av) {
	data_t datas = { 0 };

	if (ac != 2) {
		print_error(ERR_TOO_MUCH_ARG);
		return ERR_TOO_MUCH_ARG;
	}

	datas.bin = load_bin(av[1]);
	datas.header = parse_elf(datas.bin);

	free_ressources(&datas);

	return 0;
}
