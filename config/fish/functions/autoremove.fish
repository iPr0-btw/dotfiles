function autoremove --wraps='yes | yay -Scc' --description 'alias autoremove=yes | yay -Scc'
    yes | yay -Rns $(yay -Qtdq)
    yes | yay -Scc $argv
end
