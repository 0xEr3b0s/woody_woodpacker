#include <stdlib.h>
#include <sys/mman.h>
#include <elf.h>

#include "woody.h"
#include "elf/parser_elf.h"
#include "utils/cleaning.h"

void free_ressources(data_t *datas) {
	munmap(datas->bin->content, ELF_HEADER_SIZE);
	free(datas->bin);
}
