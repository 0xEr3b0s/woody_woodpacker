#include <fcntl.h>
#include <unistd.h>

#include "utils/error.h"
#include "io/bin_io.h"


int open_bin(const char *bin) {
	int fd = open(bin, O_RDONLY);
	if (fd == -1) {
		fatal(ERR_OPEN);
	}

	return fd;
}

uint8_t *load_bin(const char *bin_name) {
	uint8_t *content = NULL;
	int fd = open_bin(bin_name);

	

	size_t ex = read(fd, content, 64);
	if (ex == 0) {
		fatal(ERR_READ);
	}

	return content;
}
