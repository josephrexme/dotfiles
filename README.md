# Dotfiles

My personal dotfiles configuration, managed with [GNU Stow](https://www.gnu.org/software/stow/).

## Overview

This repository contains configuration files for various tools like Zsh, Vim, Git, and Tmux. The dotfiles are organized into directories (packages) to be symlinked to the home directory using Stow.

## Prerequisites

- **GNU Stow**: Required to manage the symlinks.
  - MacOS: `brew install stow`
  - Debian/Ubuntu: `apt-get install stow`

## Installation

### 1. Clone the repository

```bash
git clone https://github.com/yourusername/dotfiles.git ~/dotfiles
cd ~/dotfiles
```

### 2. Symlink Dotfiles with Stow

Use `stow` to symlink the configurations you want. The repository is structured so that each top-level folder corresponds to a package.

```bash
# Link all core packages
stow zsh vim git tmux ack

# Or link individually
stow zsh
stow vim
```

This will create symlinks in your home directory (e.g., `~/.zshrc` -> `~/dotfiles/zsh/.zshrc`).

### 3. Run Setup Script

The `script/setup` script is provided to automate package installation on fresh OS installs.
It runs on debian based Linux distributions and MacOS.

```bash
./script/setup
```

**What the script does:**
- **Installs System Packages**: (Linux only) Installs `zsh`, `vim`, `git`, `tmux`, etc. via `apt-get`.
- **Installs Prezto**: Clones the [Prezto](https://github.com/sorin-ionescu/prezto) repository for Zsh configuration.
- **Installs Vim-Plug**: Downloads [vim-plug](https://github.com/junegunn/vim-plug) for managing Vim plugins.
- **Symlinks Dotfiles**: Uses `stow` to link configuration packages.

## Directory Structure

- **zsh/**: Zsh configuration (`.zshrc`, `.zpreztorc`, `.zprofile`)
- **vim/**: Vim configuration (`.vimrc`)
- **git/**: Git configuration (`.gitconfig`, `.gitignore_global`)
- **tmux/**: Tmux configuration (`.tmux.conf`)
- **script/**: Setup automation scripts
