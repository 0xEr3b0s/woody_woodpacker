#include <stdlib.h>

#include "elf/validate_elf.h"
#include "elf/parser_elf.h"
#include "elf/print_elf.h"
#include "utils/error.h"
#include "libft.h"

static elf_view_t *init_view(void) {
	elf_view_t *view = NULL;

	view = (elf_view_t *)malloc(sizeof(elf_view_t));
	if (!view) {
		return NULL;
	}

	if (ft_memset(view, 0, sizeof(elf_view_t)) == NULL) {
		return NULL;
	}
	return view;
}

elf_view_t *parse_elf(mapped_bin_t *bin) {
	if (bin == NULL || bin->size < ELF_HEADER_SIZE) {
		print_error(ERR_TRUNCATED);
		return NULL;
	}

	if (!is_magic_valid(bin->content)) {
		print_error(ERR_INVALID_ELF);
		return NULL;
	}

	elf_view_t *view = init_view();
	if (view == NULL) {
		return NULL;
	}

	view->ehdr = (Elf64_Ehdr *)bin->content;
	print_ehdr(view->ehdr);

	return view;
}
