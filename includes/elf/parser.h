#ifndef ELF_PARSER_H
# define ELF_PARSER_H

#include <elf.h>

#define ELF_HEADER_SIZE 64 // bytes ( octets )

Elf64_Ehdr *parse_elf(uint8_t *content);

void open_executable(void);

#endif
