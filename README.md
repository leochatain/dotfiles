# dotfiles

Personal configuration files for git, tmux, vim, zsh, and ghostty.

## Features

### Zsh
- **Powerlevel10k** - Fast, customizable prompt with git status and context info
  - Requires a [Nerd Font](https://www.nerdfonts.com/) for icons
  - Instant prompt for zero-lag experience
- **oh-my-zsh** with curated plugins (gitfast, colored-man-pages, python)
- **fzf** - Fuzzy finder for command history, files, and directories
  - Integrated with **fd** for faster file searching
  - Smart previews using **bat** (files) and **eza** (directories)
- **fd** - Fast file finder (replaces `find`)
- **bat** - Syntax-highlighted file viewer (replaces `cat`)
- **eza** - Modern ls replacement with icons and git integration
- **zsh-autosuggestions** - Command suggestions based on history
- **zsh-syntax-highlighting** - Real-time syntax highlighting
- Cross-platform support (macOS and Linux)
- Optimized for performance (lazy loading patterns for less often used tools like gcloud)

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
- **delta** - Syntax-highlighted diffs with side-by-side view
- Helpful aliases (`lg`, `st`, `amend`, `undo`, `uncommit`)
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
   brew install stow fzf fd bat eza git-delta zsh-autosuggestions zsh-syntax-highlighting powerlevel10k font-meslo-lg-nerd-font
   ```

   On Linux:
   ```bash
   # Debian/Ubuntu
   sudo apt install stow fzf fd-find bat git-delta

   # Install eza (not in default repos)
   # See: https://github.com/eza-community/eza/blob/main/INSTALL.md

   # Install zsh plugins
   git clone https://github.com/zsh-users/zsh-autosuggestions ~/.oh-my-zsh/custom/plugins/zsh-autosuggestions
   git clone https://github.com/zsh-users/zsh-syntax-highlighting.git ~/.oh-my-zsh/custom/plugins/zsh-syntax-highlighting

   # Install Powerlevel10k
   git clone --depth=1 https://github.com/romkatv/powerlevel10k.git ${ZSH_CUSTOM:-$HOME/.oh-my-zsh/custom}/themes/powerlevel10k

   # Install MesloLGS Nerd Font
   # Download from: https://github.com/romkatv/powerlevel10k#fonts
   # Or install via your distro's package manager if available
   ```

   **Note:** On some Linux distributions, tools have different names:
   - `bat` is installed as `batcat`
   - `fd` is installed as `fd-find`

   Create symlinks if needed:
   ```bash
   mkdir -p ~/.local/bin
   ln -s /usr/bin/batcat ~/.local/bin/bat
   ln -s /usr/bin/fdfind ~/.local/bin/fd
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

3. **(Optional) Ghostty terminal emulator (macOS instructions):**

   [Ghostty](https://ghostty.org/) is a modern, GPU-accelerated terminal emulator. If you use it:
   ```bash
   brew install --cask ghostty
   stow ghostty
   ```

   **Note:** The ghostty config is pre-configured to use MesloLGS Nerd Font for optimal display with Powerlevel10k.

4. Reload shell:
   ```bash
   source ~/.zshrc
   ```

## Platform Support

Configurations automatically detect and adapt to:
- **macOS** - Uses Homebrew paths, native clipboard
- **Linux** - Uses standard paths, X11/Wayland clipboard

