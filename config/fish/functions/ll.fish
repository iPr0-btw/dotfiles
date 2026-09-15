function ll --wraps='ls -lah' --wraps='lsdf -a || ls -la' --wraps='lsd -a || ls -la' --description 'alias ll=lsd -a || ls -la'
    lsd -a || ls -la $argv
end
