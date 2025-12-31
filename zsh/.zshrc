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
ZSH_THEME="kolo"
COMPLETION_WAITING_DOTS="true"
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
alias ll="ls -lah"


# ============================================================================
# External Tool Configurations
# ============================================================================

# Google Cloud SDK
if [ -f "$HOME/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/google-cloud-sdk/completion.zsh.inc"; fi


# ============================================================================
# Shell Enhancements (must be at end)
# ============================================================================

# fzf - Fuzzy finder
[ -f $BREW_PREFIX/opt/fzf/shell/completion.zsh ] && source $BREW_PREFIX/opt/fzf/shell/completion.zsh
[ -f $BREW_PREFIX/opt/fzf/shell/key-bindings.zsh ] && source $BREW_PREFIX/opt/fzf/shell/key-bindings.zsh

# zsh-autosuggestions
[ -f $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh ] && source $BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh

# zsh-syntax-highlighting must be at the end of the file
[ -f $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ] && source $BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
