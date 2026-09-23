#include "utils/error.h"
#include "libft.h"

void	print_error(int error)
{
	switch (error)
	{
		case ERR_INVALID_ARG:
			ft_printf("Error: invalid argument\n");
			break ;
		case ERR_TOO_MUCH_ARG:
			ft_printf("Error: wrong number of arguments\n");
			break ;
		case ERR_OPEN:
			ft_printf("Error: cannot open file\n");
			break ;
		case ERR_MAPPING:
			ft_printf("Error: memory mapping failed\n");
			break ;
		case ERR_READ:
			ft_printf("Error: cannot read file\n");
			break ;
		case ERR_INVALID_ELF:
			ft_printf("Error: invalid ELF file\n");
			break ;
		case ERR_TRUNCATED:
			ft_printf("Error: truncated ELF file\n");
			break ;
		case ERR_MALLOC:
			ft_printf("Error: memory allocation failed\n");
			break ;
	}
}
