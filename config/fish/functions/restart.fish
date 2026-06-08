function restart --description 'alias restart sudo systemctl restart'
    sudo systemctl restart $argv
end
