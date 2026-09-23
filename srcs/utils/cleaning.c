#include <stdlib.h>
#include <sys/mman.h>

#include "woody.h"
#include "utils/cleaning.h"

void free_ressources(data_t *datas) {
	if (datas == NULL || datas->bin == NULL) {
		return;
	}

	if (datas->bin->content != NULL && datas->bin->content != MAP_FAILED) {
		munmap(datas->bin->content, datas->bin->size);
	}

	free(datas->bin);
	datas->bin = NULL;
	datas->header = NULL;
}
