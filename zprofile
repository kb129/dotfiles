if [ -f /opt/homebrew/bin/brew ]; then
    eval "$(/opt/homebrew/bin/brew shellenv)"
fi

# Load .zsh_conda
if [ -f ~/.zsh_conda ]; then
    source ~/.zsh_conda
fi