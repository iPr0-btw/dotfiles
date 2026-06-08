function remove --wraps='yay -R' --description 'alias remove=yay -R'
    yay --noconfirm -Rns $argv
end
