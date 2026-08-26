function update --wraps='topgrade --disable shell -y' --description 'alias update=topgrade --disable shell -y'
    yay -Syu --noconfirm $argv
    notify-send system updated successfully. $argv
end
