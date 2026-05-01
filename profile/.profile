# ~/.profile: POSIX environment variables for all login shells.
# Sourced by: bash (.bash_profile or login), fish (via config.fish), sh

if [ -z "$__DOTFILES_PROFILE_SOURCED" ]; then
export __DOTFILES_PROFILE_SOURCED=1

# the default umask is set in /etc/profile; for setting the umask
# for ssh logins, install and configure the libpam-umask package.
#umask 022

# set PATH so it includes user's private bin if it exists
if [ -d "$HOME/.local/bin" ] ; then
    case ":$PATH:" in
        *:"$HOME/.local/bin":*) ;;
        *) PATH="$HOME/.local/bin:$PATH" ;;
    esac
fi

if [ -d "$HOME/bin" ] ; then
    case ":$PATH:" in
        *:"$HOME/bin":*) ;;
        *) PATH="$HOME/bin:$PATH" ;;
    esac
fi

# opencode
if [ -d "$HOME/.opencode/bin" ] ; then
    case ":$PATH:" in
        *:"$HOME/.opencode/bin":*) ;;
        *) PATH="$HOME/.opencode/bin:$PATH" ;;
    esac
fi

[ -f "$HOME/.ghcup/env" ] && . "$HOME/.ghcup/env" # ghcup-env

# API keys and secrets
[ -f "$HOME/.profile_secrets" ] && . "$HOME/.profile_secrets"

# if running bash, include .bashrc for aliases and interactive settings
if [ -n "$BASH_VERSION" ]; then
    if [ -f "$HOME/.bashrc" ]; then
        . "$HOME/.bashrc"
    fi
fi

fi