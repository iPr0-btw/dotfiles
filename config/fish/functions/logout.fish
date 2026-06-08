function logout --wraps='loginctl kill-user $USER' --description 'alias logout=loginctl kill-user $USER'
    loginctl kill-user $USER $argv
end
