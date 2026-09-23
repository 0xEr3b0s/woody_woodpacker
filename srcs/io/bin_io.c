#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdlib.h>

#include "utils/error.h"
#include "io/bin_io.h"

int open_bin(const char *bin) {
	int fd = open(bin, O_RDONLY);
	if (fd == -1) {
		fatal(ERR_OPEN);
	}

	return fd;
}

mapped_bin_t *map_bin(int fd) {
	mapped_bin_t *mapped = (mapped_bin_t *)malloc(sizeof(mapped_bin_t));
	size_t fsize = lseek(fd, 0, SEEK_END);
	uint8_t *content = mmap(NULL, fsize, PROT_READ, MAP_PRIVATE, fd, 0);
	if (mapped == MAP_FAILED) {
		fatal(ERR_MAPPING);
	}

	mapped->content = content;
	mapped->size = fsize;

	return mapped;
}

mapped_bin_t *load_bin(const char *bin_name) {
	int fd = open_bin(bin_name);

	return map_bin(fd);
}
