#include "libft.h"

size_t	ft_strlcat(char *dst, const char *src, size_t csize)
{
	size_t	slen;
	size_t	dlen;

	slen = ft_strlen(src);
	dlen = ft_strlen(dst);
	if (csize == 0 || dlen >= csize)
		return (csize + slen);
	ft_strlcpy(dst + dlen, src, csize - dlen);
	return (slen + dlen);
}
