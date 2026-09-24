#ifndef OPEN_FILE_H
#define OPEN_FILE_H

#include <stdint.h>
#include <unistd.h>

typedef struct mapped_bin_s {
	uint8_t *content;
	size_t size;
} mapped_bin_t;

int open_bin(const char *bin);

// READING
mapped_bin_t *map_bin(int fd);
mapped_bin_t *read_bin(const char *bin_name);

// WRITING

#endif
