# ============================================================================
#  woody_woodpacker — Makefile
#
#  Directory structure:
#    srcs/      -> C and assembly source files (recursive)
#    includes/  -> header files
#    libft/     -> libft library
#    tests/     -> test source files + test.h (recursive)
#    tests/bin/ -> test binaries (generated)
#    obj/       -> generated object files
# ============================================================================

NAME          := woody_woodpacker

CC            := cc
CFLAGS        := -Wall -Wextra -Werror
ASFLAGS       := -f elf64

SRCS_DIR      := srcs
INC_DIR       := includes
OBJ_DIR       := obj
TESTS_DIR     := tests
TESTS_BIN_DIR := $(TESTS_DIR)/bin

# --- libft ------------------------------------------------------------------
LIBFT_DIR     := libft
LIBFT         := $(LIBFT_DIR)/libft.a

# --- Sources ----------------------------------------------------------------
SRCS_C        := $(shell find $(SRCS_DIR) -type f -name '*.c' 2>/dev/null)
SRCS_S        := $(shell find $(SRCS_DIR) -type f -name '*.s' 2>/dev/null)

# Exclude main.c for unit tests
SRCS_C_NO_MAIN := $(filter-out $(SRCS_DIR)/main.c,$(SRCS_C))

OBJS_C        := $(patsubst $(SRCS_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS_C))
OBJS_C_NO_MAIN:= $(patsubst $(SRCS_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS_C_NO_MAIN))
OBJS_S        := $(patsubst $(SRCS_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS_S))

OBJS          := $(OBJS_C) $(OBJS_S)
OBJS_NO_MAIN  := $(OBJS_C_NO_MAIN) $(OBJS_S)

# --- Dependencies -----------------------------------------------------------
DEPS          := $(OBJS_C:.o=.d)

# --- Tests (recursive) ------------------------------------------------------
TESTS_SRCS    := $(shell find $(TESTS_DIR) -type f -name '*.c' -not -path '$(TESTS_BIN_DIR)/*' 2>/dev/null)
TESTS_BINS    := $(patsubst $(TESTS_DIR)/%.c,$(TESTS_BIN_DIR)/%,$(TESTS_SRCS))

# --- Include directories ----------------------------------------------------
# -I$(TESTS_DIR) pour pouvoir faire #include "test.h"
CPPFLAGS      := -I$(INC_DIR) -I$(LIBFT_DIR)/includes -I$(TESTS_DIR)
DEPFLAGS      := -MMD -MP

# --- Assembler --------------------------------------------------------------
AS            := nasm

# --- Make flags -------------------------------------------------------------
MAKEFLAGS     += --no-print-directory

# --- Colors -----------------------------------------------------------------
GREEN         := \033[0;32m
RED           := \033[0;31m
YELLOW        := \033[0;33m
CYAN          := \033[0;36m
BOLD          := \033[1m
RESET         := \033[0m

# ============================================================================
#  Main rules
# ============================================================================

all: $(NAME)

$(NAME): $(LIBFT) $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) $(LIBFT) -o $(NAME)
	@echo "$(GREEN)[✓] $(NAME) compiled$(RESET)"

# ============================================================================
#  libft
# ============================================================================

$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR)

# ============================================================================
#  Object compilation
# ============================================================================

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.s
	@mkdir -p $(dir $@)
	@$(AS) $(ASFLAGS) $< -o $@

# ============================================================================
#  Tests
# ============================================================================

tests: $(LIBFT) $(OBJS_NO_MAIN) $(TESTS_BINS)
	@echo "$(GREEN)[✓] unit tests compiled$(RESET)"

# Compile chaque fichier de test → tests/bin/...
$(TESTS_BIN_DIR)/%: $(TESTS_DIR)/%.c $(OBJS_NO_MAIN) $(LIBFT)
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(CPPFLAGS) $< $(OBJS_NO_MAIN) $(LIBFT) -o $@

# Lance tous les tests
test: tests
	@echo ""
	@failed=0; \
	if [ -z "$(TESTS_BINS)" ]; then \
		echo "$(YELLOW)[!] No test files found in $(TESTS_DIR)/$(RESET)"; \
		exit 0; \
	fi; \
	for test in $(TESTS_BINS); do \
		name=$$(echo $$test | sed 's|$(TESTS_BIN_DIR)/||'); \
		echo "$(CYAN)$(BOLD)>>> Running $$name$(RESET)"; \
		if timeout 5s ./$$test; then \
			echo "$(GREEN)[✓] $$name passed$(RESET)"; \
		else \
			echo "$(RED)[✗] $$name failed$(RESET)"; \
			failed=1; \
		fi; \
		echo ""; \
	done; \
	if [ $$failed -eq 0 ]; then \
		echo "$(GREEN)$(BOLD)[✓] ALL TEST SUITES PASSED$(RESET)"; \
	else \
		echo "$(RED)$(BOLD)[✗] SOME TEST SUITES FAILED$(RESET)"; \
		exit 1; \
	fi

# ============================================================================
#  Cleanup
# ============================================================================

clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)[✓] object files removed$(RESET)"

clean_tests:
	@rm -rf $(TESTS_BIN_DIR)
	@find $(TESTS_DIR) -type f -executable -not -name '*.c' -not -name '*.h' -delete 2>/dev/null || true
	@echo "$(GREEN)[✓] test binaries removed$(RESET)"

fclean: clean clean_tests
	@$(MAKE) -C $(LIBFT_DIR) fclean
	@rm -f $(NAME)
	@echo "$(GREEN)[✓] $(NAME) removed$(RESET)"

re: fclean all

# ============================================================================
#  Dependencies
# ============================================================================

-include $(DEPS)

.PHONY: all clean fclean re tests test clean_tests
