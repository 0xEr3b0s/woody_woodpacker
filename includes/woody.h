#ifndef WOODY_H
#define WOODY_H

#include <elf.h>

#include "io/bin_io.h"
#include "elf/parser_elf.h"

typedef struct data_s {
	mapped_bin_t	*bin;
	elf_view_t		*view;
} data_t;

#endif
