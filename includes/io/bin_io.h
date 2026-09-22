#ifndef OPEN_FILE_H
#define OPEN_FILE_H

#include <stdint.h>

int open_bin(const char *bin);
uint8_t *load_bin(const char *bin_name);

#endif
