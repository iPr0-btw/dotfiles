function userstop --wraps='systemctl --user disable --now' --description 'alias userstop=systemctl --user disable --now'
    systemctl --user disable --now $argv
end
