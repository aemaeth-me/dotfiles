# .bashrc: bash-specific interactive shell configuration
# Sourced by: bash (interactive non-login), and .profile (for login shells)

if [ -z "$__DOTFILES_BASHRC_SOURCED" ]; then
export __DOTFILES_BASHRC_SOURCED=1

# Source .profile for environment variables (with guard against loops)
[ -f ~/.profile ] && . ~/.profile

# Source global definitions
if [ -f /etc/bashrc ]; then
    . /etc/bashrc
fi

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
    for rc in ~/.bashrc.d/*; do
        if [ -f "$rc" ]; then
            . "$rc"
        fi
    done
fi
unset rc

fi