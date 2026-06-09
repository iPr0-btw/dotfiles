function userstart --wraps='systemctl --user start' --wraps='systemctl --user enable --now' --description 'alias userstart=systemctl --user enable --now'
    systemctl --user enable --now $argv
end
