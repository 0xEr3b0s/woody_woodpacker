#ifndef ELF_PARSER_H
# define ELF_PARSER_H

/*

Linking view: ( in the .o file )
	ELF Header
	Program Header table ( optional )
	Section 1
	...
	Section n
	Section Header table

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
