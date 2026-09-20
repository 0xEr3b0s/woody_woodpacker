#include "libft.h"

char	*ft_substr(const char *s, unsigned int start, size_t len)
{
	char	*sub;
	size_t	slen;

	slen = ft_strlen(s);
	if (start >= slen)
		return (ft_strdup(""));
	if (len > slen - start)
		len = slen - start;
	sub = (char *)malloc((len + 1) * sizeof(char));
	if (!sub)
		return (sub);
	ft_strlcpy(sub, s + start, len + 1);
	return (sub);
}
