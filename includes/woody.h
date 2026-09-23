#ifndef WOODY_H
#define WOODY_H

#include <elf.h>

#include "io/bin_io.h"

typedef struct data_s {
	mapped_bin_t *bin;
	Elf64_Ehdr	*header;
} data_t;

#endif
