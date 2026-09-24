#include "elf/validate_elf.h"

bool is_magic_valid(const uint8_t *magic) {
	if (magic[0] == ELFMAG0 && magic[1] == ELFMAG1 && magic[2] == ELFMAG2 && magic[3] == ELFMAG3) {
		return true;
	}

	return false;
}
