function lp --wraps='lspci -k' --description 'alias lp=lspci -k'
    lspci -k $argv
end
