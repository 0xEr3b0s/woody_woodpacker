#include "libft.h"

char	*ft_strdup(const char *s)
{
	char	*sub;

	sub = (char *)malloc((ft_strlen(s) + 1) * sizeof(char));
	if (!sub)
		return (sub);
	ft_strlcpy(sub, s, ft_strlen(s) + 1);
	return (sub);
}
