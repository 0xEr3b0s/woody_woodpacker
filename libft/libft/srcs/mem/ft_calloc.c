#include "libft.h"

void	*ft_calloc(size_t elnum, size_t elsize)
{
	void	*ptr;

	if (elsize != 0 && elnum > ((size_t)-1) / elsize)
		return (NULL);
	ptr = malloc(elnum * elsize);
	if (!ptr)
		return (ptr);
	ft_bzero(ptr, elnum * elsize);
	return (ptr);
}
