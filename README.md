# dotfiles

Personal configuration files for git, tmux, vim, and zsh.

## Installation

1. Clone this repository:
   ```bash
   git clone https://github.com/leochatain/dotfiles.git ~/.dotfiles
   cd ~/.dotfiles
   ```

2. Install [GNU Stow](https://www.gnu.org/software/stow/):
   ```bash
   brew install stow
   ```

3. Backup existing configs and create symlinks:
   ```bash
   # Stow individual packages
   stow git tmux vim zsh

   # Or stow everything
   stow */
   ```

4. Reload shell:
   ```bash
   source ~/.zshrc
   ```

## Notes

- Uses [oh-my-zsh](https://ohmyz.sh/) for zsh configuration
- Configured for macOS (Homebrew paths, clipboard integration)
- Tmux prefix is Ctrl+A (not Ctrl+B)
