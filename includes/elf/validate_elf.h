#ifndef VALIDATE_ELF_H
#define VALIDATE_ELF_H

#include <elf.h>
#include <stdbool.h>

bool is_magic_valid(const uint8_t *header);

#endif
