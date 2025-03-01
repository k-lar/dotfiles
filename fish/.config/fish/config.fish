if status is-interactive
    # Commands to run in interactive sessions can go here
    fish_vi_key_bindings

    # Disable fish help message
    set -U fish_greeting

    # Disable Ctrl+S freeze
    stty -ixon

    # Source fish completions
    if test -f /usr/share/fish/vendor_completions.d
        source /usr/share/fish/vendor_completions.d
    end

    # Source my custom functions
    source $HOME/.dotfiles/fish/.config/fish/functions/functions.fish

    # Set the cursor shapes for the different vi modes.
    set fish_cursor_default       block
    set fish_cursor_insert        line        blink
    set fish_cursor_replace_one   underscore  blink
    set fish_cursor_replace       underscore  blink
    set fish_cursor_visual        block

    # PATH variable
    set -gx PATH "$HOME/.dotfiles/bin" "$HOME/.local/bin" $PATH

    # History configuration (unlimited history)
    set -gx HISTFILE "$HOME/.local/share/fish/fish_history"
    set -gx HISTORY_MAX 0
    set -gx HISTORY_TIMESTAMP true

    # Colorful man pages
    set -gx LESS_TERMCAP_mb (echo -e '\e[1;32m')
    set -gx LESS_TERMCAP_md (echo -e '\e[1;32m')
    set -gx LESS_TERMCAP_me (echo -e '\e[0m')
    set -gx LESS_TERMCAP_se (echo -e '\e[0m')
    set -gx LESS_TERMCAP_so (echo -e '\e[01;33m')
    set -gx LESS_TERMCAP_ue (echo -e '\e[0m')
    set -gx LESS_TERMCAP_us (echo -e '\e[1;4;31m')

    # My aliases
    source $HOME/.dotfiles/bash/.bash_aliases

    # Make !! work in fish
    function last_history_item
        echo $history[1]
    end
    abbr -a !! --position anywhere --function last_history_item

    if type -q tmux; and not set -q TMUX; and not set -q VIM; and not set -q INSIDE_EMACS
        tmux_start
    end

    # System exports
    set -gx EDITOR "/usr/bin/nvim"

    # Emacs vterm support
    if test "$INSIDE_EMACS" = "vterm"
        function clear
            vterm_printf "51;Evterm-clear-scrollback"
            tput clear
        end
    end

    # Turn off autosuggestions
    set fish_autosuggestion_enabled 0

    # Turn off syntax highlighting
    for color in fish_color_command fish_color_comment fish_color_end \
        fish_color_escape fish_color_match fish_color_operator        \
        fish_color_param fish_color_search_match fish_color_quote     \
        fish_pager_color_description fish_pager_color_prefix
        set $color normal
    end

    # Set some syntax highlighting colors myself
    set fish_color_normal normal
    set fish_color_redirection normal
    set fish_color_command normal
    set fish_color_param normal
    set fish_color_quote B8BB26
    set fish_color_end FD7F19
    set fish_color_error red
    set fish_color_comment 8A7C6E
    set fish_color_operator 83A598
    set fish_color_escape 83A598
    set fish_color_cwd green
    set fish_color_cwd_root red
    set fish_color_cancel --reverse
    set fish_color_autosuggestion 8A7C6E
    set fish_color_match --background 3C3836
    set fish_pager_color_selected_background --reverse

    # Disable underlining of path
    set fish_color_valid_path

    # Set the color of the progress bar in the pager
    set fish_pager_color_progress normal

    # Set the color of the completion menu selection
    set fish_color_selection --background normal

    # Programs to run at start
    if type -q fastfetch
        fastfetch
    end

    if type -q brem
        brem --show
    end
end

function fish_user_key_bindings
    bind -M insert \cw backward-kill-word
end

function fish_mode_prompt
  # Empty function body to disable vim mode indicator
end

function fish_prompt
    set -l cwd (pwd)
    if test "$cwd" = $HOME
        set display "~"
    else
        set display (basename "$cwd")
    end

    if test "$fish_key_bindings" = "fish_vi_key_bindings"
        switch $fish_bind_mode
            case default
                set_color green
                printf "["
                set_color normal
                printf '%s' $display
                set_color green
                printf "]"

            case insert
                set_color blue
                printf "["
                set_color normal
                printf '%s' $display
                set_color blue
                printf "]"

            case replace
                set_color red
                printf "["
                set_color normal
                printf '%s' $display
                set_color red
                printf "]"

            case replace_one
                set_color red
                printf "["
                set_color normal
                printf '%s' $display
                set_color red
                printf "]"

            case visual
                set_color FF875F
                printf "["
                set_color normal
                printf '%s' $display
                set_color FF875F
                printf "]"

        end
        set_color normal
        printf " "
    end

    # No colors prompt
    # printf "[%s] %s" $display (set_color --bold yellow)"λ "(set_color normal)

    printf "%s" (set_color --bold yellow)"λ "(set_color normal)
end
