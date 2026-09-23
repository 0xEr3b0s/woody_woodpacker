#ifndef ELF_PARSER_H
# define ELF_PARSER_H

#include <elf.h>

#include "io/bin_io.h"

#define ELF_HEADER_SIZE 64 // bytes ( octets )

Elf64_Ehdr *parse_elf(mapped_bin_t *bin);

void open_executable(void);

#endif
