#ifndef WOODY_H
#define WOODY_H

#include <elf.h>

// FLAGS
#define DEBUG_PRINT 0
#define NO_GUILTY ""

typedef struct data_s {
	Elf64_Ehdr *header;		// Only elf header part
	void *map;				// the whole file mapped
	int size;					// whole file size
	int fd;
} data_t;

#ifdef DEBUG
void print_elf_header(data_t *data);
# define WOODY_DEBUG(d) print_elf_header(d)
#else
# define WOODY_DEBUG(d) ((void)0)
#endif

// ELF
void validate_elf(char *file_name, data_t *data);

void modify_header(data_t *data);
void modify_segment(data_t *data);
void modify_section(data_t *data);


// UTILS
void cleanup(data_t *data);
void print_exit(int code, char *str, int fd, char *guilty);

#endif
