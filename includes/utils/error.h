#ifndef ERROR_H
#define ERROR_H

typedef enum e_error
{
	ERR_OK = 0,
	ERR_INVALID_ARG,
	ERR_TOO_MUCH_ARG,
	ERR_OPEN,
	ERR_MAPPING,
	ERR_READ,
	ERR_INVALID_ELF,
	ERR_TRUNCATED,
	ERR_MALLOC
}	t_error;

void print_error(int error);
void fatal(int error);

#endif
