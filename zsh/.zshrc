# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# ============================================================================
# Platform Configuration
# ============================================================================
# Cache brew prefix for performance (avoid multiple brew --prefix calls)
if [[ "$OSTYPE" == "darwin"* ]]; then
  export BREW_PREFIX="/opt/homebrew"
fi


# ============================================================================
# oh-my-zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
# Note: ZSH_THEME is disabled because we're using Powerlevel10k installed via Homebrew
# (sourced manually at the end of this file instead of through Oh My Zsh's theme system)
# Previous theme was "kolo" - restore this if you uninstall Powerlevel10k
ZSH_THEME=""
COMPLETION_WAITING_DOTS="true"
# Note: zsh-autosuggestions and zsh-syntax-highlighting are NOT in the plugins array
# because they were installed via Homebrew and are sourced manually at the end of this file
plugins=(gitfast colored-man-pages python)

source $ZSH/oh-my-zsh.sh


# ============================================================================
# History Configuration
# ============================================================================
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt SHARE_HISTORY          # Share history between sessions
setopt HIST_IGNORE_DUPS       # Don't record duplicates
setopt HIST_IGNORE_SPACE      # Don't record commands starting with space
setopt HIST_VERIFY            # Show command before running from history


# ============================================================================
# Completion Settings
# ============================================================================
setopt COMPLETE_IN_WORD       # Complete from both ends of word
setopt ALWAYS_TO_END          # Move cursor to end after completion
setopt AUTO_MENU              # Show menu on successive tab press
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'  # Case-insensitive


# ============================================================================
# PATH Modifications
# ============================================================================
# Platform-specific paths
if [[ "$OSTYPE" == "darwin"* ]]; then
  # macOS (Homebrew)
  export PATH="$BREW_PREFIX/bin:$PATH"
  export PATH="$BREW_PREFIX/opt/openjdk/bin:$PATH"
  export JAVA_HOME="$BREW_PREFIX/opt/openjdk"
elif [[ "$OSTYPE" == "linux-gnu"* ]]; then
  # Linux - add your Linux-specific paths here if needed
  # Example: export PATH="/usr/local/bin:$PATH"
  :
fi

# Common paths (all platforms)
export PATH="$HOME/.cargo/bin:$PATH"


# ============================================================================
# Aliases
# ============================================================================
alias python="python3"
alias ll="eza --long --no-time --no-permissions --no-filesize --no-user --icons --git"
alias lt="eza --tree --level=2"

# bat - Better cat with syntax highlighting
if command -v bat &> /dev/null; then
  alias cat="bat"
  export BAT_THEME="1337"
fi


# ============================================================================
# External Tool Configurations
# ============================================================================

# --- fzf + fd Integration ---
# Use fd instead of find for better performance and smarter defaults
# fd automatically respects .gitignore and is much faster

# Default command for fzf (Ctrl+T): find files and directories
export FZF_DEFAULT_COMMAND="fd --hidden --strip-cwd-prefix --exclude .git"
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

# Preview command: show directory tree with eza or file content with bat
export _fzf_preview_cmd="if [ -d {} ]; then eza -a --tree --color=always {} | head -200; else bat -n --color=always --line-range :500 {}; fi"

# Ctrl+T options: fuzzy find files/directories with preview
export FZF_CTRL_T_OPTS="
  --preview '$_fzf_preview_cmd'
  --preview-window right:60%:wrap
  --bind 'ctrl-/:toggle-preview'
"

# Alt+C command: find directories only
export FZF_ALT_C_COMMAND="fd --type=d --hidden --strip-cwd-prefix --exclude .git"

# Alt+C options: directory navigation with tree preview
export FZF_ALT_C_OPTS="
  --preview 'eza -a --tree --color=always {} | head -200'
  --preview-window right:60%:wrap
  --bind 'ctrl-/:toggle-preview'
"

# Context-aware fzf completions (triggered with **)
# Provides custom previews based on the command being used
_fzf_comprun() {
  local command=$1
  shift

  case "$command" in
    cd)           fzf --preview 'eza -a --tree --color=always {} | head -200' "$@" ;;
    export|unset) fzf --preview "eval 'echo \$'{}"         "$@" ;;
    ssh)          fzf --preview 'dig {}'                   "$@" ;;
    *)            fzf --preview "bat -n --color=always --line-range :500 {}" "$@" ;;
  esac
}

# Use fd for generating path completions (vim **<TAB>, cat **<TAB>, etc.)
_fzf_compgen_path() {
  fd --hidden --exclude .git . "$1"
}

# Use fd for generating directory completions (cd **<TAB>)
_fzf_compgen_dir() {
  fd --type=d --hidden --exclude .git . "$1"
}


# --- Google Cloud SDK (Lazy Loaded) ---
# Performance optimization: Google Cloud SDK adds ~210ms to shell startup.
# Lazy loading defers initialization until first use, improving terminal startup time.
#
# How it works:
#   1. On shell startup, we define placeholder functions for gcloud, gsutil, and bq
#   2. These functions are lightweight and add <1ms to startup
#   3. When you first run any of these commands, the wrapper function:
#      - Removes itself (unfunction)
#      - Loads the real Google Cloud SDK (path and completions)
#      - Executes your original command
#   4. All subsequent calls use the real commands directly with full functionality
#
# Trade-offs:
#   - Faster startup: Saves ~210ms every time you open a terminal
#   - First-use delay: The first gcloud/gsutil/bq command will be ~210ms slower
#   - No tab completion until first use of any gcloud command
#
# To undo this optimization and load Google Cloud SDK immediately:
#   1. Comment out the functions below (lines 145-173)
#   2. Uncomment these two lines:
#      # if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
#      # if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi
#   3. Restart your terminal or run: source ~/.zshrc

# Lazy load function for Google Cloud SDK
_load_google_cloud_sdk() {
  # Only load once, even if multiple commands are called
  if [ -z "$_GCLOUD_SDK_LOADED" ]; then
    [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ] && source "$HOME/google-cloud-sdk/path.zsh.inc"
    [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ] && source "$HOME/google-cloud-sdk/completion.zsh.inc"
    export _GCLOUD_SDK_LOADED=1
  fi
}

# Wrapper functions that trigger lazy loading on first use
gcloud() {
  unfunction gcloud gsutil bq  # Remove all wrapper functions
  _load_google_cloud_sdk
  gcloud "$@"  # Call the real gcloud command
}

gsutil() {
  unfunction gcloud gsutil bq
  _load_google_cloud_sdk
  gsutil "$@"
}

bq() {
  unfunction gcloud gsutil bq
  _load_google_cloud_sdk
  bq "$@"
}


# ============================================================================
# Shell Enhancements (must be at end)
# ============================================================================
# Note: The following plugins are installed via Homebrew and sourced manually.
# This is the correct approach for Homebrew installations - they should NOT be
# added to the Oh My Zsh plugins array above.

# fzf - Fuzzy finder
[ -f $BREW_PREFIX/opt/fzf/shell/completion.zsh ] && source $BREW_PREFIX/opt/fzf/shell/completion.zsh
[ -f $BREW_PREFIX/opt/fzf/shell/key-bindings.zsh ] && source $BREW_PREFIX/opt/fzf/shell/key-bindings.zsh

# zsh-autosuggestions (Homebrew installation)
[ -f $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# Powerlevel10k (Homebrew installation)
source /opt/homebrew/share/powerlevel10k/powerlevel10k.zsh-theme

# zsh-syntax-highlighting (Homebrew installation)
# IMPORTANT: Must be sourced at the very end of .zshrc per official documentation
[ -f $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

# To customize prompt, run `p10k configure` or edit ~/.dotfiles/zsh/.p10k.zsh.
[[ ! -f ~/.dotfiles/zsh/.p10k.zsh ]] || source ~/.dotfiles/zsh/.p10k.zsh
