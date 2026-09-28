function autoremove --wraps='yes | yay -Scc' --description 'alias autoremove=yes | yay -Scc'
    yes | yay -Rns $(yay -Qtdq) yay -Scc $argv
end
