function wifi --wraps=impala --wraps='sudo impala' --description 'alias wifi=sudo impala'
    sudo impala $argv
end
