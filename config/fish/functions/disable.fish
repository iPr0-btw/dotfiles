function disable --description 'alias disable=sudo systemctl disable'
    sudo systemctl disable --now $argv
end
