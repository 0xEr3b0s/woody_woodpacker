#ifndef WOODY_H
#define WOODY_H

// GENERAL

// ERROR
typedef enum e_error
{
    ERR_OK = 0,
    ERR_INVALID_ARG,
	ERR_TOO_MUCH_ARG,
    ERR_INVALID_ELF,
    ERR_TRUNCATED,
    ERR_MALLOC
}	t_error;

void print_error(int error);

//. ELF
/*

Execution View: ( in the executable )	<- OUR target
	ELF Header 							<- 64 bytes long for 64-Bit binary
	Program Header table
	Section 1
	Section 2
	...
	Section Header table ( optional )

*/

#include <elf.h>

#define ELF_HEADER_SIZE 64 // bytes ( octets )

int parse_elf(Elf64_Ehdr *header);

void open_executable(void);

#endif
