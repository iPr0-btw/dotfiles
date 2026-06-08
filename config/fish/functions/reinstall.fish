function reinstall --wraps='sudo pacman --noconfirm -S' --description 'alias reinstall=sudo pacman --noconfirm -S'
    sudo pacman --noconfirm -S $argv
end
