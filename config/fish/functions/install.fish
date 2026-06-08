function install --wraps='yay --noconfirm --needed -S' --description 'alias install=yay --noconfirm --needed -S'
    yay --noconfirm --needed -S $argv
end
