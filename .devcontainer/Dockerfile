FROM ubuntu:24.04

ENV DEBIAN_FRONTEND=noninteractive

RUN apt-get update && apt-get install -y \
    git \
    curl \
    wget \
    build-essential \
    binutils \
    clang \
    clangd \
    clang-format \
    bear \
    lldb \
    nasm \
    gdb \
    strace \
    ltrace \
    file \
    xxd \
    vim \
    python3 \
    python3-pip \
    openssh-client \
    zsh \
    zsh-autosuggestions \
    zsh-syntax-highlighting \
    sudo \
    ca-certificates \
    pkg-config \
	valgrind \
    && rm -rf /var/lib/apt/lists/*

# Utilisateur correspondant à ton environnement de développement
RUN useradd -m -s /usr/bin/zsh dev \
    && echo "dev ALL=(ALL) NOPASSWD:ALL" > /etc/sudoers.d/dev \
    && chmod 0440 /etc/sudoers.d/dev

# Config Zsh minimale du projet
COPY .devcontainer/.zshrc /home/dev/.zshrc
RUN chown dev:dev /home/dev/.zshrc

WORKDIR /workspace

USER dev

CMD ["/bin/zsh"]
