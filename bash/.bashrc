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

# BEGIN opam configuration
# This is useful if you're using opam as it adds:
#   - the correct directories to the PATH
#   - auto-completion for the opam binary
# This section can be safely removed at any time if needed.
test -r '/home/aemaeth/.opam/opam-init/init.sh' && . '/home/aemaeth/.opam/opam-init/init.sh' > /dev/null 2> /dev/null || true
# END opam configuration
