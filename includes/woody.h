#ifndef WOODY_H
#define WOODY_H

#include <elf.h>

typedef struct data_s {
	Elf64_Ehdr	*header;
	uint8_t		*bin_content;
} data_t;

#endif
