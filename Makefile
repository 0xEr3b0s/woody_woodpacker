# ============================================================================
#  woody_woodpacker — Makefile
#
#  Directory structure:
#    srcs/                 -> C and assembly source files (recursive)
#    includes/             -> header files
#    libft/                -> libft library
#    tests/srcs/           -> test source files (recursive)
#    tests/includes/       -> test headers (recursive)
#    tests/bin/            -> test binaries (generated)
#    obj/                  -> generated object files
#    third_party/Unity/    -> Unity framework
# ============================================================================


NAME          := woody_woodpacker


CC            := cc
CFLAGS        := -Wall -Wextra -Werror
ASFLAGS       := -f elf64


SRCS_DIR      := srcs
INC_DIR       := includes
OBJ_DIR       := obj
TESTS_DIR     := tests
TESTS_SRCS_DIR:= $(TESTS_DIR)/srcs
TESTS_INC_DIR := $(TESTS_DIR)/includes
TESTS_BIN_DIR := $(TESTS_DIR)/bin


# --- Unity ------------------------------------------------------------------
UNITY_DIR     := third_party/Unity/src
UNITY_SRC     := $(UNITY_DIR)/unity.c
UNITY_INC     := -I$(UNITY_DIR)


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
TESTS_SRCS    := $(shell find $(TESTS_SRCS_DIR) -type f -name '*.c' 2>/dev/null)
TESTS_BINS    := $(patsubst $(TESTS_SRCS_DIR)/%.c,$(TESTS_BIN_DIR)/%,$(TESTS_SRCS))


# --- Include directories ----------------------------------------------------
CPPFLAGS      := -I$(INC_DIR) -I$(LIBFT_DIR)/includes -I$(TESTS_INC_DIR) $(UNITY_INC)
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
#  Tests (Unity)
# ============================================================================

TESTS_SRCS    := $(shell find $(TESTS_SRCS_DIR) -type f -name '*.c' 2>/dev/null)
TEST_BIN      := $(TESTS_BIN_DIR)/run_tests

.PHONY: tests test

tests: force_tests
	@echo "$(GREEN)[✓] unit tests compiled (Unity)$(RESET)"

force_tests: $(OBJS_NO_MAIN) $(LIBFT) $(UNITY_SRC)
	@mkdir -p $(TESTS_BIN_DIR)
	@$(CC) $(CFLAGS) $(CPPFLAGS) $(TESTS_SRCS) $(UNITY_SRC) $(OBJS_NO_MAIN) $(LIBFT) -o $(TEST_BIN)

test: tests
	@echo ""
	@echo "$(CYAN)$(BOLD)>>> Running all unit tests$(RESET)"
	@./$(TEST_BIN)


# ============================================================================
#  Cleanup
# ============================================================================


clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)[✓] object files removed$(RESET)"


clean_tests:
	@rm -rf $(TESTS_BIN_DIR)
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
