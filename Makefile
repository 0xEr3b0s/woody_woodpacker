# ============================================================================
#  woody_woodpacker — Makefile
#
#  Directory structure:
#    srcs/      -> C and assembly source files (recursive)
#    includes/  -> header files
#    libft/     -> libft library
#    tests/     -> test source files
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

# --- libft ------------------------------------------------------------------

LIBFT_DIR     := libft
LIBFT         := $(LIBFT_DIR)/libft.a

# --- Sources ----------------------------------------------------------------

# Recursively find all C and assembly source files
SRCS_C        := $(shell find $(SRCS_DIR) -type f -name '*.c')
SRCS_S        := $(shell find $(SRCS_DIR) -type f -name '*.s')

# Convert srcs/xxx.c to obj/xxx.o
OBJS_C        := $(patsubst $(SRCS_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS_C))
OBJS_S        := $(patsubst $(SRCS_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS_S))

OBJS          := $(OBJS_C) $(OBJS_S)

# --- Dependencies -----------------------------------------------------------

DEPS          := $(OBJS_C:.o=.d)

# --- Tests ------------------------------------------------------------------

TESTS_SRCS    := $(wildcard $(TESTS_DIR)/*.c)
TESTS_BINS    := $(patsubst $(TESTS_DIR)/%.c,$(TESTS_DIR)/%,$(TESTS_SRCS))

# --- Include directories ----------------------------------------------------

CPPFLAGS      := -I$(INC_DIR) -I$(LIBFT_DIR)/includes
DEPFLAGS      := -MMD -MP

# --- Assembler --------------------------------------------------------------

AS            := nasm

# --- Make flags -------------------------------------------------------------

MAKEFLAGS     += --no-print-directory

# --- Colors -----------------------------------------------------------------

GREEN         := \033[0;32m
RESET         := \033[0m


# ============================================================================
#  Main compilation rules
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
#  C source compilation
# ============================================================================

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c
	@mkdir -p $(dir $@)
	@$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPFLAGS) -c $< -o $@


# ============================================================================
#  Assembly source compilation
# ============================================================================

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.s
	@mkdir -p $(dir $@)
	@$(AS) $(ASFLAGS) $< -o $@


# ============================================================================
#  Tests
# ============================================================================

tests: $(LIBFT) $(TESTS_BINS)

$(TESTS_DIR)/%: $(TESTS_DIR)/%.c
	@$(CC) $(CFLAGS) $(CPPFLAGS) $< $(LIBFT) -o $@


# ============================================================================
#  Cleanup
# ============================================================================

clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)[✓] object files removed$(RESET)"

fclean: clean
	@$(MAKE) -C $(LIBFT_DIR) fclean
	@rm -f $(NAME)
	@rm -f $(TESTS_BINS)
	@echo "$(GREEN)[✓] $(NAME) and test binaries removed$(RESET)"

re: fclean all


# ============================================================================
#  Automatically generated dependencies
# ============================================================================

-include $(DEPS)


# ============================================================================
#  Phony targets
# ============================================================================

.PHONY: all clean fclean re tests
