# ============================================================================
#  woody_woodpacker — Makefile
#  Arborescence attendue :
#    srcs/      -> fichiers sources .c (et .s si un stub asm est ajouté)
#    includes/  -> fichiers d'en-tête .h
#    libft/     -> bibliothèque libft (srcs/ par domaine, includes/, libft.a)
#    tests/     -> sources de tests, compilés séparément via `make tests`
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

# Sources détectées automatiquement (le dossier peut encore évoluer)
SRCS_C        := $(wildcard $(SRCS_DIR)/*.c)
SRCS_S        := $(wildcard $(SRCS_DIR)/*.s)

OBJS_C        := $(patsubst $(SRCS_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS_C))
OBJS_S        := $(patsubst $(SRCS_DIR)/%.s,$(OBJ_DIR)/%.o,$(SRCS_S))
OBJS          := $(OBJS_C) $(OBJS_S)

# Fichiers de dépendances (générés pour les seules sources C)
DEPS          := $(OBJS_C:.o=.d)

TESTS_SRCS    := $(wildcard $(TESTS_DIR)/*.c)
TESTS_BINS    := $(patsubst $(TESTS_DIR)/%.c,$(TESTS_DIR)/%,$(TESTS_SRCS))

CPPFLAGS      := -I$(INC_DIR) -I$(LIBFT_DIR)/includes
DEPFLAGS      := -MMD -MP

# Assembleur utilisé pour les .s (nasm par défaut, adapter si besoin)
AS            := nasm

# Silence de la sortie du sous-make de la libft
MAKEFLAGS     += --no-print-directory

# --- Couleurs (facultatif, purement cosmétique) ----------------------------
GREEN         := \033[0;32m
RESET         := \033[0m

# ============================================================================
#  Règles principales
# ============================================================================

all: $(NAME)

$(NAME): $(LIBFT) $(OBJS)
	@$(CC) $(CFLAGS) $(OBJS) $(LIBFT) -o $(NAME)
	@echo "$(GREEN)[✓] $(NAME) compilé$(RESET)"

# Construction de la libft déléguée à son propre Makefile
$(LIBFT):
	@$(MAKE) -C $(LIBFT_DIR)

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c | $(OBJ_DIR)
	@$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPFLAGS) -c $< -o $@

$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.s | $(OBJ_DIR)
	@$(AS) $(ASFLAGS) $< -o $@

$(OBJ_DIR):
	@mkdir -p $(OBJ_DIR)

# ============================================================================
#  Tests (facultatif — compile chaque fichier de tests/ en binaire séparé)
# ============================================================================

tests: $(LIBFT) $(TESTS_BINS)

$(TESTS_DIR)/%: $(TESTS_DIR)/%.c
	@$(CC) $(CFLAGS) $(CPPFLAGS) $< $(LIBFT) -o $@

# ============================================================================
#  Nettoyage
# ============================================================================

clean:
	@$(MAKE) -C $(LIBFT_DIR) clean
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)[✓] objets supprimés$(RESET)"

fclean: clean
	@$(MAKE) -C $(LIBFT_DIR) fclean
	@rm -f $(NAME)
	@rm -f $(TESTS_BINS)
	@echo "$(GREEN)[✓] $(NAME) et binaires de tests supprimés$(RESET)"

re: fclean all

# Réintégration des dépendances d'en-têtes
-include $(DEPS)

.PHONY: all clean fclean re tests
