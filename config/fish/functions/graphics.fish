function graphics --wraps='sudo envycontrol --verbose -s' --description 'alias graphics=sudo envycontrol --verbose -s'
    sudo envycontrol --verbose -s $argv
end
