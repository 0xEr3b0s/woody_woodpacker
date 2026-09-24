#include <fcntl.h>
#include <unistd.h>
#include <sys/mman.h>
#include <stdlib.h>

#include "utils/error.h"
#include "io/bin_io.h"

int open_bin(const char *bin) {
	int fd = open(bin, O_RDONLY);
	if (fd < 0) {
		print_error(ERR_OPEN);
	}
	return fd;
}

mapped_bin_t *map_bin(int fd) {
	off_t fsize = lseek(fd, 0, SEEK_END);
	if (fsize < 0) {
		print_error(ERR_READ);
		return NULL;
	}

	void *content = mmap(NULL, fsize, PROT_READ, MAP_PRIVATE, fd, 0);
	if (content == MAP_FAILED) {
		print_error(ERR_MAPPING);
		return NULL;
	}

	mapped_bin_t *mapped = malloc(sizeof(*mapped));
	if (mapped == NULL) {
		munmap(content, fsize);
		print_error(ERR_MALLOC);
		return NULL;
	}

	mapped->content = content;
	mapped->size = (size_t)fsize;
	return mapped;
}

mapped_bin_t *read_bin(const char *bin_name) {
	int fd = open_bin(bin_name);
	if (fd < 0) {
		return NULL;
	}

	mapped_bin_t *bin = map_bin(fd);
	close(fd);
	return bin;
}
