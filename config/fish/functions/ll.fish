function ll --wraps='ls -lah' --wraps='lsdf -a || ls -la' --wraps='lsd -a || ls -la' --wraps='lsd -la || ls -la' --description 'alias ll=lsd -la || ls -la'
    lsd -la $argv || ls -la $argv
end
