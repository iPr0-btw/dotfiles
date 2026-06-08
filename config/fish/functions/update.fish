function update --wraps='topgrade --disable shell -y' --description 'alias update=topgrade --disable shell -y'
    topgrade --disable shell -y $argv
end
