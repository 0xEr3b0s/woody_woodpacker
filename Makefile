# ============================================================================
#  woody_woodpacker — Makefile
#
#  Directory structure:
#    srcs/                 -> C and assembly source files
#    includes/             -> header files
#    obj/                  -> generated object files
# ============================================================================

NAME    := woody_woodpacker

CC      := cc
AS      := nasm

CFLAGS  := -Wall -Wextra -Werror
CPPFLAGS:= -Iincludes
ASFLAGS := -f elf64

SRCS    := $(wildcard srcs/*.c)
ASM     := $(wildcard srcs/*.s)
OBJS    := $(SRCS:srcs/%.c=obj/%.o) $(ASM:srcs/%.s=obj/%.o)
DEPS    := $(SRCS:srcs/%.c=obj/%.d)

# --- Colors -----------------------------------------------------------------

GREEN   := \033[0;32m
CYAN    := \033[0;36m
BOLD    := \033[1m
RESET   := \033[0m

# --- Compilation ------------------------------------------------------------

.PHONY: all clean fclean re

all: $(NAME)

$(NAME): $(OBJS)
	@printf "$(CYAN)$(BOLD)[ LINK ]$(RESET) %s\n" "$@"
	@$(CC) $(CFLAGS) $(OBJS) -o $@
	@printf "$(GREEN)$(BOLD)[  OK  ]$(RESET) %s\n" "$@"

obj/%.o: srcs/%.c
	@mkdir -p obj
	@printf "$(CYAN)[  CC  ]$(RESET) %s\n" "$<"
	@$(CC) $(CFLAGS) $(CPPFLAGS) -MMD -MP -c $< -o $@

obj/%.o: srcs/%.s
	@mkdir -p obj
	@printf "$(CYAN)[ NASM ]$(RESET) %s\n" "$<"
	@$(AS) $(ASFLAGS) $< -o $@

# --- Cleanup ----------------------------------------------------------------

clean:
	@rm -rf obj
	@printf "$(GREEN)[ CLEAN ]$(RESET) objects removed\n"

fclean: clean
	@rm -f $(NAME)
	@printf "$(GREEN)[ CLEAN ]$(RESET) binary removed\n"

re: fclean all

# --- Dependencies -----------------------------------------------------------

-include $(DEPS)
