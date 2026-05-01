if status is-login
    # PATH
    fish_add_path ~/bin ~/.local/bin ~/.opencode/bin

    # ghcup & cabal
    [ -f ~/.ghcup/env ]; and bass source ~/.ghcup/env

    # secrets
    [ -f ~/.profile_secrets ]; and bass source ~/.profile_secrets
end

# Pure prompt is loaded via conf.d/pure.fish
