function dr --wraps='sudo systemctl daemon-reload' --description 'alias dr=sudo systemctl daemon-reload'
    sudo systemctl daemon-reload $argv
end
