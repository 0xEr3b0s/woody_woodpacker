#include "libft.h"

char	*ft_strmapi(char const *s, char (*f)(unsigned int, char))
{
	char	*sub;
	size_t	i;

	i = 0;
	sub = (char *)malloc((ft_strlen(s) + 1) * sizeof(char));
	if (!sub)
		return (NULL);
	while (*(s + i))
	{
		sub[i] = f(i, s[i]);
		i++;
	}
	sub[i] = '\0';
	return (sub);
}
