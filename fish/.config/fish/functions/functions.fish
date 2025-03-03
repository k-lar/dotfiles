# A better man function
function better_man
    # Try to display the man page for the given command
    command man $argv[1] 2> /dev/null

    # If the man page is not found, display the help message for the command
    or begin
        if type -q $argv[1]
            $argv[1] --help 2>&1
        else
            echo "Command '$argv[1]' not found"
        end
    end
end

# Test true colors in terminal
function test_truecolor
    awk 'BEGIN{
        s="                                                                             ";
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

            # If the file contains only "# TODO - $date\n\n- [ ] \n", delete it
            if string match -q -- (printf '# TODO - %s\n\n- [ ] \n' "$date") (cat "$HOME/todos/$date/todo.md")
                rm -rf "$HOME/todos/$date"
            end
        else
            mkdir -p "$HOME/todos/$date"
            echo -e "# TODO - $date\n\n- [ ] \n" >> "$HOME/todos/$date/todo.md"
            $EDITOR "$HOME/todos/$date/todo.md"

            # If the file contains only "# TODO - $date\n\n- [ ] \n", delete it
            if string match -q -- (printf '# TODO - %s\n\n- [ ] \n' "$date") (cat "$HOME/todos/$date/todo.md")
                rm -rf "$HOME/todos/$date"
            end
        end
    end
end

# Run tmux at start

function tmux_start
    tmux has-session -t dev
    if test $status -ne 0
        tmux new-session -s dev
    end

    tmux ls -F '#{session_attached} #{session_name}' | grep "1 * dev"
    if test $status -eq 0
        tmux new-session
    end

    tmux attach -t dev; exec tmux
end
