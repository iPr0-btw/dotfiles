function autoremove --wraps='yes | yay -Scc' --description 'alias autoremove=yes | yay -Scc'
    yes | yay -Scc $argv
end
