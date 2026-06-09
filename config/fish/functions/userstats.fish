function userstats --wraps='systemctl --user status' --description 'alias userstats=systemctl --user status'
    systemctl --user status $argv
end
