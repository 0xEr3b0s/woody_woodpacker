# ============================================================================
#  woody_woodpacker — Makefile
#  Structure attendue :
#    srcs/      -> fichiers sources .c (et .s si stub asm ajouté plus tard)
#    includes/  -> fichiers d'en-tête .h
#    tests/     -> sources de tests, compilés séparément via `make tests`
# ============================================================================

NAME        := woody_woodpacker

CC          := cc
CFLAGS      := -Wall -Wextra -Werror
ASFLAGS     := -f elf64

SRCS_DIR    := srcs
INC_DIR     := includes
OBJ_DIR     := obj
TESTS_DIR   := tests
TESTS_OBJ_DIR := $(OBJ_DIR)/tests

# Sources détectées automatiquement (le dossier peut encore évoluer)
SRCS_C      := $(wildcard $(SRCS_DIR)/*.c)
SRCS_S      := $(wildcard $(SRCS_DIR)/*.s)

OBJS_C      := $(patsubst $(SRCS_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS_C))
OBJS_S      := $(patsubst $(SRCS_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS_S))
OBJS        := $(OBJS_C) $(OBJS_S)

TESTS_SRCS  := $(wildcard $(TESTS_DIR)/*.c)
TESTS_BINS  := $(patsubst $(TESTS_DIR)/%.c,$(TESTS_DIR)/%,$(TESTS_SRCS))

CPPFLAGS    := -I$(INC_DIR)

# Assembleur utilisé pour les .s (nasm par défaut, adapter si besoin)
AS          := nasm

# --- Couleurs (facultatif, purement cosmétique) ----------------------------
GREEN       := \033[0;32m
RESET       := \033[0m

# ============================================================================
#  Règles principales
# ============================================================================

all: $(NAME)

$(NAME): $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) -o $(NAME)
	@echo "$(GREEN)[✓] $(NAME) compilé$(RESET)"

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) $(CPPFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJ_DIR)
	@$(AS) $(ASFLAGS) $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# ============================================================================
#  Tests (facultatif — compile chaque fichier de tests/ en binaire séparé)
# ============================================================================

tests: $(TESTS_BINS)

$(TESTS_DIR)/%: $(TESTS_DIR)/%.c
	@$(CC) $(CFLAGS) $(CPPFLAGS) $< -o $@

# ============================================================================
#  Nettoyage
# ============================================================================

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)[✓] objets supprimés$(RESET)"

fclean: clean
	@rm -f $(NAME)
	@rm -f $(TESTS_BINS)
	@echo "$(GREEN)[✓] $(NAME) et binaires de tests supprimés$(RESET)"

re: fclean all

.PHONY: all clean fclean re tests
