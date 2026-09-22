#include "woody.h"

#include "utils/error.h"
#include "elf/parser.h"
#include "io/bin_io.h"

int main(int ac, char **av) {
	data_t datas = { 0 };

	if (ac != 2) {
		print_error(ERR_TOO_MUCH_ARG);
		return ERR_TOO_MUCH_ARG;
	}

	datas.bin_content = load_bin(av[1]);
	datas.header = parse_elf(datas.bin_content);

	return 0;
}
