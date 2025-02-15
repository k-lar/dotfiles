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

    # Run tmux at start
    function tmux_start
        tmux has-session -t dev 2>/dev/null; or tmux new-session -s dev
        if tmux list-sessions | grep -q "dev";
            tmux attach -t dev
        else
            tmux new-session
        end
    end

    if type -q tmux; and not set -q TMUX; and not set -q VIM; and not set -q INSIDE_EMACS
        tmux_start
    end

    # System exports
    set -gx EDITOR "/usr/bin/nvim"

    # A better man function
    function better_man
        command man $argv[1] 2>/dev/null; or $argv[1] --help 2>&1 | less
    end

    # Test true colors in terminal
    function test_truecolor
        awk 'BEGIN{
            s="/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/\\/";
            for (colnum = 0; colnum<77; colnum++) {
                r = 255-(colnum*255/76);
                g = (colnum*510/76);
                b = (colnum*255/76);
                if (g>255) g = 510-g;
                printf "\033[48;2;%d;%d;%dm", r,g,b;
                printf "\033[38;2;%d;%d;%dm", 255-r,255-g,255-b;
                printf "%s\033[0m", substr(s,colnum+1,1);
            }
            printf "\n";
        }'
    end

    # Make temp dir for testing and misc
    function cdtemp
        cd (mktemp -d)
    end

    # Daily todo
    function todo
        if test "$argv[1]" = "search"
            set selected_file (fzf --walker-root=$HOME/todos/)
            if test $status -eq 0
                $EDITOR "$selected_file"
            end
        else
            set date (date --iso-8601)
            if test -d "$HOME/todos/$date"
                if not test -s "$HOME/todos/$date/todo.md"
                    echo -e "# TODO - $date\n\n- [ ] \n" >> "$HOME/todos/$date/todo.md"
                end
                $EDITOR "$HOME/todos/$date/todo.md"
            else
                mkdir -p "$HOME/todos/$date"
                echo -e "# TODO - $date\n\n- [ ] \n" >> "$HOME/todos/$date/todo.md"
                $EDITOR "$HOME/todos/$date/todo.md"
            end
        end
    end

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

    # Set some syntax highlighting colors myself (I don't like any other colors)
    set fish_color_autosuggestion white
    set fish_color_error red

    # Disable underlining of path
    set fish_color_valid_path

    # Set the color of the progress bar in the pager
    set fish_pager_color_progress white

    # Set the color of the completion menu selection
    set fish_color_selection --background white

    # Programs to run at start
    if type -q fastfetch
        fastfetch
    end

    if type -q brem
        brem --show
    end
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
