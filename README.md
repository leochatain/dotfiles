# dotfiles

Personal configuration files for git, tmux, vim, and zsh.

## Features

### Zsh
- **oh-my-zsh** with curated plugins (gitfast, colored-man-pages, python)
- **fzf** - Fuzzy finder for command history, files, and directories
- **zsh-autosuggestions** - Command suggestions based on history
- **zsh-syntax-highlighting** - Real-time syntax highlighting
- Cross-platform support (macOS and Linux)
- Optimized for performance

### Tmux
- **Prefix:** `Ctrl+A` (instead of default Ctrl+B)
- **Vi-mode** navigation and copy mode
- **Ergonomic keybindings:**
  - `h/j/k/l` - Navigate panes
  - `Ctrl+h/j/k/l` - Resize panes (keep Ctrl pressed after prefix)
  - `v` - Vertical split
  - `s` - Horizontal split
- True color support
- New windows/panes open in current directory

### Vim
- Cross-platform clipboard integration (macOS/Linux)
- Smart indentation (2 spaces)
- Enhanced search (incremental, smart case)
- Clean UI with line numbers

### Git
- Helpful aliases (`lg`, `st`, `amend`, `undo`, `review`)
- Better diff algorithm (histogram)
- Auto-prune on fetch
- Rebase by default on pull
- Rerere enabled for conflict resolution

## Installation

### Prerequisites

1. Install [oh-my-zsh](https://ohmyz.sh/):
   ```bash
   sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"
   ```

2. Install dependencies (macOS):
   ```bash
   brew install stow fzf zsh-autosuggestions zsh-syntax-highlighting
   ```

   On Linux:
   ```bash
   # Debian/Ubuntu
   sudo apt install stow fzf
   git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting
   ```

### Setup

1. Clone this repository:
   ```bash
   git clone https://github.com/leochatain/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Backup existing configs and create symlinks:
   ```bash
   # Stow individual packages
   stow git tmux vim zsh

   # Or stow everything
   stow */
   ```

3. Reload shell:
   ```bash
   source ~/.zshrc
   ```

## Platform Support

Configurations automatically detect and adapt to:
- **macOS** - Uses Homebrew paths, native clipboard
- **Linux** - Uses standard paths, X11/Wayland clipboard

