function l --wraps='ls -a' --wraps='lsd -a' --wraps='lsd -a || ls -a' --description 'alias l=lsd -a || ls -a'
    lsd -a || ls -a $argv
end
