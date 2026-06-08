function stats --wraps='sudo systemctl status' --description 'alias stats=sudo systemctl status'
    sudo systemctl status $argv
end
