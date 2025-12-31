# ============================================================================
# oh-my-zsh Configuration
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="kolo"
COMPLETION_WAITING_DOTS="true"
plugins=(git)

source $ZSH/oh-my-zsh.sh


# ============================================================================
# PATH Modifications
# ============================================================================
export PATH="/opt/homebrew/bin:$PATH"
export PATH="/opt/homebrew/opt/openjdk/bin:$PATH"
export PATH="$HOME/.cargo/bin:$PATH"


# ============================================================================
# Environment Variables
# ============================================================================
export JAVA_HOME="/opt/homebrew/opt/openjdk"


# ============================================================================
# Aliases
# ============================================================================
alias python="python3"


# ============================================================================
# External Tool Configurations
# ============================================================================

# Google Cloud SDK
if [ -f "$HOME/Downloads/google-cloud-sdk/path.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/path.zsh.inc"; fi
if [ -f "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc" ]; then . "$HOME/Downloads/google-cloud-sdk/completion.zsh.inc"; fi
