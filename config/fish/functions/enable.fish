function enable --description 'alias enable=sudo systemctl enable'
    sudo systemctl enable --now $argv
end
