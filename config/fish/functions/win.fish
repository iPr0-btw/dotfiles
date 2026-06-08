function win --wraps='sudo efibootmgr -n 0 && reboot' --description 'alias win=sudo efibootmgr -n 0 && reboot'
    sudo efibootmgr -n 0 && reboot $argv
end
