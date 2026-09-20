# ============================================================================
#  libft — Makefile
#  Arborescence :
#    srcs/      -> sources .c, réparties par domaine (ctype, mem, string, ...)
#    includes/  -> en-tête libft.h
#    obj/       -> objets, arborescence calquée sur srcs/
# ============================================================================

NAME          := libft.a

CC            := cc
CFLAGS        := -Wall -Wextra -Werror
AR            := ar
ARFLAGS       := rcs

SRCS_DIR      := srcs
INC_DIR       := includes
OBJ_DIR       := obj

# Sources détectées automatiquement (un niveau de sous-dossier sous srcs/)
SRCS          := $(wildcard $(SRCS_DIR)/*/*.c)
OBJS          := $(patsubst $(SRCS_DIR)/%.c,$(OBJ_DIR)/%.o,$(SRCS))

# Fichiers de dépendances (en-têtes)
DEPS          := $(OBJS:.o=.d)

CPPFLAGS      := -I$(INC_DIR)
DEPFLAGS      := -MMD -MP

# --- Couleurs (facultatif, purement cosmétique) ----------------------------
GREEN         := \033[0;32m
RESET         := \033[0m

# ============================================================================
#  Règles principales
# ============================================================================

all: $(NAME)

$(NAME): $(OBJS)
	@$(AR) $(ARFLAGS) $(NAME) $(OBJS)
	@echo "$(GREEN)[✓] $(NAME) compilé$(RESET)"

# Le sous-dossier d'objets est créé à la volée pour épouser l'arborescence srcs/
$(OBJ_DIR)/%.o: $(SRCS_DIR)/%.c
	@mkdir -p $(@D)
	@$(CC) $(CFLAGS) $(CPPFLAGS) $(DEPFLAGS) -c $< -o $@

# ============================================================================
#  Nettoyage
# ============================================================================

clean:
	@rm -rf $(OBJ_DIR)
	@echo "$(GREEN)[✓] objets supprimés$(RESET)"

fclean: clean
	@rm -f $(NAME)
	@echo "$(GREEN)[✓] $(NAME) supprimé$(RESET)"

re: fclean all

# Réintégration des dépendances d'en-têtes
-include $(DEPS)

.PHONY: all clean fclean re
