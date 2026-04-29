# --- Catppuccin Mocha ---
# https://catppuccin.com/palette/mocha
# Rosewater: f5e0dc
# Flamingo:  f2cdcd
# Pink:      f5c2e7
# Mauve:     cba6f7
# Red:       f38ba8
# Maroon:    eba0ac
# Peach:     fab387
# Yellow:    f9e2af
# Green:     a6e3a1
# Teal:      94e2d5
# Sky:       89dceb
# Sapphire:  74c7ec
# Blue:      89b4fa
# Lavender:  b4befe
# Text:      cdd6f4
# Subtext1:  bac2de
# Subtext0:  a6adc8
# Overlay2:  9399b2
# Overlay1:  7f849c
# Overlay0:  6c7086
# Surface2:  585b70
# Surface1:  45475a
# Surface0:  313244
# Base:      1e1e2e
# Mantle:    181825
# Crust:     11111b

# Import environment variables from bash startup files
    bash -i -c '
        [ -f ~/.bash_profile ] && source ~/.bash_profile
        [ -f ~/.bashrc ] && source ~/.bashrc
        env
    ' 2>/dev/null | while read -l line
        set -l kv (string split -m 1 = $line)
        if test (count $kv) -eq 2
            and not contains $kv[1] PWD SHLVL _ SHELL HOME TERM
            set -gx $kv[1] $kv[2]
        end
    end

if status is-interactive
    # --- fzf keybindings (requires: sudo pacman -S fzf) ---
    # fzf --fish | source

    abbr -a e nvim
    abbr -a vi nvim
    abbr -a ls lsd
    abbr -a la lsd -la
    abbr -a ll lsd -l
    abbr -a mkdir mkdir -p

    # hydro prompt colors
    set -g hydro_color_pwd       blue
    set -g hydro_color_git       green
    set -g hydro_color_prompt    magenta
    set -g hydro_color_error     red
    set -g hydro_color_duration  9399b2
    set -g hydro_color_start     313244


end
